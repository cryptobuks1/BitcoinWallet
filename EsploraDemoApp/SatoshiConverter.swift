//
//  SatoshiConverter.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/9/20.
//

import Foundation

class SatoshiConverter {
    let bitc_Satoshi: Double
    let displCurrUnit = "tBTC"
    init() {
        bitc_Satoshi = pow(10, 8)
    }
    
    func tBTC(_ satoshi: Int) -> Double {
        return Double(satoshi) / bitc_Satoshi
    }
}
