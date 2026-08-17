//
//  WebViewScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 17/08/2026.
//

import SwiftUI
import WebKit

struct WebViewScreen: View {
    
    let url: URL
    
    var body: some View {
        WebView(url: url)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: .bottom)
    }
}

struct WebView: UIViewRepresentable {
    
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.navigationDelegate = context.coordinator
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Prevent reloading unnecessarily
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            decisionHandler(.allow)
        }
    }
}

