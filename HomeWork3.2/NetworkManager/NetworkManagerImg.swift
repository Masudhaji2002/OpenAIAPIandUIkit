//
//  NetworkManagerImg.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 20.01.2025.
//

import Foundation

class NetworkManagerImg {
    
    let stringURL = "https://bothub.chat/api/v2/openai/v1/images/generations"
    let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI0LTc1NmUtNDVlOC04YWYxLTFlMWNkMDRkMDE1NyIsImlzRGV2ZWxvcGVyIjp0cnVlLCJpYXQiOjE3MzUzOTA3NjIsImV4cCI6MjA1MDk2Njc2Mn0.xL2fhtLOtHp_K4Xn_bEAhuKgnRwYlUGwaRk-XxirgdY"
    
    func sendSecondRequest(prompt: String, completion: @escaping ([Data]) -> Void) {
        let urlComponents = URLComponents(string: stringURL)
        guard let reqURL = urlComponents?.url else { return }
        
        var urlRequest = URLRequest(url: reqURL)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyStruct = ApiRequest(model: "dall-e-3", prompt: prompt, n: 1, size: "1024x1024")
        
        do {
            let body = try JSONEncoder().encode(bodyStruct)
            urlRequest.httpBody = body
        } catch {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, err in
            guard err == nil, let data else { return }
            
            do {
                let result = try JSONDecoder().decode(ApiImageResponce.self, from: data)
                completion(result.data)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
}
