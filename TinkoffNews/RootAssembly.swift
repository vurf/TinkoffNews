//
//  RootAssembly.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 6/22/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

class RootAssembly {
    
    lazy var presentationAssembly: IPresentationAssembly = PresentationAssembly(serviceAssembly: self.serviceAssembly)

    private lazy var serviceAssembly: IServicesAssembly = ServicesAssembly(coreAssembly: self.coreAssembly)
    
    private lazy var coreAssembly: ICoreAssembly = CoreAssembly()
    
}
