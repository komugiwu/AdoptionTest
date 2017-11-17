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
    
    //Others
    
    func imageFromStringURL(imageView: UIImageView!, string: String?) {
        var data: Data
        do {
            let url = Common().stringToURL(string: string)!
            print(url)
            try data = Data(contentsOf: url)
        }
        catch {
            fatalError("Failed of load image from URL")
        }
        imageView.image = UIImage.init(data: data)
    }
    
    func stringToURL(string: String?) -> URL? {
        return URL.init(string: string!)
    }
}
