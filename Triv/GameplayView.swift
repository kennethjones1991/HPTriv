//
//  GameplayView.swift
//  Triv
//
//  Created by Kenneth Jones on 1/7/23.
//

import SwiftUI

struct GameplayView: View {
    @State private var currentQuestion = 1
    @State private var score = 0
    @State private var questions = ["What is the name of Harry's owl?", "What is the name of the wizarding school in Scotland?", "Who is the author of the Harry Potter series?"]
    @State private var answers = [["Hedwig", "Errol", "Pigwidgeon"], ["Hogwarts", "Beauxbatons", "Durmstrang"], ["J.K. Rowling", "Stephen King", "George R.R. Martin"]]
    @State private var correctAnswers = [0, 2, 0]
    @State private var selectedAnswer = -1

    var body: some View {
        VStack {
            Text("Question \(currentQuestion) of \(questions.count)")
                .font(.title)
                .foregroundColor(.gray)
            Text(questions[currentQuestion-1])
                .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 20)
            ForEach(0 ..< answers[currentQuestion-1].count) { index in
                Button(action: {
                    self.selectedAnswer = index
                }) {
                    Text(self.answers[self.currentQuestion-1][index])
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(self.selectedAnswer == index ? Color.green : Color.blue)
                        .cornerRadius(10)
                }
            }
            Button(action: {
                if self.selectedAnswer == self.correctAnswers[self.currentQuestion-1] {
                    self.score += 1
                }
                if self.currentQuestion < self.questions.count {
                    self.currentQuestion += 1
                } else {
                    // game over, show final score
                }
                self.selectedAnswer = -1
            }) {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
    }
}


struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView()
    }
}
