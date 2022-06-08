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
        static let configuration =  CommandConfiguration(abstract: "Generates a string password", version: "1.0.0")
        
        @Argument(help: "Password length") var length: Int = 16
        
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
        static let configuration =  CommandConfiguration(abstract: "Generates a password with separators", version: "1.0.0")
        
        @Argument(help: "Word length") var wordLength: Int = 8
        @Argument(help: "Word count") var wordCount: Int = 4
        
        func validate() throws {
            guard wordLength >= 3 else {
                throw ValidationError("Word length must be at least 3.")
            }
            
            guard wordCount >= 2 else {
                throw ValidationError("Word count must be at least 2.")
            }
        }
        
        mutating func run() throws {
            
            let generator = PasswordGenerator()
            let password = generator.generate(
                type: .separated(wordLength, wordCount, .space),
                characters: [.numbers, .lowercase, .uppercase]
            )
            
            print("Generated password:")
            print(password)
            
        }
    }
}
