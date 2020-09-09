//
//  WalletViewController.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/3/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import Foundation
import UIKit

class WalletViewController: UIViewController {
    var TxWallet: Wallet!
    var URLBuild: URLBuilder!
    let cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        URLBuild = URLBuilder()
        constructWallet()
    }
    
    func constructWallet() {
        TxWallet = Wallet()
        for addr in AddressList().list {
            addressBalance(addr) { (utxo, balance) in
                let address = Address(utxo, addr, balance, false)
                self.TxWallet.addressArr.append(address)
                self.TxWallet.updateBalance(val: address.balance)
            }
        }
    }
    
    func addressBalance(_ address: String, completion: @escaping ([Address.UTXO], Int) -> Void) {
        var addrBal = 0
        getAddrUtxo(address) { (arr, err) in
            guard let utxoArr = arr else { return }
            if !utxoArr.isEmpty {
                for utxo in utxoArr {
                    let amt = utxo.value
                    addrBal += amt
                }
            }
            completion(utxoArr, addrBal)
        }
    }
    
    func getAddrUtxo(_ address: String, completion: @escaping ([Address.UTXO]?, Error?) -> Void) {
        guard let url = URLBuild.url(address) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("utxo err:, ", error)
                return
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let utxoArr = try decoder.decode([Address.UTXO].self, from: data)
                completion(utxoArr, nil)
            } catch {
                print("utxo decoder err:, ", error)
            }
        }
        task.resume()
    }
}

