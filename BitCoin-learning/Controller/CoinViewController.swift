//
//  ViewController.swift
//  BitCoin-learning
//
//  Created by Łukasz Rajczewski on 07/11/2020.
//

import UIKit

class CoinViewController: UIViewController {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self 
        picker.dataSource = self
        picker.delegate = self 
    }
}

// MARK: - CoinManagerDelegate

extension CoinViewController: CoinManagerDelegate {
    func didUpdateCurrency(_ coinData: CoinData) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coinData.currency
            self.currencyValue.text = coinData.rateAsString
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension CoinViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyName = coinManager.currencyArray[row]
        coinManager.fetchData(currencyName)
    }
}



