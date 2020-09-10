//
//  WalletViewController.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/3/20.
//

import Foundation
import UIKit

class WalletViewController: UITableViewController {
    var TxWallet: Wallet!
    var URLBuild: URLBuilder!
    var SatoshiConvt: SatoshiConverter!
    let balCellID = "balCell"
    let txCellID = "txCell"
    let headerCellID = "addrHeader"
    override func viewDidLoad() {
        super.viewDidLoad()
        URLBuild = URLBuilder()
        SatoshiConvt = SatoshiConverter()
        constructWallet()
        navigationItem.title = "Wallet"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(BalanceTableViewCell.self, forCellReuseIdentifier: balCellID)
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: txCellID)
        tableView.register(AddressTableHeader.self, forHeaderFooterViewReuseIdentifier: headerCellID)
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
        if indexPath.section == 0 {
            let cell: BalanceTableViewCell! = tableView.dequeueReusableCell(withIdentifier: balCellID) as? BalanceTableViewCell
            cell.balanceLabel?.text = String(SatoshiConvt.tBTC(TxWallet.balance)) + " " + SatoshiConvt.displCurrUnit
            return cell
        } else {
            let cell: TransactionTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "txCell") as? TransactionTableViewCell
            cell.txIDLabel.text = TxWallet.addressArr[indexPath.section - 1].transactions[indexPath.row].txid
            cell.statusLabel.text = TxWallet.addressArr[indexPath.section - 1].transactions[indexPath.row].strStatus()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "addrHeader") as! AddressTableHeader
        if section == 0 {
            view.isHidden = true
        } else {
            view.addrLabel.text = TxWallet.addressArr[section - 1].address
        }
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "addrHeader") as? AddressTableHeader {
            if section == 0 {
                return 0
            }
            return view.frame.size.height
        }
        return tableView.cellForRow(at: IndexPath())!.frame.size.height
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "txCell") as? TransactionTableViewCell {
            return cell.frame.size.height
        }
        return tableView.cellForRow(at: indexPath)!.frame.size.height
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
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

