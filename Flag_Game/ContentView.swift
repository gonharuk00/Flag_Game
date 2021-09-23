
//
//  ContentView.swift
//  learN
//
//  Created by Alex Honcharuk on 13.01.2021.
//

import SwiftUI


struct ContentView: View {
    
    @State private var countries = ["USA", "UK","Bangladesh","Sweden", "Germany", "Brazil", "Argentina", "Russia", "Greece", "Canada"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black ,Color.secondary, Color.white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 40) {
                VStack{
                    Text("Выбери флаг :")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3){number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }, label: {
                        Image(self.countries[number])
                            .frame(width: 250, height: 125, alignment: .center)
                            .clipShape(Capsule(), style: FillStyle())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                        
                    })
                }
                Text("Общий счет : \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Spacer()
            }
        }.alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle),
                  message: Text("Общий счет : \(score)"),
                  dismissButton:.default(Text("Продолжить")) {
                self.askQuestion()
            })
        })
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Правильный ответ"
            score = score + 1
        }else{
            scoreTitle = "Неправильный ответ. Это флаг \(countries[number])"
            score = score - 1

        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

