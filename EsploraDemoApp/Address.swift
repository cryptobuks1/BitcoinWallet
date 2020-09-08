//
//  Address.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/8/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

class Address {
    var balance: Int
    var txHistory: [String]
    
    struct UTXO: Codable {
        var txid: String
        var vout: Int
        var value: Int
        var status: Status
    }
    
    struct Status: Codable {
        let confirmed: Bool
        let blockHeight: Int?
        let blockHash: String?
        let blockTime: Int?
    }
    
    init(bal: Int, hist: [String]) {
        self.balance = bal
        self.txHistory = hist
    }
}
