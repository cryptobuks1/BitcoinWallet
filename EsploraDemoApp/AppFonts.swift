//
//  AppFonts.swift
//  EsploraDemoApp
//
//  Created by Asaad on 9/10/20.
//  Copyright © 2020 Animata Inc. All rights reserved.
//

import UIKit

struct TxLabelFont {
    let fontName =  "DINPro"
    let fontSize = 16.0 as CGFloat
}

struct AddrLabelFont {
    let fontName =  "DINPro"
    let fontSize = 16.0 as CGFloat
}

struct TitleFont {
    let fontName =  "DINPro-Medium"
    let fontSize = 16.0 as CGFloat
}

func strSizer(string: String, constrainedToWidth width: Double, fontName: String, fontSize: CGFloat) -> CGSize {
    return NSString(string: string).boundingRect(
        with: CGSize(width: width, height: .greatestFiniteMagnitude),
        options: .usesLineFragmentOrigin,
        attributes: [.font: UIFont.init(name: fontName, size: fontSize)! ],
        context: nil).size
}
