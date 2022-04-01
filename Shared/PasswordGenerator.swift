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
        static let options: Set<CharacterType> = [
            .uppercase,
            .lowercase,
            .numbers,
            .symbols
        ]
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
}
