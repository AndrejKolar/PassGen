//
//  UnitTests_macOS.swift
//  UnitTests_macOS
//
//  Created by Andrej Kolar on 30.03.2022..
//

import XCTest

@testable import PassGen

class UnitTests_macOS: XCTestCase {
    
    var sut: PasswordGenerator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PasswordGenerator()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func testGeneratePassword() {
        XCTAssertFalse(sut.generate().isEmpty, "Password is empty")
    }
    
    func testDefaultPasswordLength() {
        XCTAssertEqual(
            sut.generate().count,
            PasswordGenerator.Constants.defaultLength,
            "Password is not the default length"
        )
    }
    
    func testCustomPasswordLength() {
        let length = 17
        XCTAssertEqual(
            sut.generate(length: length).count,
            length,
            "Password is not the passed in length"
        )
    }
}
