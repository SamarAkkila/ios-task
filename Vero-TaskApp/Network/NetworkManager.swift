//
//  NetworkManager.swift
//  Vero-TaskApp
//
//  Created by MacBook on 27/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NetworkManager {
    
    
    static let shared = NetworkManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init(){}
    
    private func getHeaders(_ type: HeaderType) -> [String : String] {
        var headers = [String : String]()
        headers["Content-Type"] = "application/json"
        
        switch type {
        case .Login: //---- Used for auth
            headers["Authorization"] = "Bearer QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz"
            
        default: //---- Used for requests needs user token
            headers["Authorization"] = "Bearer " + Auth_User.userToken
            
        }
        
        return headers
    }
    
    
    
    func login(){
//        let headers = getHeaders(.Login)
        
        let headers = [
          "Authorization": "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz",
          "Content-Type": "application/json"
        ]
        
        let parameters = [
            "username": "365",
            "password": "1"
        ] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: Constants.login)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = HttpsMethod.POST.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
                
                if let data = data {
                    do {
                        let res_ = try JSONDecoder().decode(Response.self, from: data)
                        print(res_.oauth.access_token)
                        Auth_User.userToken = res_.oauth.access_token
                        self.performTasks()
                    } catch let error {
                        print(error)
                    }
                }
                
                
            }
        })
        
        dataTask.resume()
    }
    
    
    
    
    func performTasks(){
//        let headers = getHeaders(.Other)
        
        let headers = [
          "Authorization": "Bearer " + Auth_User.userToken,
          "Content-Type": "application/json"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: Constants.tasks)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = HttpsMethod.GET.rawValue
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
                NotificationCenter.default.post(name: Constants.stopRefresh, object: nil )
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse  as Any)
                
                if let data = data {
                    do {
                        let arrTasks = try JSONDecoder().decode([taskModel].self, from: data)
                        DispatchQueue.main.async {
                            self.deleteAllData(entity :"Task")
                        }
                        for item in arrTasks {
                            let task = Task(context: self.context)
                            
                            task.task = item.task
                            task.title = item.title
                            task.desc = item.description
                            task.sort = item.sort
                            task.wageType = item.wageType
                            task.businessUnitKey = item.BusinessUnitKey
                            task.businessUnit = item.businessUnit
                            task.parentTaskID = item.parentTaskID
                            task.preplanningBoardQuickSelect = item.preplanningBoardQuickSelect
                            task.colorCode = item.colorCode
                            task.workingTime = item.workingTime
                            task.isAvailableInTimeTrackingKioskMode = item.isAvailableInTimeTrackingKioskMode ?? false
                            
                            do {
                                try self.context.save()
                            }catch{}
                        }
                        
                    } catch let error {
                        print(error)
                    }
                    NotificationCenter.default.post(name: Constants.stopRefresh, object: nil )
                }
                
            }
        })
        
        dataTask.resume()
    }
    
    
    func deleteAllData(entity: String)
    {
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }
    
}




