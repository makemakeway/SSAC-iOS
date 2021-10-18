//
//  WebLinkViewController.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/18.
//

import UIKit
import WebKit

class WebLinkViewController: UIViewController {

    //MARK: Property
    
    @IBOutlet weak var webViewTitle: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    var webViewTitleString: String = ""
    
    
    //MARK: Method
    
    func loadUrl() {
        guard let url = URL(string: "https://google.co.kr") else {
            return
        }
        let req = URLRequest(url: url)
        
        webView.load(req)
        
    }
    
    func titleConfig() {
        webViewTitle.text = webViewTitleString
        webViewTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUrl()
        titleConfig()
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }

}

extension WebLinkViewController: WKUIDelegate, WKNavigationDelegate {

}
