//
//  MemoViewController.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/15.
//  Copyright © 2017年 Komugi. All rights reserved.
//

import UIKit
import WebKit

class MemoViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, WKNavigationDelegate {

    //MARK: Properties
    
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet var webView: WKWebView!
    static var id: Int16?
    var data: JsonDatas?
    var activityIndicator: UIActivityIndicatorView!
    var memoContext :String?
    var memoAtFirst: String?
    let indicatorSize = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Common().checkNetworkStatus(sender: self)
        self.setObjectData(ID: MemoViewController.id!)
        self.setMemo(textView: memoTextView)
        self.setWebView()
        self.setNavigationItem()
        self.setKeyboard()
    }
    
    //MARK: Memo and Web Setting
    
    func setObjectData(ID: Int16) {
        data = JSONCoreData().getData(ID: ID)
    }
    
    func setMemo(textView: UITextView) {
        
        let id = MemoViewController.id
        if let id = id {
            memoAtFirst = JSONCoreData().showMemo(id: id)
        }
        memoTextView.text = memoAtFirst
        memoTextView.delegate = self
    }
    
    func setWebView() {
        self.webView.navigationDelegate = self
        DispatchQueue.main.async {
            let url = Common().stringToURL(string: self.data!.url)
            let request = URLRequest.init(url: url!)
            self.webView.load(request)
            self.setIndicatorView()
        }
    }
    
    func setNavigationItem() {
        if let name = data!.name {
            self.navigationItem.title = name
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopIndicator()
    }
    
    //MARK: TextField delegate

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3) {
            self.view.endEditing(true)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    //MARK: Keyboard setting

    func setKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let duration: Double = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
            
            UIView.animate(withDuration: duration, animations: { () -> Void in
                var frame = self.view.frame
                frame.origin.y = keyboardFrame.minY - self.view.frame.height
                self.view.frame = frame
            })
        }
    }

    @IBAction func saveMemoButton(_ sender: UIButton) {
        let memoContext = memoTextView.text
        if memoContext == nil {
            return
        }
        if memoAtFirst == nil {
            JSONCoreData().addMemo(id: MemoViewController.id, memo: memoContext)
        }
        else {
            JSONCoreData().updateMemoMemo(id: MemoViewController.id, memo: memoContext!)
        }
        memoTextView.resignFirstResponder()
    }
    
    //MARK: Activity Indicator related
    
    func setIndicatorView() {
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:
            UIActivityIndicatorViewStyle.gray)
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: indicatorSize, height: indicatorSize)
        self.activityIndicator.center = CGPoint.init(x: webView.frame.size.width/2, y: webView.frame.size.height/2)
        self.activityIndicator.hidesWhenStopped = true
        webView.addSubview(self.activityIndicator)
        
        playIndicator()
    }
    
    func playIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    func stopIndicator() {
        self.activityIndicator.stopAnimating()
    }
}
