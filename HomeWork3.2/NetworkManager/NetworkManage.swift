//
//  NetworkManage.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 18.01.2025.
//

import Foundation
import Alamofire


class NetworkManage {
    
    let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI0LTc1NmUtNDVlOC04YWYxLTFlMWNkMDRkMDE1NyIsImlzRGV2ZWxvcGVyIjp0cnVlLCJpYXQiOjE3MzUzOTA3NjIsImV4cCI6MjA1MDk2Njc2Mn0.xL2fhtLOtHp_K4Xn_bEAhuKgnRwYlUGwaRk-XxirgdY"
    
     let baseURL = "https://bothub.chat/api/v2/openai/v1/chat/completions"
    
   
    
    func sendRequest(message: String, completion: @escaping ([Choice]) -> Void) {
        
        let headers: HTTPHeaders = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Authorization", value: "Bearer \(apiKey)")
        ]
        
        let parametrs: Parameters = [
            "model": "gpt-4o",
            "messages": [
                ["role": "user", "content": message]
        ]
            ]
       
        AF.request(baseURL, method: .post, parameters: parametrs, encoding: JSONEncoding.default, headers: headers).response { result in
            guard result.error == nil else {return}
            guard let data = result.data else {return}
            
            do {
                let decodedResponse = try JSONDecoder().decode(Responce.self, from: data)
                completion(decodedResponse.choices)
            } catch  {
                print(error.localizedDescription)
            }
            
        }
        }
    }

