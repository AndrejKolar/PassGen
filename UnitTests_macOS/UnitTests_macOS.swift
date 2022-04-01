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
            PasswordGenerator.Defaults.lenght,
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
    
    func testDefaultOptions() {
        let password = sut.generate()
        let isNumeric = checkCharacters(password, type: .numbers)
        let isLowercase = checkCharacters(password, type: .lowercase)
        let isUppercase = checkCharacters(password, type: .uppercase)
        let isSymbol = checkCharacters(password, type: .symbols)
        
        XCTAssertFalse(isNumeric, "Password should not contain only numbers")
        XCTAssertFalse(isLowercase, "Password should not contain only lowercase letters")
        XCTAssertFalse(isUppercase, "Password should not contain only uppercase letters")
        XCTAssertFalse(isSymbol, "Password should not contain only symbols")
    }
    
    func testOnlyNumbers() {
        let password = sut.generate(options: [.numbers])
        let isNumeric = checkCharacters(password, type: .numbers)
        XCTAssertTrue(isNumeric, "Password is not number only")
    }
    
    func testOnlyLowerCase() {
        let password = sut.generate(options: [.lowercase])
        let isLowercase = checkCharacters(password, type: .lowercase)
        XCTAssertTrue(isLowercase, "Password should contain only lowercase letters")
    }
    
    func testOnlyUppercase() {
        let password = sut.generate(options: [.uppercase])
        let isUppercase = checkCharacters(password, type: .uppercase)
        XCTAssertTrue(isUppercase, "Password should contain only uppercase letters")
    }
    
    func testOnlySymbols() {
        let password = sut.generate(options: [.symbols])
        let isSymbol = checkCharacters(password, type: .symbols)
        
        XCTAssertTrue(isSymbol, "Password should contain only symbols")
    }
    
    // Helpers
    
    private func checkCharacters(_ password: String, type: PasswordGenerator.PasswordType) -> Bool {
        let typeCharacterSet = CharacterSet(charactersIn: type.rawValue)
        let passwordCharacterSet = CharacterSet(charactersIn: password)
        return passwordCharacterSet.isSubset(of: typeCharacterSet)
        
    }
}
