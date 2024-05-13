//
//  DesignableLabel.swift
//  Cars
//
//  Created by PhyoMyanmarKyaw on 26/03/2022.
//

import UIKit

@IBDesignable
class DesignableLabel: UILabel {
    @IBInspectable var lineHeight: CGFloat = 20 {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
            paragraphStyle.alignment = self.textAlignment

            let attrString = NSMutableAttributedString(string: text!)
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
            attributedText = attrString
        }
    }
}
