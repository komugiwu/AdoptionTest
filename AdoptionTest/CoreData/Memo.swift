//
//  Memo+CoreDataClass.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/15.
//  Copyright © 2017年 Komugi. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Memo)
public class Memo: NSManagedObject {
    public static let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK : - Memo function
    
    func addMemo(name: String, id: Int16, memo: String) {
        let Memo = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: Memo.moc) as! Memo
        
        Memo.id = id
        Memo.memo = memo
        
        do {
            try Memo.moc.save()
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func showMemo() -> ([Memo]?) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Memo")
        
        do {
            let results = try Memo.moc.fetch(request) as! [Memo]
            
            for result in results {
                print("ID : \(result.id), Memo : \(String(describing: result.memo)).")
                return results
            }
        }
        catch {
            fatalError("Failed to fetch data : \(error)")
        }
        return nil
    }
    
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

}
