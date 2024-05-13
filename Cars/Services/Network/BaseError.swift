//
//  BaseError.swift
//  Cars
//
//  Created by PhyoMyanmarKyaw on 25/03/2022.
//

import Foundation

struct BaseError: Error {
    var errorDescription: String?
    
    init(_ description: String) {
        errorDescription = description
    }
}
