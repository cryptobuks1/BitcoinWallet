//
//  TransactionTableViewCell.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/10/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    var txIDLabel: UILabel!
    var statusLabel: UILabel!
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        Insets = LabelInset()
        AddrList = AddressList()
        super.init(style: style, reuseIdentifier: "txCell")
        addTxIDLabel()
        resizeFrame()
        addConfirmationStatusLabel()
    }
    
    func addTxIDLabel() {
        txIDLabel = UILabel()
        let font = UIFont(name: TxLabelFont().fontName, size: TxLabelFont().fontSize)
        let nLines = 3 //TODO: Ideally, get the number of lines from a boundingRect whose height is defined by the stringLength. nLines is assumed to be fixed in this case.
        txIDLabel.numberOfLines = nLines
        txIDLabel.lineBreakMode = .byWordWrapping
        let widthRatio = 250 / 414 as CGFloat
        let w = widthRatio * UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 0, width: w, height: font!.lineHeight * CGFloat(nLines))
        txIDLabel.frame = frame
        txIDLabel.font = font
        txIDLabel.layer.position = CGPoint(x: Insets.left + 0.5 * w, y: self.frame.size.height * 0.5)
        self.contentView.addSubview(txIDLabel)
    }
    
    func addConfirmationStatusLabel() {
        statusLabel = UILabel()
        let font = UIFont(name: TxLabelFont().fontName, size: TxLabelFont().fontSize)
        let long = "Yes"
        let w = long.size(withAttributes: [.font: font!]).width
        let frame = CGRect(x: 0, y: 0, width: w, height: font!.lineHeight)
        statusLabel.frame = frame
        statusLabel.font = font
        statusLabel.layer.position = CGPoint(x: UIScreen.main.bounds.width - Insets.right - 0.5 * w, y: self.frame.size.height * 0.5)
        self.contentView.addSubview(statusLabel)
    }
    
    func resizeFrame() {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: txIDLabel.frame.size.height + Insets.top + Insets.bttm)
        txIDLabel.layer.position = CGPoint(x: Insets.left + 0.5 * txIDLabel.frame.size.width, y: self.frame.size.height * 0.5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
