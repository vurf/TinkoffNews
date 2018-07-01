//
//  ServiceAssembly.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 6/22/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

protocol IServicesAssembly {
    
    var newsService: INewsService {get}
    
    var coreDataService: ICoreDataService {get}
    
    var mainContext: IMainContext {get}
}

class ServicesAssembly: IServicesAssembly {
    
    private let coreAssembly: ICoreAssembly
    
    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
    
    lazy var newsService: INewsService = NewsService(requestSender: self.coreAssembly.requestSender, context: self.coreAssembly.saveContext)
    
    lazy var coreDataService: ICoreDataService = CoreDataService(context: self.coreAssembly.saveContext)
    
    lazy var mainContext: IMainContext = self.coreAssembly.mainContext
}
