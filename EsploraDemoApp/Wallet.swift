//
//  Wallet.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/8/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

class Wallet {
    var balance: Int
    var addressArr: [Address]
    
    init() {
        self.balance = 0
        self.addressArr = [Address]()
    }
    
    init(balance: Int, addressArr: [Address]) {
        self.balance = balance
        self.addressArr = addressArr
    }
    
    func updateBalance(val: Int) {
        balance += val
    }
    
    func getBal() -> Int {
        return balance
    }
    
    func sumBal() -> Int {
        var wallBal = 0
        for addr in addressArr {
            wallBal += addr.balance
        }
        return wallBal
    }
}
