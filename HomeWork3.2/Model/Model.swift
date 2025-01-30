//
//  Model.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 18.01.2025.
//


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

