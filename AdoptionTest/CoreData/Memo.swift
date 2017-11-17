//
//  Memo+CoreDataClass.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/15.
//  Copyright © 2017年 Komugi. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Memo)
public class Memo: NSManagedObject {
    
    public static let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK : - Memo function
    
    func addMemo(id: Int16, memo: String) {
        let MemoContext = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: Memo.moc) as! Memo
        
        MemoContext.id = id
        MemoContext.memo = memo
        
        do {
            try Memo.moc.save()
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func showMemo(id: Int16) -> String? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Memo")
        
        do {
            let results = try Memo.moc.fetch(request) as! [Memo]
            
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
    /*
    func cleanUpMemo() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Memo")
        
        do {
            let results = try Memo.moc.fetch(request) as! [Memo]
            
            for result in results {
                Memo.moc.delete(result)
            }
            
            do {
                try Memo.moc.save()
            }
            catch {
                fatalError("Failure to save context: \(error)")
            }
        }
        catch {
            fatalError("Failed to fetch data: \(error)")
        }
    }
    */
    /*
    func updateMemoMemo(id: Int16, memo: String?) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Memo")
        
        do {
            let results = try Memo.moc.fetch(request) as! [Memo]
            
            for result in results {
                if result.id == id && memo != nil {
                    result.memo = memo
                    try Memo.moc.save()
                    return
                }
            }
        }
        catch {
            fatalError("Failed to fetch data: \(error)")
        }
    }
     */
}
