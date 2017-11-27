//
//  Common.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/15.
//  Copyright © 2017年 Komugi. All rights reserved.
//

import UIKit
import CoreData

class Common {
    
    //Properties
    
    static var jsonDatas: Array<Dictionary<String, AnyObject>>?
    
    struct JsonKeys {
        static let regions = "regions"
        static let id = "id"
        static let name = "name"
        static let url = "url"
        static let image = "image"
        static let hiragana = "hiragana"
        static let prefecture = "prefecture"
    }
    
    struct SegueName {
        static let segueToListVC = "segue_vc_to_listvc"
        static let segueToMemoVC = "segue_to_memoVC"
    }
    

    //Json related
    
    func setJsonDatas() {
        if Common.jsonDatas != nil {
            return
        }
        
        guard Common.jsonDatas == nil else {
            return
        }
        
        let url = Bundle.main.url(forResource: "json", withExtension: "txt")
        
        do {
            let data = try Data.init(contentsOf: url!)
            let jsonObjects = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Array<Dictionary<String, AnyObject>>>
            //print(jsonObjects ?? "nil")
            Common.jsonDatas = jsonObjects?[JsonKeys.regions]
        }
        catch {
            print(error.localizedDescription)
        }
    }

    //Mark : List cell setting
    
    func imageFromStringURL(imageView: UIImageView?, string: String?) {
        var data: Data
        do {
            let url = Common().stringToURL(string: string)
            try data = Data(contentsOf: url!)
        }
        catch {
            fatalError("Failed to load image from URL")
        }
 
        guard let imgView = imageView else {
            return
        }
        let image = UIImage.init(data: data)!
        imgView.image = image
    }
    
    //MARK : Others
    
    func stringToURL(string: String?) -> URL? {
        return URL(string: string!)
    }
    
    func stringToInt16(string: String?) -> Int16? {
        guard string != nil else {
            return nil
        }
        let intValue = Int16(string!)
        return intValue
    }
    
    /*
    //MARK: Activity Indicator view
   
    func setIndicatorView(view: UIWebView) {
        if Common.activityIndicator == nil {
            Common.activityIndicator = UIActivityIndicatorView()
        }
        
        Common.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:
            UIActivityIndicatorViewStyle.gray)
        Common.activityIndicator?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        Common.activityIndicator?.center = view.center
        Common.activityIndicator?.hidesWhenStopped = true
        view.addSubview(Common.activityIndicator!);

        Common().playIndicator()
    }
    
    func playIndicator() {
        Common.activityIndicator?.startAnimating()
    }
    
    func stopIndicator() {
        Common.activityIndicator?.stopAnimating()
        
    }
    */
}
