//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    
    //Create the method stubs wihtout implementation in the protocol.
    //It's usually a good idea to also pass along a reference to the current class.
    //e.g. func didUpdatePrice(_ coinManager: CoinManager, price: String, currency: String)
    //Check the Clima module for more info on this.
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}
struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "F9701812-F9DA-4D5A-A00E-8FCE4E9E6202"
    let currencyArray = ["TRY","AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(_ currency:String){
        let newURL = baseURL  + currency + "?apikey=" + apiKey
//        
        if let url = URL(string: newURL){
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                let rate = self.parseJSON(safeData)
                self.delegate?.didUpdatePrice(price: rate!, currency: currency)
              
            }
        }
        task.resume()
    }
}


func parseJSON(_ data:Data) -> String?{
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(CoinData.self, from: data)
        let lastRate = decodedData.rate
        return "\(lastRate!)"
        
    } catch {
        
        return nil
        
    }
}

}
