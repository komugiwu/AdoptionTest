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
    var memoContext :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setMemo(textView: memoTextView)
        self.setWebView()
        self.setNavigationItem()
    }
    
    //MARK: Memo and Web Setting
    
    func setMemo( textView: UITextView) {
        
        let id = MemoViewController.id
        var memoAtFirst: String?
        if let id = id {
            print(id)
            memoAtFirst = Memo().showMemo(id: id)
        }
        memoTextView.text = memoAtFirst
        memoTextView.delegate = self
    }
    
    func setWebView() {
        webView.delegate = self as? UIWebViewDelegate
        let request = URLRequest.init(url: MemoViewController.url!)
        self.webView.loadRequest(request)
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
    
    //MARK: Activities
    @IBAction func saveMemoButton(_ sender: UIButton) {
        let memoContext = memoTextView.text
        
        guard memoContext == nil else {
            return
        }
        Memo().addMemo(id: MemoViewController.id!, memo: memoContext!)
    }
    
    
}
