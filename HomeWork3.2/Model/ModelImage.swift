//
//  ModelImage.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 20.01.2025.
//


struct ApiImageResponce: Decodable {
    let data: [Data]
}

struct Data: Decodable {
    let url: String
}
