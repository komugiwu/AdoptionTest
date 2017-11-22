//
//  JsonDatas+CoreDataProperties.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/22.
//  Copyright © 2017年 Komugi. All rights reserved.
//
//

import Foundation
import CoreData


extension JsonDatas {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JsonDatas> {
        return NSFetchRequest<JsonDatas>(entityName: "JsonDatas")
    }

    @NSManaged public var hiragana: String?
    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var memo: String?
    @NSManaged public var name: String?
    @NSManaged public var prefecture: [String]?
    @NSManaged public var url: String?

}
