//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var coinManager = CoinManager()
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var currencySignLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        // Do any additional setup after loading the view.
        picker.delegate = self
        coinManager.delegate = self
    }


}
extension ViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return coinManager.currencyArray.count
    }
    
    
}

extension ViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(coinManager.currencyArray[row])
    }
}

extension ViewController:CoinManagerDelegate{
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
             let x = Float(price)
            print(x!)
            self.valueLabel.text = String(format: "%.2f", x!)
            self.currencySignLabel.text = currency
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
