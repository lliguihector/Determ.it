//
//  HelpWebVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 8/29/22.
//

import UIKit
import WebKit

class HelpWebVC: UIViewController, WKUIDelegate{
    
    var webView: WKWebView!
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        
     
      
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
    
    
    
}
