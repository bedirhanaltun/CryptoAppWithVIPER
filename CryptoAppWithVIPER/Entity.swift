//
//  Entity.swift
//  CryptoAppWithVIPER
//
//  Created by Bedirhan Altun on 19.09.2022.
//

import Foundation

//Struct
//Take data from Internet --> Decodable

struct Crypto: Decodable{
    let currency: String
    let price: String
}
