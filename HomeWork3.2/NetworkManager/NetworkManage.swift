//
//  NetworkManage.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 18.01.2025.
//

import Foundation


class NetworkManage {
    
    let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI0LTc1NmUtNDVlOC04YWYxLTFlMWNkMDRkMDE1NyIsImlzRGV2ZWxvcGVyIjp0cnVlLCJpYXQiOjE3MzUzOTA3NjIsImV4cCI6MjA1MDk2Njc2Mn0.xL2fhtLOtHp_K4Xn_bEAhuKgnRwYlUGwaRk-XxirgdY"
    
     let baseURL = "https://bothub.chat/api/v2/openai/v1/chat/completions"
    
   
    
    func sendRequest(message: String, completion: @escaping ([Choice]) -> Void) {
        let urlComponents = URLComponents(string: baseURL)
        guard let reqUrl = urlComponents?.url else { return }
        
        var request = URLRequest(url: reqUrl)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
       
        
        let requestBody = OpenAIRequest(model: "gpt-4o", messages: [Messages(role: "user", content: message)])
        
        do {
            let body = try JSONEncoder().encode(requestBody)
            request.httpBody = body
        } catch  {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard error == nil, let data else {return}
            
            do {
                let decodedResponse = try JSONDecoder().decode(Responce.self, from: data)
                completion(decodedResponse.choices)
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
