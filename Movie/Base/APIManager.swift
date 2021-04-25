//
//  Network.swift
//  Movie
//
//  Created by Edo Oktarifa on 23/04/21.
//

import Foundation
import UIKit
import Alamofire

class APIManager {
    
    typealias parameters = [String:Any]
    
    var encoding: ParameterEncoding = URLEncoding.default
    
    func requestData(url:String,method:HTTPMethod,parameters:parameters?,completion: @escaping (ApiResult)->Void) {
        
        Alamofire.request(url, method: method, parameters : parameters, encoding: encoding).responseJSON { response in
            
            print(response.debugDescription)
            
            do{
                if let responseValue = response.result.value, !(responseValue is NSNull) {
                    let jsonData = try JSONSerialization.data(withJSONObject: responseValue, options: [])
                    let responseString = String(data: jsonData, encoding: .utf8)!
//                    print("Param >>> \(self.getParam())")
                    print("Response >>> \(responseString)\n\n")
                }
                
            } catch { }
            
            if self.isConnectedToInternet() {
                guard let statusCode = response.response?.statusCode else { return }
                
                switch (statusCode) {
                
                case 200,201:
                    guard let data = response.data else { return }
                    
                    completion(ApiResult.success(data: data))
                    
                case 400...499:
                    completion(ApiResult.failure(result: .authorizationError(response.result.value as AnyObject)))
                default:
                    completion(ApiResult.failure(result: .unknownError))
                    
                }
            } else {
                // Handle if lose connection
            }
        }
        
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}

