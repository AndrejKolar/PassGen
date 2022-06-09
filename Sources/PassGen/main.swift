import ArgumentParser
import Foundation

struct PassGen: ParsableCommand {
    static let configuration =  CommandConfiguration(
        abstract: "Generates a Random Password",
        version: "1.0.0",
        subcommands: [Normal.self, Separated.self]
    )
}

PassGen.main()

extension PassGen {
    struct Normal: ParsableCommand {
        static let configuration =  CommandConfiguration(abstract: "Generates a string password.", version: "1.0.0")
        
        @Option(name: .shortAndLong, help: "Length of the password.")
        var length: Int = 16
        
        func validate() throws {
            guard length >= 4 else {
                throw ValidationError("Password length must be at least 4.")
            }
        }
        
        mutating func run() throws {
            
            let generator = PasswordGenerator()
            let password = generator.generate(
                type: .normal(length),
                characters: [.numbers, .lowercase, .uppercase]
            )
            
            print("Generated password:")
            print(password)
        }
    }
    
    struct Separated: ParsableCommand {
        static let configuration =  CommandConfiguration(abstract: "Generates a password with separators.", version: "1.0.0")
        
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
        
        func validate() throws {
            guard length >= 3 else {
                throw ValidationError("Word length must be at least 3.")
            }
            
            guard count >= 2 else {
                throw ValidationError("Word count must be at least 2.")
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
