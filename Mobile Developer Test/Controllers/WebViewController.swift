//
//  WebViewController.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//

import UIKit
import WebKit
class WebViewController: UIViewController,WKNavigationDelegate, URLSessionDelegate{
    @IBOutlet weak var web: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var url: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        let urlRequets  = URLRequest(url: URL(string: url)!)
        web.load(urlRequets)
        web.allowsBackForwardNavigationGestures = true
        web.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
   

}
