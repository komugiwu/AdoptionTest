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
    
    //MARK : Get JSON data and setting core data
    
    func setDatas() {
        let queue = DispatchQueue(label: "com.adoptiontest.komugi", qos: DispatchQoS.userInitiated)
        queue.async {
            self.setCoreDatas()
        }
    }
    
    func getSettingDatas() {
        do {
            try JSONCoreData.fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    func setCoreDatas() {
        getSettingDatas()
        
        //get json data and choose to add or update core data
        let jsonOriginData = Common().getJsonDatas()!
        for originData in jsonOriginData {
            let id = Common().stringToInt16(string: originData[Common.JsonKeys.id] as? String)
            let idCoreData = getData(ID: id!)
            if idCoreData == nil {
                //add
                let dataContext = NSEntityDescription.insertNewObject(forEntityName: entityName, into: moc) as! JsonDatas
                dataContext.id = id!
                dataContext.name = originData[Common.JsonKeys.name] as? String
                dataContext.image = originData[Common.JsonKeys.image] as? String
                dataContext.hiragana = originData[Common.JsonKeys.hiragana] as? String
                dataContext.url = originData[Common.JsonKeys.url] as? String
                dataContext.prefecture = originData[Common.JsonKeys.prefecture] as? [String]
            }
            else {
                //update
                do {
                    let request = getFetchRequest(ID: id)
                    let results = try moc.fetch(request) as! [JsonDatas]
                    print(results[0])
                    let dataContext = results[0]
                    dataContext.name = originData[Common.JsonKeys.name] as? String
                    dataContext.image = originData[Common.JsonKeys.image] as? String
                    dataContext.url = originData[Common.JsonKeys.url] as? String
                    dataContext.hiragana = originData[Common.JsonKeys.hiragana] as? String
                    dataContext.prefecture = originData[Common.JsonKeys.prefecture] as? [String]
                }
                catch {
                    fatalError("Failed to fetch data: \(error)")
                }
            }
            saveData()
        }
    }
    
    //MARK : Common core data functions
    
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

            if datas!.count == 0 {
                return nil
            }
            return datas![0]
        }
        catch {
            fatalError("Failed to fetch data : \(error)")
        }
        return nil
    }
    
    //MARK : Memo functions

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
}
