//
//  ViewController.swift
//  obento
//
//  Created by masa on 2016/04/13.
//  Copyright © 2016年 com.tryworks-design. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面一杯にWebを表示
        let myWebView : UIWebView = UIWebView()
        myWebView.delegate = self
        myWebView.frame = self.view.bounds
        self.view.addSubview(myWebView)
        let url: NSURL = NSURL(string: "http://www.lunch-online.com/app/logon")!
        let request: NSURLRequest = NSURLRequest(URL: url)
        myWebView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

