//
//  APIManager.swift
//  WeatherApp
//
//  Created by wolfyteze on 30/10/2020.
//  Copyright © 2020 wolfyteze. All rights reserved.
//

import Foundation

typealias JSONTask = URLSessionTask
typealias JSONCompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith( request: URLRequest, completionHandler: JSONCompletionHandler) -> JSONTask
    
    init(sessionConfiguration: URLSessionConfiguration)
}
