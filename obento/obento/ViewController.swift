//
//  ViewController.swift
//  obento
//
//  Created by masa on 2016/04/13.
//  Copyright © 2016年 com.tryworks-design. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController,UIWebViewDelegate {
    
    let myWebView : UIWebView = UIWebView()
    let hiddenView :UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //画面一杯にWebを表示
        //myWebView : UIWebView = UIWebView()
        myWebView.delegate = self
        myWebView.frame = self.view.bounds
        self.view.addSubview(myWebView)
        let url: NSURL = NSURL(string: "http://www.lunch-online.com/app/logon")!
        let request: NSURLRequest = NSURLRequest(URL: url)
        myWebView.loadRequest(request)
        
        // ボタン作成
        let buttonTake = UIButton(frame: CGRect.init(x: 0, y: 0, width: 80, height: 40))
        buttonTake.backgroundColor = UIColor.init(colorLiteralRed: 0.3, green: 0.3, blue: 0.7, alpha: 0.8)
        
        // 角丸
        buttonTake.layer.cornerRadius = 5.0
        buttonTake.layer.masksToBounds = true
        
        // タイトルとか
        buttonTake.setTitle("ログイン", forState: UIControlState.Normal)
        //buttonTake.setTitle("タップされた", forState: UIControlState.Highlighted)
        //buttonTake.sizeToFit() // 文字の長さ、大きさにフィットするサイズ
        
        // 配置
        buttonTake.layer.position = CGPoint(x: 330, y: 22)
        buttonTake.addTarget(self, action: "setLogin:", forControlEvents: .TouchUpInside)
        self.view.addSubview(buttonTake)
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func setLogin ( sender:AnyObject) {
        
        myWebView.stringByEvaluatingJavaScriptFromString("document.getElementById('chumonshacd').value='2137038';document.getElementById('password').value='masa6031';var form = document.forms.item(0);form.submit();")!
        
    }
}

