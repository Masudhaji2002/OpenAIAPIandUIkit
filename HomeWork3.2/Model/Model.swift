//
//  Model.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 18.01.2025.
//

struct OpenAIRequest: Encodable {
    let model: String
    let messages: [Messages]
}

struct Messages: Codable {
    let role: String
    let content: String
}

struct Choice: Decodable {
    let message: Messages
}

struct Responce: Decodable {
    let choices: [Choice]
}

