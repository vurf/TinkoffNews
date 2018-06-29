//
//  Article+CoreData.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 6/27/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation
import CoreData

extension Article {
    
    static func insert(in context: NSManagedObjectContext) -> Article? {
        
        guard let article = NSEntityDescription.insertNewObject(forEntityName: "Article", into: context) as? Article else {
            
            return nil
        }
        
        return article
    }
    
}
