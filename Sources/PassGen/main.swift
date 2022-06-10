import Foundation
import ArgumentParser

struct PassGen: ParsableCommand {
    static let configuration =  CommandConfiguration(
        abstract: "Generates a Random Password.",
        version: "1.0.0",
        subcommands: [Normal.self, Separated.self],
        defaultSubcommand: Normal.self
    )
}

PassGen.main()

extension PassGen {
    struct Normal: ParsableCommand {
        static let configuration =  CommandConfiguration(abstract: "Generates a string password. It uses uppercase, lowercase & number characters by default.", version: "1.0.0")
        
        @Option(name: .shortAndLong, help: "Length of the password.")
        var count: Int = 16
        
        @Flag(name: .shortAndLong, help: "Use number characters.")
        var numbers = false
        
        @Flag(name: [.long, .customShort("p")], help: "Use uppercase characters.")
        var uppercase = false

        @Flag(name: [.long, .customShort("w")], help: "Use lowercase characters.")
        var lowercase = false
        
        @Flag(name: .shortAndLong, help: "Use symbol characters.")
        var symbols = false
        
        func validate() throws {
            guard count >= 4 else {
                throw ValidationError("Password length must be at least 4.")
            }
        }
        
        mutating func run() throws {
            var characters: Set<PasswordGenerator.CharacterType> = []
            
            if numbers {
                characters.insert(.numbers)
            }
            
            if uppercase {
                characters.insert(.uppercase)
            }
            
            if lowercase {
                characters.insert(.lowercase)
            }
            
            if symbols {
                characters.insert(.symbols)
            }
            
            if characters.count == 0 {
                characters = [.lowercase, .uppercase, .numbers]
            }
            
            let generator = PasswordGenerator()
            let password = generator.generate(
                type: .normal(count),
                characters: characters
            )
            
            print("Generated password:")
            print(password)
        }
    }
    
    struct Separated: ParsableCommand {
        static let configuration =  CommandConfiguration(abstract: "Generates a password with separators. It uses uppercase, lowercase & number characters by default. The default separator is a space.", version: "1.0.0")
        
        @Option(name: .shortAndLong, help: "Length of a single segment.")
        var length: Int = 8
        
        @Option(name: .shortAndLong, help: "Number of segments.")
        var count: Int = 4
        
        @Flag(name: .shortAndLong, help: "Use hyphen for separator.")
        var dash = false
        
        @Flag(name: .shortAndLong, help: "Use slash for separator.")
        var slash = false
        
        @Flag(name: .shortAndLong, help: "Use underscore for separator.")
        var underscore = false
        
        @Flag(name: .shortAndLong, help: "Use bar for separator.")
        var bar = false
        
        @Flag(name: .shortAndLong, help: "Use number characters.")
        var numbers = false

        @Flag(name: [.long, .customShort("p")], help: "Use uppercase characters.")
        var uppercase = false

        @Flag(name: [.long, .customShort("w")], help: "Use lowercase characters.")
        var lowercase = false
        
        func validate() throws {
            guard length >= 3 else {
                throw ValidationError("Word length must be at least 3.")
            }
            
            guard count >= 2 else {
                throw ValidationError("Word count must be at least 2.")
            }
            
            let separatorFlagsOnCount = [dash, slash, underscore, bar].reduce(0) { $0 + ($1 ? 1 : 0) }
            
            if separatorFlagsOnCount > 1 {
                throw ValidationError("Pass in only one separator flag.")
            }
        }
        
        mutating func run() throws {
            
            var separator: PasswordGenerator.SeparatorType = .space
            
            if dash {
                separator = .hyphen
            } else if slash {
                separator = .slash
            } else if underscore {
                separator = .underscore
            } else if bar {
                separator = .verticalBar
            }
            
            let generator = PasswordGenerator()
            let password = generator.generate(
                type: .separated(length, count, separator),
                characters: [.numbers, .lowercase, .uppercase]
            )
            
            print("Generated password:")
            print(password)
            
        }
    }
}
