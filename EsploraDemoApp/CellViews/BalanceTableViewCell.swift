//
//  BalanceTableViewCell.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/10/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import UIKit

class BalanceTableViewCell: UITableViewCell {
    var cellTitle: UILabel!
    var balanceLabel: UILabel!
    
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
        super.init(style: style, reuseIdentifier: "balCell")
        addCellTitle()
        resizeFrame()
        addBalanceLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCellTitle() {
        cellTitle = UILabel()
        let font = UIFont(name: TitleFont().fontName, size: TitleFont().fontSize)
        let str = "Balance"
        let w = str.size(withAttributes: [.font: font!]).width
        let frame = CGRect(x: 0, y: 0, width: w, height: font!.lineHeight * 3)
        cellTitle.text = str
        cellTitle.frame = frame
        cellTitle.font = font
        cellTitle.layer.position = CGPoint(x: Insets.left + 0.5 * w, y: self.frame.size.height * 0.5)
        self.contentView.addSubview(cellTitle)
    }
    
    func addBalanceLabel() {
        balanceLabel = UILabel()
        let fontForSizing = UIFont(name: TitleFont().fontName, size: TitleFont().fontSize)
        let w = UIScreen.main.bounds.width * 0.5
        let frame = CGRect(x: 0, y: 0, width: w, height: fontForSizing!.lineHeight * 3)
        let presentationFont = UIFont(name: BalanceFont().fontName, size: BalanceFont().fontSize)
        balanceLabel.frame = frame
        balanceLabel.font = presentationFont
        balanceLabel.textAlignment = .right
        balanceLabel.layer.position = CGPoint(x: UIScreen.main.bounds.width - Insets.right - 0.5 * w, y: self.frame.size.height * 0.5 - presentationFont!.descender * 0.5)
        self.contentView.addSubview(balanceLabel)
    }
    
    func resizeFrame() {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: cellTitle.frame.size.height + Insets.top + Insets.bttm)
        cellTitle.layer.position = CGPoint(x: Insets.left + 0.5 * cellTitle.frame.size.width, y: self.frame.size.height * 0.5)
    }
}
