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
    func didUpdateCurrency(rate: Double, currencyName: String) {
        DispatchQueue.main.async {
            self.currencyLabel.text = currencyName
            self.currencyValue.text = String(format: "%.4f", rate)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

// MARK: - UIPickerView DataSource & Delegate

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
        coinManager.getCoinPrice(currencyName)
    } 
}



