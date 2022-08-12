//
//  Webservices.swift
//  GenericApi
//
//  Created by Hitesh  on 22/10/19.
//  Copyright © 2019 Hitesh . All rights reserved.
//

import UIKit
import Alamofire

final class Webservices: NSObject {
    static let instance = Webservices()
    private override init() {
        
    }
        
    // post
    func post(url:String,params:[String:Any], completion: @escaping (_ success:Bool,_ response:AnyObject? , _ error:String?) -> ()){
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            switch response.result {
            case .success(let resData as AnyObject):
                completion(true,resData,nil)
            case .failure(let err):
                print(err)
                completion(false,nil,err.localizedDescription)
            default:
                break
            }
        }
    }
    
    // get
    func get(url:String,params:[String:Any]?, completion: @escaping (_ success:Bool ,_ response:AnyObject? , _ error:String?) -> ()) {
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            switch response.result {
            case .success(let resData as AnyObject):
                completion(true,resData,nil)
            case .failure(let err):
                print(err)
                completion(false,nil,err.localizedDescription)
            default:
                break
            }
        }
    }
    
    // cancel pending requests
    func cancelPendingRequests(){
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
    
}
