//
//  PasswordGenerator.swift
//  PassGen
//
//  Created by Andrej Kolar on 11.02.2022..
//

import Foundation

struct PasswordGenerator {
    struct Constants {
        static let defaultLength = 16
    }
    
    private let characters: [String] = [
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        "abcdefghijklmnopqrstuvwxyz",
        "0123456789",
        "!@#$%^&*()+_-=}{[]|:;\"/?.><,`~"
    ]
    
    public func generate(length: Int? = nil) -> String {
        let passwordLength = length ?? Constants.defaultLength
        
        let password = (0..<passwordLength)
            .compactMap { _ in (0..<characters.count).randomElement() }
            .compactMap { characters[$0].randomElement() }
        
        return String(password)
    }
}
