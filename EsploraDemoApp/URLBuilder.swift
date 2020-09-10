//
//  URLBuilder.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/9/20.
//

import Foundation

class URLBuilder {
    func url(_ address: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "blockstream.info"
        let subpath = "\(address)/utxo"
        components.path = "/testnet/api/address/\(subpath)"
        return components.url
    }
}
