//
//  MemoCoreData.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/21.
//  Copyright © 2017年 Komugi. All rights reserved.
//

import UIKit
import CoreData

class JSONCoreData {
    static let entityName = "JsonDatas"
    public static let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /*
    lazy var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<JsonDatas> in
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let fetchRequest: NSFetchRequest<JsonDatas> = JsonDatas.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: "name",
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self as? NSFetchedResultsControllerDelegate
        return fetchedResultsController
    }()
    */
    
    //MARK : Set JSON datas
    
    func setDatasToCoreData(oldMemo: [Int16: String]?) {
        
        if let datas = Common.jsonDatas {
            for data in datas {
                let DataContext = NSEntityDescription.insertNewObject(forEntityName: JSONCoreData.entityName, into: JSONCoreData.moc) as! JsonDatas
                
                DataContext.image = data[Common.JsonKeys.image.rawValue] as? String
                DataContext.name = data[Common.JsonKeys.name.rawValue] as? String
                DataContext.url = data[Common.JsonKeys.url.rawValue] as? String
                DataContext.hiragana = data[Common.JsonKeys.hiragana.rawValue] as? String
                DataContext.prefecture =  data[Common.JsonKeys.prefecture.rawValue] as? Array
                DataContext.id = Common().stringToInt16(string: data[Common.JsonKeys.id.rawValue] as? String)!
                
                if let oldMemo = oldMemo {
                    for memo in oldMemo {
                        if memo.key == DataContext.id {
                            DataContext.memo = memo.value
                        }
                    }
                }
                do {
                    try JSONCoreData.moc.save()
                }
                catch {
                    fatalError("Failure to save context: \(error)")
                }
            }
        }
    }
    
    func getDatasFromCoreData() -> Array<JsonDatas>? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: JSONCoreData.entityName)
        
        do {
            return try JSONCoreData.moc.fetch(request) as? [JsonDatas]
        }
        catch {
            fatalError("Failed to fetch data : \(error)")
        }
        return nil
    }
    
    
    func cleanUpCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: JSONCoreData.entityName)
        do {
            let results = try JSONCoreData.moc.fetch(request) as! [JsonDatas]
            for result in results {
                JSONCoreData.moc.delete(result)
            }
            do {
                try JSONCoreData.moc.save()
            }
            catch {
                fatalError("Failure to save context: \(error)")
            }
        }
        catch {
            fatalError("Failed to fetch data: \(error)")
        }
    }
    
    func setDatas() {
        let oldDatas = JSONCoreData().getDatasFromCoreData()
        let oldMemo = JSONCoreData().getOldMemo(jsonDatas: oldDatas)
        JSONCoreData().cleanUpCoreData()
        Common().setJsonDatas()
        JSONCoreData().setDatasToCoreData(oldMemo: oldMemo)
        Common.jsonDatasFromCoreData = JSONCoreData().getDatasFromCoreData()
    }
    
    //MARK : Memo functions
    
    func addMemo(id: Int16?, memo: String?) {
        guard id != nil && memo != nil else {
            return
        }
        
        let MemoContext = NSEntityDescription.insertNewObject(forEntityName: JSONCoreData.entityName, into: JSONCoreData.moc) as! JsonDatas
        
        MemoContext.id = id!
        MemoContext.memo = memo!
        
        do {
            try JSONCoreData.moc.save()
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func showMemo(id: Int16) -> String? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: JSONCoreData.entityName)
        
        do {
            let results = try JSONCoreData.moc.fetch(request) as! [JsonDatas]
            
            for result in results {
                if id == result.id {
                    return result.memo
                }
            }
        }
        catch {
            fatalError("Failed to fetch data : \(error)")
        }
        return nil
    }

     func updateMemoMemo(id: Int16?, memo: String?) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: JSONCoreData.entityName)
     
        do {
            let results = try JSONCoreData.moc.fetch(request) as! [JsonDatas]
     
            for result in results {
                if result.id == id && memo != nil {
                    result.memo = memo
                    try JSONCoreData.moc.save()
                    return
                }
            }
        }
        catch {
            fatalError("Failed to fetch data: \(error)")
        }
     }

    func getOldMemo(jsonDatas: Array<JsonDatas>?) -> [Int16: String]? {
        
        if jsonDatas == nil {
            return nil
        }

        var memoDatas: [Int16: String] = [:]
        for data in jsonDatas! {
            memoDatas[data.id] = data.memo
        }
        return memoDatas
    }
}
