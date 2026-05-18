//
//  PaystackWebView.swift
//  Q and A
//
//  Created by GIGL-PC on 17/05/2026.
//

import Foundation
import SwiftUI
import WebKit

struct PaystackWebView: UIViewRepresentable{
   
    @ObservedObject var viewModel: PaystackPaymentViewModel
    
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        

           let preferences = WKWebpagePreferences()
           preferences.allowsContentJavaScript = true

        configuration.defaultWebpagePreferences = preferences
        // Equivalent of domStorageEnabled
        configuration.websiteDataStore = WKWebsiteDataStore.default()
        // Allow JS to open windows (javaScriptCanOpenWindowsAutomatically)
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true // Equivalent of back key handling

        if let url = URL(string: viewModel.authorizationUrl) {
            webView.load(URLRequest(url: url))
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    // MARK: - Coordinator (WKNavigationDelegate)
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var viewModel: PaystackPaymentViewModel

        init(viewModel: PaystackPaymentViewModel) {
            self.viewModel = viewModel
        }

        // onPageStarted equivalent
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.viewModel.state.showLoader = true
            }
        }

        // onPageFinished equivalent
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.viewModel.state.showLoader = false
            }
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async {
                self.viewModel.state.showLoader = false
                
            }
        }

        // shouldOverrideUrlLoading equivalent
        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }

            let urlString = url.absoluteString

            // Paystack callback URL
            if urlString.contains(PaystackConstants.callbackURL) {
                viewModel.verifyPayment()
                decisionHandler(.cancel)
                return
            }

            // Paystack 3DS URL
            if urlString.contains(PaystackConstants.threeDSURL) {
                viewModel.verifyPayment()
                decisionHandler(.allow) // allow the 3DS page to load
                return
            }

            // Deep link: Opay
            if urlString.hasPrefix(PaystackConstants.opayScheme) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else {
                    // Fallback to App Store
                    if let appStoreURL = URL(string: PaystackConstants.opayPlayStore) {
                        UIApplication.shared.open(appStoreURL)
                    }
                }
                decisionHandler(.cancel)
                return
            }

            // Deep link: BTravel
            if urlString.hasPrefix(PaystackConstants.btravelScheme) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
                decisionHandler(.cancel)
                return
            }

            decisionHandler(.allow)
        }

        // WKUIDelegate: allows JS-opened windows (javaScriptCanOpenWindowsAutomatically)
        func webView(
            _ webView: WKWebView,
            createWebViewWith configuration: WKWebViewConfiguration,
            for navigationAction: WKNavigationAction,
            windowFeatures: WKWindowFeatures
        ) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
    }
    
    
    
}
