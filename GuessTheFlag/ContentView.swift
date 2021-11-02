//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Derek Velzy on 10/19/21.
//

// Custom Modifier
struct FlagImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var guessedAnswer = 0
    @State private var round = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()
        
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) {
                        number in
                        Button(action: {
                            //flag tapped
                            self.flagTapped(number)
                        }) {
                            FlagImage(image: self.countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.weight(.bold))
                
                Spacer()
            }
            .padding()
        }
        .alert(isPresented: $showingScore) {
            if scoreTitle == "Correct" {
                return Alert(
                    title: Text(scoreTitle),
                    message: (Text("Your score is \(score)")),
                    dismissButton:
                        .default(Text("Continue")) {
                            self.askQuestion()
                        }
                )
            } else if scoreTitle == "Wrong" {
                return Alert(
                    title: Text(scoreTitle),
                    message: (Text("That's the flag of \(countries[guessedAnswer])")),
                    dismissButton:
                        .default(Text("Continue")) {
                            self.askQuestion()
                        }
                )
            } else {
                return Alert(
                    title: Text(scoreTitle),
                    message: (Text("Your score was \(score)/5")),
                    dismissButton:
                        .default(Text("Play Again")) {
                            self.score = 0
                            self.round = 0
                        }
                )
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        round += 1
        if round == 5 {
            if number == correctAnswer {
                score += 1
            }
            scoreTitle = "Game Over"
        } else if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
        guessedAnswer = number
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
