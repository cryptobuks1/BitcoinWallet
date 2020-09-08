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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constructWallet()
    }
    
    func constructWallet() {
        TxWallet = Wallet()
        for addr in AddressList().list {
            addressBalance(addr) { (balance) in
                let address = Address(bal: balance, hist: [""])
                self.TxWallet.addressArr.append(address)
                self.TxWallet.updateBalance(val: address.balance)
            }
        }
    }
    
    func addressBalance(_ address: String, completion: @escaping (Int) -> Void) {
        var addrBal = 0
        getAddrUtxo(address) { (arr, err) in
            guard let utxoArr = arr else { return }
            if !utxoArr.isEmpty {
                for utxo in utxoArr {
                    let amt = utxo.value
                    addrBal += amt
                }
            }
            completion(addrBal)
        }
    }
    
    func getAddrUtxo(_ address: String, completion: @escaping ([Address.UTXO]?, Error?) -> Void) {
        guard let url = url(address) else {
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
    
    func url(_ address: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "blockstream.info"
        let subpath = "\(address)/utxo"
        components.path = "/testnet/api/address/\(subpath)"
        return components.url
    }
}
