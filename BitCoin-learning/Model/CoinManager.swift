//
//  CoinManager.swift
//  BitCoin-learning
//
//  Created by Łukasz Rajczewski on 07/11/2020.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "9BDE425D-CDFA-4EAA-B678-F409E670092E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func fetchData(_ currencyName: String) {
        let url = "\(baseURL)\(currencyName)?apikey=\(apiKey)"
        performRequest(url)
    }
    
    func performRequest(_ url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let safeData = data {
                        parseJSON(safeData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) {
        
    }
}
