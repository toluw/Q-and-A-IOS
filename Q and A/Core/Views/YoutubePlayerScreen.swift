//
//  YoutubePlayerScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 07/07/2026.
//

import SwiftUI
import YouTubePlayerKit

struct YoutubePlayerScreen: View {
    
    let videoURLString: String
    
    @StateObject private var player: YouTubePlayer
    
    private let clipboardGuard = ClipboardGuard()
    
    @State private var showShareUnavailableToast = false
    
    
    init(videoURLString: String) {
        self.videoURLString = videoURLString
 
        // Configure the player to start playing as soon as it's ready,
        // rather than waiting for a manual `.play()` call.
        let parameters = YouTubePlayer.Parameters(
            autoPlay: true,
            showControls: true,
            showFullscreenButton: false
        )
 
        _player = StateObject(
            wrappedValue: YouTubePlayer(
                source: YouTubePlayer.Source(url:  URL(string:videoURLString)!),
                parameters: parameters
            )
        )
    }
    
   
   
    var body: some View {
        
        ZStack{
            VStack{
                
                Spacer()
                Spacer()
                
                YouTubePlayerView(player) { state in
                    switch state {
                    case .idle:
                        ProgressView()
                            
                    case .ready:
                        EmptyView()
                    case .error(let error):
                        VStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                            Text("Couldn't load video")
                                .font(.headline)
                            Text(String(describing: error))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                    }
                        }
                            .aspectRatio(16 / 9, contentMode: .fit)
                
                Spacer()
                Spacer()
                Spacer()
                
                
            }
            if showShareUnavailableToast {
                VStack {
                    Spacer()
                    toastView
                        .padding(.bottom, 32)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(1)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
         .animation(.easeInOut(duration: 0.25), value: showShareUnavailableToast)
         .onReceive(NotificationCenter.default.publisher(for: .shareSheetSuppressed)) { _ in
             showShareUnavailableToast = true
             Task {
                 try? await Task.sleep(for: .seconds(2))
                 showShareUnavailableToast = false
             }
         }
         .task {
                       
                        try? await player.play()
         }
         .onAppear {
             clipboardGuard.start()
             ShareSheetSuppressor.installOnce()
             ShareSheetSuppressor.isActive = true
         }
         .onDisappear {
             clipboardGuard.stop()
             ShareSheetSuppressor.isActive = false
         }
            
        
      
        
    }
    
    private var toastView: some View {
        Text("Sharing isn't available for this video")
            .font(.subheadline)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule().fill(Color.black.opacity(0.85))
            )
    }
}

/*
 #Preview {
 YoutubePlayerScreen(url: "", player: 8)
 }
 */
 
