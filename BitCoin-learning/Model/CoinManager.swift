//
//  CoinManager.swift
//  BitCoin-learning
//
//  Created by Łukasz Rajczewski on 07/11/2020.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinData: CoinData)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
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
                    delegate?.didFailWithError(error: error!)
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
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: coinData)
            let currencyName = decodedData.asset_id_quote
            let currencyRate = decodedData.rate
            
            let coinData = CoinData(currency: currencyName, rate: currencyRate)
            delegate?.didUpdateCurrency(coinData)
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
}
