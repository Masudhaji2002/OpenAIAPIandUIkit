//
//  ModelImage.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 20.01.2025.
//

struct ApiRequest: Encodable {
    let model: String
    let prompt: String
    let n: Int
    let size: String
}

struct ApiImageResponce: Decodable {
    let data: [Data]
}

struct Data: Decodable {
    let url: String
}
