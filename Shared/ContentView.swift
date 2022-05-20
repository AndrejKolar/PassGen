//
//  ContentView.swift
//  Shared
//
//  Created by Andrej Kolar on 11.02.2022..
//

import SwiftUI

struct ContentView: View {
    @State private var password = "Password"
    @State private var length: Int = PasswordGenerator.Defaults.length
    
    private let generator = PasswordGenerator()
    
    var body: some View {
        VStack {
            Text(password)
                .textSelection(.enabled)
                .padding()
            HStack {
                Stepper("Length", value: $length, in: 1...99)
                Text(String(length))
            }
            .padding()
          
            Button(action: {
                password = generator.generate(type: .normal(length))
            }) {
                Text("Generate")
            }
        }.frame(minWidth: 200, minHeight: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
