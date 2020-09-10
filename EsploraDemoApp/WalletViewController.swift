//
//  WalletViewController.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/3/20.
//

import Foundation
import UIKit

//now start to optimize the UI
// start with header rows should be sized to the tablerow
// tablerow add label and constrain + confirmation tag yes/no
// then headerlabel size to same height as table row.
// to each section add first table row = transaction / balance titles

class WalletViewController: UITableViewController {
    var TxWallet: Wallet!
    var URLBuild: URLBuilder!
    var SatoshiConvt: SatoshiConverter!
    let balCell = "balCell"
    let addressCell = "addressCell"
    let txCell = "txCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        URLBuild = URLBuilder()
        SatoshiConvt = SatoshiConverter()
        constructWallet()
        navigationItem.title = "Wallet"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: balCell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: addressCell)
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "txCell")
        
        printFontNames()
    }

    func printFontNames() {
        for family: String in UIFont.familyNames {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TxWallet.addressArr.count + 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return TxWallet.addressArr[section - 1].transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: balCell, for: indexPath)
            cell.textLabel?.text = String(SatoshiConvt.tBTC(TxWallet.balance)) + " " + SatoshiConvt.displCurrUnit
            return cell
        } else {
            let cell: TransactionTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "txCell") as? TransactionTableViewCell
            //cell.textLabel?.text = TxWallet.addressArr[indexPath.section - 1].transactions[indexPath.row].txid
            cell.txIDLabel.text = TxWallet.addressArr[indexPath.section - 1].transactions[indexPath.row].txid
            cell.statusLabel.text = TxWallet.addressArr[indexPath.section - 1].transactions[indexPath.row].strStatus()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.lightGray
        if section == 0 {
            label.text = "Balance"
        } else {
            label.text = TxWallet.addressArr[section - 1].address
        }
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "txCell") as? TransactionTableViewCell {
            return cell.frame.size.height
        }
        return tableView.cellForRow(at: indexPath)!.frame.size.height
    }
    
    func constructWallet() {
        TxWallet = Wallet()
        for addr in AddressList().list {
            addressBalance(addr) { (utxo, balance) in
                let address = Address(utxo, addr, balance, false)
                self.TxWallet.addressArr.append(address)
                self.TxWallet.updateBalance(val: address.balance)
                //TODO: Rather than reload entire table, reload by section (address), or as new table rows are added or updated.
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
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

