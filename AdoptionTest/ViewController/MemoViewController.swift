//
//  MemoViewController.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/15.
//  Copyright © 2017年 Komugi. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{

    //MARK: Properties
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var webView: UIWebView!
    static var id: Int16?
    static var url: URL?
    static var name: String?
    var activityIndicator: UIActivityIndicatorView!
    var memoContext :String?
    var memoAtFirst: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setMemo(textView: memoTextView)
        self.setWebView()
        self.setNavigationItem()
        self.setKeyboard()
        setIndicatorView()
    }
    
    //MARK: Memo and Web Setting
    
    func setMemo(textView: UITextView) {
        
        let id = MemoViewController.id
        if let id = id {
            print(id)
            memoAtFirst = JSONCoreData().showMemo(id: id)
        }
        
        memoTextView.text = memoAtFirst
        memoTextView.delegate = self
    }
    
    func setWebView() {
        webView.delegate = self as? UIWebViewDelegate
        setIndicatorView()
        playIndicator()
        let request = URLRequest.init(url: MemoViewController.url!)
        self.webView.loadRequest(request)
        stopIndicator()
    }
    
    func setNavigationItem() {
        if let name = MemoViewController.name {
            self.navigationItem.title = name
        }
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
        guard memoContext != nil else {
            return
        }
        if memoAtFirst != nil {
            JSONCoreData().updateMemoMemo(id: MemoViewController.id, memo: memoContext!)
        }
        else {
            JSONCoreData().addMemo(id: MemoViewController.id, memo: memoContext)
        }
    memoTextView.resignFirstResponder()
    }
    
    //MARK: Activity Indicator related
    
    func setIndicatorView() {
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:
            UIActivityIndicatorViewStyle.gray)
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.activityIndicator.center = self.webView.center
        webView.addSubview(self.activityIndicator)
        }
    
    func playIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    func stopIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}
