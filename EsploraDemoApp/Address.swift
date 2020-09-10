//
//  Address.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/8/20.
//

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
