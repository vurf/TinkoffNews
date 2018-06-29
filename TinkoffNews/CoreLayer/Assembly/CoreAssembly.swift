//
//  CoreAssembly.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 6/22/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

protocol ICoreAssembly {
    var mainContext: IMainContext {get}
    var saveContext: ISaveContext {get}
    var masterContext: IMasterContext {get}
    var requestSender: IRequestSender { get }
}

class CoreAssembly: ICoreAssembly {
    lazy var coreDataStack: CoreDataStack = CoreDataStack()
    lazy var mainContext: IMainContext = self.coreDataStack
    lazy var saveContext: ISaveContext = self.coreDataStack
    lazy var masterContext: IMasterContext = self.coreDataStack
    lazy var requestSender: IRequestSender = RequestSender()
}
