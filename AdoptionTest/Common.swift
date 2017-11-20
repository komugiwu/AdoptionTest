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
    
    //Json related
    
    func setJsonDatas() {
        
        guard Common.jsonDatas == nil else {
            return
        }
        
        let url = Bundle.main.url(forResource: "json", withExtension: "txt")
        
        do {
            let data = try Data.init(contentsOf: url!)
            let jsonObjects = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Array<Dictionary<String, AnyObject>>>
            print(jsonObjects ?? "nil")
            Common.jsonDatas = jsonObjects?["regions"]
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //Mark : Set cell related
    
    func imageFromStringURL(imageView: UIImageView?, string: String?) {
        guard imageView == imageView else {
            return
        }
        
        var data: Data
        do {
            let url = Common().stringToURL(string: string)
            try data = Data(contentsOf: url!)
        }
        catch {
            fatalError("Failed to load image from URL")
        }
 
        let image = UIImage.init(data: data)!
        imageView?.image = image
        
        print("************* ImageURL ******************")
        print("ImageView URL : \(String(describing: string))")
        print("ImageView Data : \(data)")
        print("ImageView image : \(String(describing: imageView?.image))")
        print("*****************************************")

    }
    
    func stringToURL(string: String?) -> URL? {
        return URL(string: string!)
    }
    
    func setValueToLabel(label: UILabel?, string: String?) {
        guard label == label else {
            return
        }
        label?.text = string
        
        print("************** Label ********************")
        print("String: \(String(describing: string))")
        print("Label: \(String(describing: label?.text))")
        print("*****************************************")
    }
}
