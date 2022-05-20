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
            PasswordGenerator.Defaults.length,
            "Password is not the default length"
        )
    }
    
    func testCustomPasswordLength() {
        let length = 17
        XCTAssertEqual(
            sut.generate(type: .normal(length)).count,
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
        let password = sut.generate(characters: [.numbers])
        let isNumeric = checkCharacters(password, type: .numbers)
        XCTAssertTrue(isNumeric, "Password is not number only")
    }

    func testOnlyLowerCase() {
        let password = sut.generate(characters: [.lowercase])
        let isLowercase = checkCharacters(password, type: .lowercase)
        XCTAssertTrue(isLowercase, "Password should contain only lowercase letters")
    }

    func testOnlyUppercase() {
        let password = sut.generate(characters: [.uppercase])
        let isUppercase = checkCharacters(password, type: .uppercase)
        XCTAssertTrue(isUppercase, "Password should contain only uppercase letters")
    }

    func testOnlySymbols() {
        let password = sut.generate(characters: [.symbols])
        let isSymbol = checkCharacters(password, type: .symbols)

        XCTAssertTrue(isSymbol, "Password should contain only symbols")
    }

    func testWithSeparatorsLength() {
        let wordLength = 4
        let wordCount = 4

        let length = lengthWithSeparator(wordLength: wordLength, wordCount: wordCount)

        let password = sut.generate(
            type: .separated(wordLength, wordCount, .verticalBar),
            characters: [.uppercase]
        )

        XCTAssertEqual(
            password.count,
            length,
            "Password is not the correct length"
        )
    }
    
    func testWithSeparatorsCharacters() {
        let wordLength = 4
        let wordCount = 4

        let password = sut.generate(
            type: .separated(wordLength, wordCount, .verticalBar),
            characters: [.uppercase]
        )
        
        XCTAssertTrue(checkIfSeparator(password, index: 4, separator: "|"), "Character is not a separator")
        XCTAssertTrue(checkIfSeparator(password, index: 9, separator: "|"), "Character is not a separator")
        XCTAssertTrue(checkIfSeparator(password, index: 14, separator: "|"), "Character is not a separator")
        
        XCTAssertFalse(checkIfSeparator(password, index: 1, separator: "|"), "Separator at wrong place")
        XCTAssertFalse(checkIfSeparator(password, index: 10, separator: "|"), "Separator at wrong place")
        XCTAssertFalse(checkIfSeparator(password, index: 13, separator: "|"), "Separator at wrong place")
        
        XCTAssertFalse(checkIfSeparator(password, index: 4, separator: "_"), "Wrong separator character")
        XCTAssertFalse(checkIfSeparator(password, index: 9, separator: " "), "Wrong separator character")
        XCTAssertFalse(checkIfSeparator(password, index: 14, separator: "/"), "Wrong separator character")
    }
    
    // Helpers
    
    private func checkCharacters(_ password: String, type: PasswordGenerator.CharacterType) -> Bool {
        let typeCharacterSet = CharacterSet(charactersIn: type.rawValue)
        let passwordCharacterSet = CharacterSet(charactersIn: password)
        return passwordCharacterSet.isSubset(of: typeCharacterSet)
        
    }
    
    private func lengthWithSeparator(wordLength: Int, wordCount: Int) -> Int {
        (wordLength * wordCount) + (wordCount - 1)
    }
    
    private func checkIfSeparator(_ password: String, index: Int, separator: Character) -> Bool {
        let char = password[password.index(password.startIndex, offsetBy: index)]
        return char == separator
    }
}
