//
//  UIViewController+.swift
//  Cars
//
//  Created by PhyoMyanmarKyaw on 25/03/2022.
//

import UIKit

extension UIViewController {
    
    func getAlert(title: String, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
}
