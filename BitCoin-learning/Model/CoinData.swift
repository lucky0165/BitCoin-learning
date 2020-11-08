//
//  CoinData.swift
//  BitCoin-learning
//
//  Created by Łukasz Rajczewski on 08/11/2020.
//

import Foundation

struct CoinData {
    let currency: String
    let rate: Double
    
    var rateAsString: String {
        return String(format: "%.5f", rate)
    }
}
