//
//  ArticlesDataProvider.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 6/26/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ArticlesDataProvider : NSObject {
    
    let fetchedResultsController : NSFetchedResultsController<Article>
    let tableView : UITableView
    
    init(tableView: UITableView, context: IMainContext) {
        self.tableView = tableView
        let fetchRequest = NSFetchRequest<Article>(entityName: "Article")
        let sortByCreatedTime = NSSortDescriptor(key: "createdTime", ascending: false)
        fetchRequest.sortDescriptors = [sortByCreatedTime]
        fetchRequest.fetchBatchSize = 20
        self.fetchedResultsController = NSFetchedResultsController<Article>(fetchRequest: fetchRequest, managedObjectContext: context.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        self.fetchedResultsController.delegate = self
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension ArticlesDataProvider : NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange  anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath {
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
}
