//
//  PasswordGenerator.swift
//  PassGen
//
//  Created by Andrej Kolar on 11.02.2022..
//

import Foundation

struct PasswordGenerator {
    
    private let characters: [String] = [
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        "abcdefghijklmnopqrstuvwxyz",
        "0123456789"
    ]
    
    public func generate(length: Int = 9) -> String {
        let password = (0..<length)
            .compactMap { _ in (0..<characters.count).randomElement() }
            .compactMap { characters[$0].randomElement() }
        
        return String(password)
    }
}
