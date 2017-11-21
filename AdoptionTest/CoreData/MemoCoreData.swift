//
//  MemoCoreData.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/21.
//  Copyright © 2017年 Komugi. All rights reserved.
//

import UIKit
import CoreData

class MemoCoreData {
    public static let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK : - Memo function
    
    func addMemo(id: Int16?, memo: String?) {
        guard id != nil && memo != nil else {
            return
        }
        
        let MemoContext = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: MemoCoreData.moc) as! Memo
        
        MemoContext.id = id!
        MemoContext.memo = memo!
        
        do {
            try MemoCoreData.moc.save()
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func showMemo(id: Int16) -> String? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Memo")
        
        do {
            let results = try MemoCoreData.moc.fetch(request) as! [Memo]
            
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

     func updateMemoMemo(id: Int16, memo: String?) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Memo")
     
        do {
            let results = try MemoCoreData.moc.fetch(request) as! [Memo]
     
            for result in results {
                if result.id == id && memo != nil {
                    result.memo = memo
                    try MemoCoreData.moc.save()
                    return
                }
            }
        }
        catch {
            fatalError("Failed to fetch data: \(error)")
        }
     }
}
