//
//  AddressTableHeader.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/10/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import Foundation
import UIKit

class AddressTableHeader: UITableViewHeaderFooterView {
    var addrLabel: UILabel!
    var Insets: LabelInset
    var AddrList: AddressList
    struct LabelInset {
        let left = 19 as CGFloat
        let right = 19 as CGFloat
        let top = 19 as CGFloat
        let bttm = 19 as CGFloat
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(reuseIdentifier: String?) {
        Insets = LabelInset()
        AddrList = AddressList()
        super.init(reuseIdentifier: "addrHeader")
        addAddrLabel()
        resizeFrame()
    }
    
    func addAddrLabel() {
        addrLabel = UILabel()
        let font = UIFont(name: AddrLabelFont().fontName, size: AddrLabelFont().fontSize)
        let nLines = 2
        addrLabel.numberOfLines = nLines
        addrLabel.lineBreakMode = .byWordWrapping
        let w = UIScreen.main.bounds.width - 2 * Insets.left
        let frame = CGRect(x: 0, y: 0, width: w, height: font!.lineHeight * CGFloat(nLines))
        addrLabel.frame = frame
        addrLabel.font = font
        addrLabel.layer.position = CGPoint(x: Insets.left + 0.5 * w, y: self.frame.size.height * 0.5)
        self.contentView.addSubview(addrLabel)
    }
    
    func resizeFrame() {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: addrLabel.frame.size.height + Insets.top + Insets.bttm)
        addrLabel.layer.position = CGPoint(x: Insets.left + 0.5 * addrLabel.frame.size.width, y: self.frame.size.height * 0.5)
    }
}

