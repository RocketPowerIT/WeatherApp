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

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith( request: URLRequest, completionHandler: JSONCompletionHandler) -> JSONTask
    func fetch<T>(request: URLRequest, parse: ([String: AnyObject]?) -> T?, completionHandler: (APIResult<T>)-> Void )
    init(sessionConfiguration: URLSessionConfiguration)
}

extension APIManager {
    
    func JSONTaskWith( request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask {
        
        let dataTask = session.dataTask(with: request) { (data, responce, error) in
            
            guard let HTTPResponce  = responce as? HTTPURLResponse else {
                let userInfo = [ NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")]
                let error = NSError(domain: WTNetworkingErrorDomain, code: 100, userInfo: userInfo)
                completionHandler(nil, nil, error)
                return
            }
            if data == nil{
                if let error = error {
                    completionHandler(nil, HTTPResponce, error)
                }
            }else {
                switch HTTPResponce.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                        completionHandler(json, HTTPResponce, nil)
                    } catch let error as NSError {
                        completionHandler(nil, HTTPResponce, error)
                    }
                default:
                    print("Response status \(HTTPResponce.statusCode)")
                }
            }
        }
        
        return dataTask
    }
    
    func fetch<T>(request: URLRequest, parse: ([String: AnyObject]?) -> T?, completionHandler: @escaping (APIResult<T>)-> Void ) {
        
        let dataTask = JSONTaskWith(request: request) { (json, response, error) in
            guard let json = json else {
                if let error = error {
                    completionHandler(.Failure(error))
                }
                return
            }
            
            if let value = parse(json) {
                completionHandler(.Success(value))
            } else {
                let error = NSError(domain: WTNetworkingErrorDomain, code: 200, userInfo: nil)
                completionHandler(.Failure(error))
            }
        }
        dataTask.resume()
    }
}
