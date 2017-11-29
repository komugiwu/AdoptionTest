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
    
    //static var jsonDatas: Array<Dictionary<String, AnyObject>>?
    var internetReachability: Reachability!
    
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
    /*
    func setJsonDatas() {
        if Common.jsonDatas != nil {
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
    */
 
    //Mark : List cell setting
    
    func imageFromStringURL(imageView: UIImageView, string: String?) {
        var data: Data
        do {
            let url = Common().stringToURL(string: string)
            try data = Data(contentsOf: url!)
        }
        catch {
            print("failed to load image from URL")
            return
            //fatalError("Failed to load image from URL")
        }
 
        let image = UIImage.init(data: data)!
        imageView.image = image
    }
    
    //MARK : Network related

    func checkNetworkStatus(sender: AnyObject) {
        let reachability: Reachability = Reachability.forInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        if networkStatus == 0 {
            let alert = UIAlertController.init(title: "Network Status", message: "Disconnection", preferredStyle: .alert)
            let ok = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            sender.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK : Others
    
    func stringToURL(string: String?) -> URL? {
        return URL(string: string!)
    }
    
    func stringToInt16(string: String?) -> Int16 {
        let intValue = Int16(string!)
        return intValue!
    }
}
