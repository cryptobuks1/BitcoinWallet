//
//  Address.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/8/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

//Note: you'll also need to update the tablerows with newly incoming
//either executed on actions:
//1. when didSet class addressArr
//2. when completionHandler, perform insert row

//SO the logic:
//1. Load the sections dry from the hardcoded addresses. UI should display 10 sections that have no cells.
//2. As completion handler marks completion, if data is not empty or nil, update the classInstance and then reload section when data is updated.
//3. Take care of collapsing expanding later.
//Will also need the address title.

//Get the address title, get rid of txHistory array.

//GO AT LIGHTSPEED>

class Address {
    var address: String
    var balance: Int
    var transactions: [UTXO]
    var expanded: Bool //UI property
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
    
    //TODO: Address edge case where incoming transasction is inserted into a section that's already expanded. Check if section.isExpanded == true -> set address.expanded = true NOT false.
    init(_ utxo: [UTXO], _ address: String, _  bal: Int, _ expanded: Bool) {
        self.address = address
        self.balance = bal
        self.expanded = expanded
        self.transactions = utxo
    }
}
