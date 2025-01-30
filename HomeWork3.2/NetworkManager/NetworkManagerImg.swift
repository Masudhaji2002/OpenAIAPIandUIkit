//
//  NetworkManagerImg.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 20.01.2025.
//

import Foundation
import Alamofire

class NetworkManagerImg {
    
    let stringURL = "https://bothub.chat/api/v2/openai/v1/images/generations"
    let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI0LTc1NmUtNDVlOC04YWYxLTFlMWNkMDRkMDE1NyIsImlzRGV2ZWxvcGVyIjp0cnVlLCJpYXQiOjE3MzUzOTA3NjIsImV4cCI6MjA1MDk2Njc2Mn0.xL2fhtLOtHp_K4Xn_bEAhuKgnRwYlUGwaRk-XxirgdY"
    
    func sendSecondRequest(prompt: String, completion: @escaping ([Data]) -> Void) {
       
        
        let headers: HTTPHeaders = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Authorization", value: "Bearer \(apiKey)")
        ]
        
        let parametrs: Parameters = [
            "model" : "dall-e-3",
            "prompt" : prompt,
            "n" : 1,
            "size" : "1024x1024"
        ]
        
        AF.request(stringURL, method: .post, parameters: parametrs, encoding: JSONEncoding.default, headers: headers).response { result in
            guard result.error == nil else { return }
            guard let data = result.data else { return }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ApiImageResponce.self, from: data)
                completion(decodedResponse.data)
                
            } catch {
                print(error.localizedDescription)
                
            }
            
        }
        
    }
}
