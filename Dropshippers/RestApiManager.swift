//
//  RestApiManager.swift
//  Dropshippers
//
//  Created by DARKNIGHT on 23/08/2016.
//  Copyright © 2016 DARKNIGHT. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Locksmith

typealias APIResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {

    // go Singleton
    static let sharedInstance = RestApiManager()
    
    private let baseUrl = "http://dropshippers.dev"
    private let dictionary = Locksmith.loadDataForUserAccount("userAccount")
    
    // MARK: Ops route path to API dropshippers
    
    // Permet d'obtenir le token d'un utilisateur
    func postToSignin(parameters: [String], onCompletion: (JSON) -> Void) {
        let route = "/v1/login/signin"
        
        
        let bodyParam = ["username": parameters[0], "password": parameters[1]]
        makeHttpPostRequest(route,token: "", body: bodyParam) { (json, err) in
            onCompletion(json as JSON)
        }
        
    }
    
    
    
    
    // les route ou un appel a ces routes, voir le plus opti possible
    
    // MARK: GET Request
    private func makeHttpGetRequest(routePath: String,token: String?, onCompletion: APIResponse){
        let url = baseUrl + routePath
        
        Alamofire.request(.GET, url, headers: ["token": token!])
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on \(url)")
                    onCompletion(nil, response.result.error)
                    return
                }
                
                if let value = response.result.value {
                    let resultValue = JSON(value)
                    onCompletion(resultValue, nil)
                }
                
            }
            .responseString { response in
                print(response.result.value)
                print(response.result.error)
        }
        
    }
    
    // MARK: POST Request
    private func makeHttpPostRequest(routePath: String,token: String?, body: [String: AnyObject], onCompletion: APIResponse){
        let url = baseUrl + routePath
        
        Alamofire.request(.POST, url, parameters: body, encoding: .JSON, headers: ["token": token!])
            .responseJSON { response in
                
                guard response.result.error == nil else {
                    print("error calling POST on \(url)")
                    onCompletion(nil, response.result.error)
                    return
                }
                
                if let value = response.result.value {
                    let resultValue = JSON(value)
                    onCompletion(resultValue, nil)
                }
        }
        
    }
    
    // MARK: PUT Request
    private func makeHttpPutRequest(){
        
    }
    
    // MARK: DELETE Request
    private func makeHttpDeleteRequest(){
        
    }
}
