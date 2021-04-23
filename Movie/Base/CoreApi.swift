//
//  CoreAPI.swift
//  Movie
//
//  Created by Edo Oktarifa on 23/04/21.
//

import Foundation
import Alamofire

@objc protocol CoreApiDelegate {
    @objc func finish(interFace : CoreApi, responseHeaders : HTTPURLResponse, data : Data)
    @objc func failed(interFace : CoreApi, result : AnyObject)
}

class CoreApi : NSObject {
    var URL = ""
    var encoding: ParameterEncoding = URLEncoding.default
    var delegate : CoreApiDelegate?
    var method : HTTPMethod = .get
    var isAuthorization = true
    
    private var overrideParameters: Parameters {
        let params = Parameters()
        return params
    }
    
    func getRequest() {
        Alamofire.request(URL, method: method, parameters : getParam(), encoding: encoding).responseJSON { response in
            
            print(response.debugDescription)
            
            
            print("Header >>> \(self.getHeader())")
            print("URL Request >>> \(String(describing: response.request))")  // original URL request
            print("statusCode >>> \(String(describing: response.response?.statusCode))\n\n")
            
            do{
                if let responseValue = response.result.value, !(responseValue is NSNull) {
                    let jsonData = try JSONSerialization.data(withJSONObject: responseValue, options: [])
                    let responseString = String(data: jsonData, encoding: .utf8)!
                    print("Param >>> \(self.getParam())")
                    print("Response >>> \(responseString)\n\n")
                }
                
            } catch { }
            
            if self.isConnectedToInternet() {
                let statusCode = response.response?.statusCode
                switch (statusCode) {
                
                case 200,201:
                    
                    guard let responseHeader = response.response else { return }
                    guard let data = response.data else { return }
                    self.success(responseHeaders: responseHeader, data: data)
                    
                default:
                    self.failed(data: response.result.value as AnyObject)
                    
                }
            } else {
                // Handle if lose connection
            }
        }
        
    }
    
    func getParam() -> [String : Any]  {
        return [:]
    }
    
    func getHeader() -> HTTPHeaders {
        
        let headers = [
            "Content-type" :"application/json"
        ]
        
        return headers
    }
    
    func success(responseHeaders : HTTPURLResponse, data : Data) {
        delegate?.finish(interFace: self, responseHeaders : responseHeaders, data : data)
    }
    
    func failed(data : AnyObject) {
        delegate?.failed(interFace: self, result: data)
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
