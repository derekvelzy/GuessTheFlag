//
//  Examples.swift
//  GuessTheFlag
//
//  Created by Derek Velzy on 10/19/21.
//

import SwiftUI

struct ContentViewz: View {
    @State private var showAlert = false

    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .red]), center: .center).ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Text("Hello, world!")
                Text("Hello, people im here")
                ZStack {
                    Text("one on top")
                    Text("the other is on bottom")
                }
                Spacer()
                Button("Tap me!") {
                    self.showAlert = true
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("ALERT!!"), message: Text("just saying hi :)"), dismissButton: .default(Text("ok")))
                }
                Button(action: {
                    print("tap me")
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "pencil")
                        Text("other type")
                    }
                }
                Spacer()
                HStack(spacing: 80) {
                    Text("hola")
                    Text("senior")
                }
                .background(Color.yellow)
            }
        }
    }
}
