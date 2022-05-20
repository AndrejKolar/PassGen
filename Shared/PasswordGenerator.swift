//
//  PasswordGenerator.swift
//  PassGen
//
//  Created by Andrej Kolar on 11.02.2022..
//

import Foundation

struct PasswordGenerator {
    public struct Defaults {
        static let lenght = 16
        static let wordLength = 8
        static let wordCount = 4
        static let options: Set<CharacterType> = [
            .uppercase,
            .lowercase,
            .numbers,
            .symbols
        ]
        static let separator: SeparatorType = .hyphen
    }
    
    public struct Options {
        let upperCase: Bool
        let lowerCase: Bool
        let numbers: Bool
        let symbols: Bool
    }
    
    enum CharacterType: String {
        case uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        case lowercase = "abcdefghijklmnopqrstuvwxyz"
        case numbers = "0123456789"
        case symbols = "!@#$%^&*()+_-=}{[]|:;\"/?.><,`~"
    }
    
    enum SeparatorType: String {
        case hyphen = "-"
        case underscore = "_"
        case space = " "
        case slash = "/"
        case verticalBar = "|"
    }
    
    public func generate(length: Int? = nil, options: Set<CharacterType>? = nil) -> String {
        let passwordLength = length ?? Defaults.lenght
        let passwordOptions = options ?? Defaults.options
        
        let charactersArray = passwordOptions.map {
            $0.rawValue
        }
        
        let password = (0..<passwordLength)
            .compactMap { _ in charactersArray.randomElement() }
            .compactMap { $0.randomElement() }
        
        return String(password)
    }
    
    public func generateWithSeparator(
        wordLength: Int? = nil,
        wordCount: Int? = nil,
        options: Set<CharacterType>? = nil,
        separator: SeparatorType? = nil
    ) -> String {
        let passwordOptions = options ?? Defaults.options
        let separatorOptions = separator ?? Defaults.separator
        let passwordWordLength = wordLength ?? Defaults.wordLength
        let passwordWordCount = wordCount ?? Defaults.wordCount
        
        let separatorCount = passwordWordCount - 1
        let passwordLength = (passwordWordLength * passwordWordCount) + (separatorCount)
        
        let charactersArray = passwordOptions.map { $0.rawValue }
        let separatorCharacter = separatorOptions.rawValue
        
        let separatorIndices = (0..<separatorCount)
            .compactMap { index in
                ((index + 1) * passwordWordLength) + (index * 1)
            }
        
        let characterArrays: [String] = (0..<passwordLength)
            .compactMap { index in
                let isSeparator = separatorIndices.contains(index)
                
                return isSeparator ? separatorCharacter : charactersArray.randomElement()
            }
        
        let pass = characterArrays.compactMap {
            $0.randomElement()
        }
        
        return String(pass)
    }
}
