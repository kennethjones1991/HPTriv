//
//  Gameplay.swift
//  Triv
//
//  Created by Kenneth Jones on 9/24/22.
//

import SwiftUI
import AVKit

struct Gameplay: View {
    // Just for my future self to remember what I'm thinking,
    // I should probably refactor a lot of this code and have the Game.swift
    // file separated into a controller and a viewmodel like the Stanford
    // guy does for the EmojiMemory game. And then have the ViewModel
    // control the state of my views.
    @EnvironmentObject private var game: Game
    @Environment(\.dismiss) var dismiss
    @State var audioPlayer: AVAudioPlayer!
    @State var scaleText = false
    @State var answer1Slide = false
    @State var answer2Slide = false
    @State var answer3Slide = false
    @State var answer4Slide = false
    @State var hintSlide = false
    @State var bookSlide = false
    @State var hintWiggle = false
    @State var bookWiggle = false
    @State var revealHint = false
    @State var revealBook = false
    @State var tappedCorrectAnswer = false
    @State var tappedWrongAnswer = false
    @State var buttonSlideUp = false
    @State var scaleButton = false
    @State var scoreGoToScore = false
    @State var showNextLevel = false
    @State var answers = ["Question 1", "Question 2", "Question 3", "Question 4"]
    
    var body: some View {
        ZStack {
            Image("hogwarts")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 3, height: UIScreen.main.bounds.height * 1.05)
                .overlay(Rectangle().foregroundColor(.black).opacity(0.8))
            
            VStack {
                HStack {
                    Button("End Game") {
                        game.endGame()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red.opacity(0.5))
                    
                    Spacer()
                    
                    Text("Score: \(game.score)")
                }
                .padding()
                .padding([.top, .bottom], 30)
                
                Text(game.currentQuestion?.question ?? "What you want boy?")
                    .font(.custom("PartyLetPlain", size: 50))
                    .multilineTextAlignment(.center)
                    .padding()
                    .scaleEffect(scaleText ? 1 : 0)
                    .animation(.easeInOut(duration: 2).delay(0.5), value: scaleText)
                    .onAppear{
                        scaleText.toggle()
                    }
                    .opacity(tappedCorrectAnswer ? 0.1 : 1)
                
                HStack {
                    Image(systemName: "questionmark.app.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundColor(.cyan)
                        .rotationEffect(hintWiggle ? .degrees(-13) : .degrees(-17))
                        .padding()
                        .padding(.leading, 20)
                        .offset(x: hintSlide ? 0 : -UIScreen.main.bounds.width/2)
                        .onAppear {
                            withAnimation(.easeOut(duration: 1.5).delay(5)) {
                                hintSlide.toggle()
                            }
                            
                            hintWiggle.toggle()
                        }
                        .animation(.easeInOut(duration: 0.1).repeatCount(9).delay(7).repeatForever(), value: hintWiggle)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 1)) {
                                revealHint.toggle()
                            }
                            
                            playFlipSound()
                        }
                        .rotationEffect(revealHint ? .degrees(15) : .degrees(0))
                        .rotation3DEffect(.degrees(revealHint ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                        .scaleEffect(revealHint ? 5 : 1)
                        .opacity(revealHint ? 0 : 1)
                        .offset(x: revealHint ? UIScreen.main.bounds.width/2 : 0)
                        .allowsHitTesting(revealHint ? false : true)
                        .overlay(
                            Text(game.currentQuestion?.hint ?? "You hinting something boy?")
                                .opacity(revealHint ? 1 : 0)
                                .padding(.leading)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                        )
                        .scaleEffect(revealHint ? 1.33 : 1)
                        .allowsHitTesting(tappedCorrectAnswer ? false : true)
                    
                    Spacer()
                    
                    Rectangle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.cyan)
                        .cornerRadius(20)
                        .rotationEffect(bookWiggle ? .degrees(13) : .degrees(17))
                        .padding()
                        .padding(.trailing, 20)
                        .overlay(
                            Image(systemName: "book.closed")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                                .foregroundColor(.black)
                                .rotationEffect(bookWiggle ? .degrees(13) : .degrees(17))
                                .padding()
                                .padding(.trailing, 20)
                        )
                        .offset(x: bookSlide ? 0 : UIScreen.main.bounds.width/2)
                        .onAppear {
                            withAnimation(.easeOut(duration: 1.5).delay(5)) {
                                bookSlide.toggle()
                            }
                            
                            bookWiggle.toggle()
                        }
                        .animation(.easeInOut(duration: 0.1).repeatCount(9).delay(7).repeatForever(), value: bookWiggle)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 1)) {
                                revealBook.toggle()
                            }
                            
