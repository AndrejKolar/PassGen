let generator = PasswordGenerator()
let password = generator.generate(
    type: .separated(8, 4, .space),
    characters: [.numbers, .lowercase, .uppercase]
)

print("Generated password:")
print(password)
