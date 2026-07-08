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
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
         .task {
                       
                        try? await player.play()
         }
         .onAppear {
             clipboardGuard.start()
         }
         .onDisappear {
             clipboardGuard.stop()
         }
            
    }
}

/*
 #Preview {
 YoutubePlayerScreen(url: "", player: 8)
 }
 */
 
