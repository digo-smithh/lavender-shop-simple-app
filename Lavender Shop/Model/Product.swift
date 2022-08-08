//
//  Products.swift
//  Lavender Shop
//
//  Created by Rodrigo Smith Rodrigues on 01/08/22.
//
import Foundation

struct Product: Decodable {
    var code: Int?
    var name: String
    var amount: Int
}

extension Product: Hashable {}
