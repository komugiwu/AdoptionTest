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
    static var jsonDatasFromCoreData: Array<JsonDatas>?
    
    enum JsonKeys: String {
        case regions = "regions"
        case id = "id"
        case name = "name"
        case url = "url"
        case image = "image"
        case hiragana = "hiragana"
        case prefecture = "prefecture"
    }
    
    enum SegueName: String {
        case segueToListVC = "segue_vc_to_listvc"
        case segueToMemoVC = "segue_to_memoVC"
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
            Common.jsonDatas = jsonObjects?[JsonKeys.regions.rawValue]
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
    
    //MARK : Type transform methods
    
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
}
