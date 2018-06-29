//
//  IRequest.swift
//  Tinkoff-News
//
//  Created by Илья Варфоломеев on 6/21/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

protocol IRequest {
    var urlRequest: URLRequest? { get }
}
