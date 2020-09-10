//
//  BalanceTableViewCell.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/10/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import UIKit

class BalanceTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "balCell")
        self.resizeFrame()
        self.addCellSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //PROUD OF YOU
    
    func resizeFrame() {
        let sampleText = "Address"
    }
    
    func addCellSubviews() {
        
    }
}
