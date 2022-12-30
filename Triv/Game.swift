//
//  Game.swift
//  Triv
//
//  Created by Kenneth Jones on 8/28/22.
//

import Foundation

class Game: ObservableObject {
    enum GameStatus {
        case notPlaying
        case playing
    }
    
    var allQuestions: [Question] = []
    var answeredQuestions: [Int] = []
    var recentScores = [0, 0, 0]
    var score = 0
    var currentQuestion: Question?
    
    @Published private(set) var gameStatus: GameStatus = .notPlaying
    
    init() {
        decodeQuestions()
    }
    
    func startGame() {
        score = 0
        answeredQuestions = []
        gameStatus = .playing
    }
    
    func correct() {
        score += currentQuestion!.potentialScore
        answeredQuestions.append(currentQuestion!.id)
    }
    
    func nextQuestion() -> [String] {
        var potentialQuestion = allQuestions.randomElement()
        while answeredQuestions.contains(potentialQuestion!.id) {
            potentialQuestion = allQuestions.randomElement()
        }
        currentQuestion = potentialQuestion
        print("Current Question 🥶😶‍🌫️: \(currentQuestion!)")
        
        var answers: [String] = []
        for answer in currentQuestion!.answers.keys {
            answers.append(answer)
        }
        
        return answers.shuffled()
    }
    
    func endGame() {
        recentScores[2] = recentScores[1]
        recentScores[1] = recentScores[0]
        recentScores[0] = score
        gameStatus = .notPlaying
    }
    
    private func decodeQuestions() {
        if let url = Bundle.main.url(forResource: "trivia", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                allQuestions = try decoder.decode([Question].self, from: data)
                print(allQuestions)
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
}
