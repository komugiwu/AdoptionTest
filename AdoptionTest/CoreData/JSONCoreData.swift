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
    let entityName = "JsonDatas"
    let moc = JSONCoreData.fetchedResultsController.managedObjectContext
    static var memoContent: String?
    
    static var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<JsonDatas> in
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let fetchRequest: NSFetchRequest<JsonDatas> = JsonDatas.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: "name",
                                                                  cacheName: nil)
        return fetchedResultsController
    }()
    
    //MARK : Set JSON datas
    
    func getSettingDatas() {
        do {
            try JSONCoreData.fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    func setJsonDatas(oldMemo: [Int16: String]?) {
        let url = Bundle.main.url(forResource: "json", withExtension: "txt")
        var jsonDatas: [[String: AnyObject]]? = [[:]]
        
        do {
            let data = try Data.init(contentsOf: url!)
            let jsonObjects = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:[[String: AnyObject]]]
            jsonDatas = jsonObjects?[Common.JsonKeys.regions]
        }
        catch {
            print(error.localizedDescription)
        }
        
        if let datas = jsonDatas {
            for data in datas {
                let DataContext = NSEntityDescription.insertNewObject(forEntityName: entityName, into: moc) as! JsonDatas
                DataContext.image = data[Common.JsonKeys.image] as? String
                DataContext.name = data[Common.JsonKeys.name] as? String
                DataContext.url = data[Common.JsonKeys.url] as? String
                DataContext.hiragana = data[Common.JsonKeys.hiragana] as? String
                DataContext.prefecture =  data[Common.JsonKeys.prefecture] as? [String]
                DataContext.id = Common().stringToInt16(string: data[Common.JsonKeys.id] as? String)
                if let oldMemo = oldMemo {
                    for memo in oldMemo {
                        if memo.key == DataContext.id {
                            DataContext.memo = memo.value
                        }
                    }
                }
                do {
                    try moc.save()
                }
                catch {
                    fatalError("Failure to save context: \(error)")
                }
            }
        }
    }
    /*
    func setDatasToCoreData(oldMemo: [Int16: String]?) {
        
        if let datas = Common.jsonDatas {
            for data in datas {
                let DataContext = NSEntityDescription.insertNewObject(forEntityName: entityName, into: moc) as! JsonDatas
                
                DataContext.image = data[Common.JsonKeys.image] as? String
                DataContext.name = data[Common.JsonKeys.name] as? String
                DataContext.url = data[Common.JsonKeys.url] as? String
                DataContext.hiragana = data[Common.JsonKeys.hiragana] as? String
                DataContext.prefecture =  data[Common.JsonKeys.prefecture] as? Array
                DataContext.id = Common().stringToInt16(string: data[Common.JsonKeys.id] as? String)!
                
                if let oldMemo = oldMemo {
                    for memo in oldMemo {
                        if memo.key == DataContext.id {
                            DataContext.memo = memo.value
                        }
                    }
                }
                do {
                    try moc.save()
                }
                catch {
                    fatalError("Failure to save context: \(error)")
                }
            }
        }
    }
    */
    
    func getAllDatasFromCoreData() -> Array<JsonDatas>? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            return try moc.fetch(request) as? [JsonDatas]
        }
        catch {
            fatalError("Failed to fetch data : \(error)")
        }
        return nil
    }
 
    func cleanUpCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let results = try moc.fetch(request) as! [JsonDatas]
            for result in results {
                moc.delete(result)
            }
            do {
                try moc.save()
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
        let oldDatas = JSONCoreData().getAllDatasFromCoreData()
        let oldMemo = JSONCoreData().getOldMemo(jsonDatas: oldDatas)
        JSONCoreData().cleanUpCoreData()
        
        let queue = DispatchQueue(label: "com.adoptiontest.komugi", qos: DispatchQoS.userInitiated)
        queue.async {
            //Common().setJsonDatas()
            //JSONCoreData().setDatasToCoreData(oldMemo: oldMemo)
            JSONCoreData().setJsonDatas(oldMemo: oldMemo)
        }
    }
    
    //MARK : Common functions
    
    func getFetchRequest(ID: Int16?) -> NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if let ID = ID {
            request.predicate = NSPredicate(format: "id = \(ID)")
        }
        return request
    }
    
    func saveData() {
        do {
            try moc.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror.localizedDescription), \(nserror.userInfo)")
        }
    }
    
    func getData(ID: Int16) -> JsonDatas? {
        let request = getFetchRequest(ID: ID)
        do {
            let datas = try moc.fetch(request) as? [JsonDatas]
            return datas![0]
        }
        catch {
            fatalError("Failed to fetch data : \(error)")
        }
        return nil
    }
    
    //MARK : Memo functions
    
    func addMemo(id: Int16?, memo: String?) {
        if id == nil || memo == nil {
            return
        }
        
        let MemoContext = NSEntityDescription.insertNewObject(forEntityName: entityName, into: moc) as! JsonDatas
        
        MemoContext.id = id!
        MemoContext.memo = memo!
        JSONCoreData.memoContent = memo!
        saveData()
    }
    
    func showMemo(id: Int16) -> String? {
        let request = getFetchRequest(ID: id)
        do {
            let results = try moc.fetch(request) as! [JsonDatas]
            if results[0].memo == nil {
                return JSONCoreData.memoContent
            }
            return results[0].memo
        }
        catch {
            fatalError("Failed to fetch data : \(error)")
        }
        return nil
    }

     func updateMemoMemo(id: Int16?, memo: String?) {
        let request = getFetchRequest(ID: id)
        do {
            let results = try moc.fetch(request) as! [JsonDatas]
            results[0].memo = memo
            saveData()
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
