//
//  MemoViewController.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/15.
//  Copyright © 2017年 Komugi. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController, UITextViewDelegate {

    //MARK: Properties
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var webView: UIWebView!
    static var id: Int16?
    static var url: URL?
    var memoContext :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.text = setMemo()
        memoTextView.delegate = self
        MemoViewController().setWebView()
    }
    
    //MARK: Memo related
    func setMemo() -> String {
        let memoAtFirst: String? = Memo().showMemo(id: MemoViewController.id!)
        
        if memoAtFirst != nil {
            return memoAtFirst!
        }
        else {
            return "Please memo something"
        }
    }
    
    //MARK: Web related
    func setWebView() {
        webView.delegate = self as? UIWebViewDelegate
        let request = URLRequest.init(url: MemoViewController.url!)
        self.webView.loadRequest(request)
    }
    
    //MARK: Activities
    @IBAction func saveMemoButton(_ sender: UIButton) {
        let memoContext = memoTextView.text
        
        guard memoContext == nil else {
            return
        }
        Memo().addMemo(id: MemoViewController.id!, memo: memoContext!)
    }
    
    @IBAction func backLastPageButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
