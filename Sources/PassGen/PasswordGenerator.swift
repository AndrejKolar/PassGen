//
//  PasswordGenerator.swift
//  
//
//  Created by Andrej Kolar on 6/8/22.
//

import Foundation

struct PasswordGenerator {
    public struct Defaults {
        static let length = 16
        static let wordLength = 8
        static let wordCount = 4
        static let type: PasswordType = .normal(Defaults.length)
        static let characters: Set<CharacterType> = [
            .uppercase,
            .lowercase,
            .numbers,
            .symbols
        ]
        static let separator: SeparatorType = .space
    }
    
    enum PasswordType {
        case normal(Int)
        case separated(Int, Int, SeparatorType)
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
    
    public func generate(
        type: PasswordType? = nil,
        characters: Set<CharacterType>? = nil
    ) -> String {
        
        var passwordLength = Defaults.length
        
        var separatorIndices: [Int] = []
        var separatorCharacter = Defaults.separator.rawValue
        
        let typeOption = type ?? Defaults.type
        switch typeOption {
        case .normal(let length):
            passwordLength = length
            
        case .separated(let wordLength, let wordCount, let separator):
            let separatorCount = wordCount - 1
            passwordLength = (wordLength * wordCount) + (separatorCount)
            
            separatorIndices = (0..<separatorCount)
                .compactMap { index in
                    ((index + 1) * wordLength) + (index * 1)
                }
            
            separatorCharacter = separator.rawValue
        }
        
        let characterOptions = characters ?? Defaults.characters
        let charactersArray = characterOptions.map { $0.rawValue }
        
        let characterArrays: [String] = (0..<passwordLength)
            .compactMap { index in
                guard case .separated = typeOption else {
                    return charactersArray.randomElement()
                }
                
                let isSeparator = separatorIndices.contains(index)
                
                return isSeparator ? separatorCharacter : charactersArray.randomElement()
            }
        
        let pass = characterArrays.compactMap {
            $0.randomElement()
        }
        
        return String(pass)
    }
}
