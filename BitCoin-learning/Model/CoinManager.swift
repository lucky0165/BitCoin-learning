//
//  CoinManager.swift
//  BitCoin-learning
//
//  Created by Łukasz Rajczewski on 07/11/2020.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(rate: Double, currencyName: String)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "9BDE425D-CDFA-4EAA-B678-F409E670092E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(_ currencyName: String) {
        let urlString = "\(baseURL)\(currencyName)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error!)
                    return
                } else {
                    if let safeData = data {
                        if let currencyPrice = parseJSON(safeData) {
                            delegate?.didUpdateCurrency(rate: currencyPrice, currencyName: currencyName)
                        }
                       
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: coinData)
            let currencyRate = decodedData.rate
            return currencyRate
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