                            playFlipSound()
                        }
                        .rotationEffect(revealBook ? .degrees(-15) : .degrees(0))
                        .rotation3DEffect(.degrees(revealBook ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                        .scaleEffect(revealBook ? 5 : 1)
                        .opacity(revealBook ? 0 : 1)
                        .offset(x: revealBook ? -UIScreen.main.bounds.width/2 : 0)
                        .allowsHitTesting(revealBook ? false : true)
                        .overlay(
                            Image("hp\(game.currentQuestion?.book ?? 1)")
                                .resizable()
                                .scaledToFit()
                                .opacity(revealBook ? 1 : 0)
                        )
                        .scaleEffect(revealBook ? 1.33 : 1)
                        .allowsHitTesting(tappedCorrectAnswer ? false : true)
                }
                .padding(.bottom)
                .opacity(tappedCorrectAnswer ? 0.1 : 1)
                
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    Text(answers[0])
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .frame(width: UIScreen.main.bounds.width/2.15, height: 80)
                        .background(.green.opacity(0.5))
                        .cornerRadius(25)
                        .offset(x: answer1Slide ? 0 : -UIScreen.main.bounds.width/2)
                        .onAppear {
                            withAnimation(.easeOut(duration: 0.7).delay(2.7)) {
                                answer1Slide.toggle()
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 1)) {
                                tappedCorrectAnswer.toggle()
                            }
                            game.correct()
                            playMagicSound()
                        }
                        .scaleEffect(tappedCorrectAnswer ? 2 : 1)
                        .offset(x: tappedCorrectAnswer ? UIScreen.main.bounds.width/4 : 0, y:tappedCorrectAnswer ? -UIScreen.main.bounds.height/4 : 0)
                        .allowsHitTesting(tappedCorrectAnswer ? false : true)
                    
                    Text(answers[1])
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .frame(width: UIScreen.main.bounds.width/2.15, height: 80)
                        .background(tappedWrongAnswer ? .red.opacity(0.5) : .green.opacity(0.5))
                        .cornerRadius(25)
                        .offset(x: answer2Slide ? 0 : UIScreen.main.bounds.width/2)
                        .onAppear {
                            withAnimation(.easeOut(duration: 0.7).delay(3.3)) {
                                answer2Slide.toggle()
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 1)) {
                                tappedWrongAnswer.toggle()
                            }
                            
                            playWrongSound()
                            giveWrongFeedback()
                        }
                        .scaleEffect(tappedWrongAnswer ? 0.8 : 1)
                        .opacity(tappedCorrectAnswer ? 0.1 : 1)
                        .allowsHitTesting(tappedCorrectAnswer ? false : true)
                    
                    Text(answers[2])
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .frame(width: UIScreen.main.bounds.width/2.15, height: 80)
                        .background(.green.opacity(0.5))
                        .cornerRadius(25)
                        .offset(y: answer3Slide ? 0 : UIScreen.main.bounds.height/2)
                        .onAppear {
                            withAnimation(.easeOut(duration: 0.7).delay(3.8)) {
                                answer3Slide.toggle()
                            }
                        }
                        .opacity(tappedCorrectAnswer ? 0.1 : 1)
                        .allowsHitTesting(tappedCorrectAnswer ? false : true)
                    
                    Text(answers[3])
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .frame(width: UIScreen.main.bounds.width/2.15, height: 80)
                        .background(.green.opacity(0.5))
                        .cornerRadius(25)
                        .offset(y: answer4Slide ? 0 : UIScreen.main.bounds.height/2)
                        .onAppear {
                            withAnimation(.easeOut(duration: 0.7).delay(4.4)) {
                                answer4Slide.toggle()
                            }
                        }
                        .opacity(tappedCorrectAnswer ? 0.1 : 1)
                        .allowsHitTesting(tappedCorrectAnswer ? false : true)
                }
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .foregroundColor(.white)
            
            VStack {
                Spacer()
                
                Text("\(game.currentQuestion?.potentialScore ?? 5)")
                    .font(.largeTitle)
                    .offset(y:tappedCorrectAnswer ? 0 : -UIScreen.main.bounds.height/4)
                    .animation(.easeInOut(duration: 1).delay(3), value: tappedCorrectAnswer)
                    .offset(x: scoreGoToScore ? UIScreen.main.bounds.width/2.3 : 0, y:scoreGoToScore ? -UIScreen.main.bounds.height/13 : 0)
                    .opacity(scoreGoToScore ? 0 : 1)
                    .onChange(of: tappedCorrectAnswer) { _ in
                        withAnimation(.easeInOut(duration: 1).delay(4)) {
                            scoreGoToScore.toggle()
                        }
                    }
                
                Text("Brilliant!")
                    .font(.custom("PartyLetPlain", size: 100))
                    .scaleEffect(tappedCorrectAnswer ? 1 : 5)
                    .offset(y: tappedCorrectAnswer ? 0 : -UIScreen.main.bounds.height/2)
                    .animation(.easeInOut(duration: 1).delay(1), value: tappedCorrectAnswer)
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                Button("Next Level>") {
                    showNextLevel.toggle()
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue.opacity(0.5))
                .font(.largeTitle)
                .offset(y: tappedCorrectAnswer ? 0 : UIScreen.main.bounds.height/3)
                .onAppear {
                    scaleButton.toggle()
                }
                .scaleEffect(scaleButton ? 1.2 : 1)
                .animation(.easeInOut(duration: 1.3).repeatForever(autoreverses: true), value: scaleButton)
                .animation(.easeInOut(duration: 4).delay(3), value: tappedCorrectAnswer)
                .fullScreenCover(isPresented: $showNextLevel) {
                    Gameplay()
                        .environmentObject(game)
                }
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .foregroundColor(.white)
            .opacity(tappedCorrectAnswer ? 1 : 0)
        }
        .onAppear {
            answers = game.nextQuestion()
        }
    }
    
    private func playFlipSound() {
        let revealSound = Bundle.main.path(forResource: "page-flip", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: revealSound!))
        audioPlayer.play()
    }
    
    private func playMagicSound() {
        let magicSound = Bundle.main.path(forResource: "magic-wand", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: magicSound!))
        audioPlayer.play()
    }
    
    private func playWrongSound() {
        let wrongSound = Bundle.main.path(forResource: "negative-beeps", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: wrongSound!))
        audioPlayer.play()
    }
    
    private func giveWrongFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}

struct Gameplay_Previews: PreviewProvider {
    static var previews: some View {
        Gameplay()
            .environmentObject(Game())
    }
}
