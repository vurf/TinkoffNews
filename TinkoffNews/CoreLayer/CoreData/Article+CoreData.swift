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
    
    static func getById(in context: NSManagedObjectContext, id: String) -> Article? {
        
        let templateName = "GetArticleById"
        
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print ("Model is not available in context")
            assert(false)
            return nil
        }
        
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: templateName, substitutionVariables: ["id" : id]) as? NSFetchRequest<Article> else {
            assert(false,"No template with name \(templateName)")
            return nil
        }
        
        return fetchRequestExecute(in: context, fetchRequest: fetchRequest)
    }
    
    static func getBySlug(in context: NSManagedObjectContext, slug: String) -> Article? {
        
        let templateName = "GetArticleBySlug"
        
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print ("Model is not available in context")
            assert(false)
            return nil
        }
        
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: templateName, substitutionVariables: ["slug" : slug]) as? NSFetchRequest<Article> else {
            assert(false,"No template with name \(templateName)")
            return nil
        }
    
        return fetchRequestExecute(in: context, fetchRequest: fetchRequest)
    }
    
    static func deleteAll(in context: NSManagedObjectContext) {
        
        context.perform {
            do {
                let objects = try context.fetch(Article.fetchRequest()) as! [Article]
                for object in objects {
                    context.delete(object)
                }
            } catch {
                print("Failed to delete: \(error)")
            }
        }
    }
    
    static func fetchRequestExecute(in context: NSManagedObjectContext, fetchRequest: NSFetchRequest<Article>) -> Article? {
        
        var article: Article?
        
        context.performAndWait {
            do {
                let results = try context.fetch(fetchRequest)
                assert(results.count < 2, "Multiple article found!")
                if let foundedArticle = results.first{
                    article = foundedArticle
                }
            } catch {
                print ("Failed to fetch article: \(error)")
            }
        }
        
        return article
    }
}
