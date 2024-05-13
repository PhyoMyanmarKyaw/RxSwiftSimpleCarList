//
//  NetworkServiceTests.swift
//  CarsTests
//
//  Created by PhyoMyanmarKyaw on 26/03/2022.
//

import XCTest

@testable import Cars

class NetworkServiceTests: XCTestCase {
   
    func testParsing() throws {
        let bundle = Bundle(for: NetworkServiceTests.self)
        let url = bundle.url(forResource: "Cars", withExtension: "json")
        let data = try Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let model = try decoder.decode(CarModel.self, from: data).toPlainModel()
        
        XCTAssertEqual(model[0].title,
                       "Q7 - Greatness starts, when you don't stop.")
        XCTAssertEqual(model[0].dateTime, "25.05.2018 14:13")
        XCTAssertEqual(model[0].ingress,
                       "The Audi Q7 is the result of an ambitious idea: never cease to improve.")

    }
}
