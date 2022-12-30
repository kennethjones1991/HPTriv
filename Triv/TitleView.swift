//
//  TitleView.swift
//  Triv
//
//  Created by Kenneth Jones on 11/27/22.
//

import SwiftUI
import AVKit

struct TitleView: View {
    @EnvironmentObject private var game: Game
    @State var audioPlayer: AVAudioPlayer!
    @State var titleSlideDown = false
    @State var buttonSlideUp = false
    @State var sButtonSlideIn = false
    @State var iButtonSlideIn = false
    @State var scaleButton = false
    @State var bImageMove = false
    @State var showScores = false
    @State var showInstructions = false
    @State var showSettings = false
    
    var body: some View {
        ZStack {
            Image("hogwarts")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 3, height: UIScreen.main.bounds.height)
                .offset(x: bImageMove ? UIScreen.main.bounds.width/1.1 : -UIScreen.main.bounds.width/1.1)
                .onAppear {
                    withAnimation(.linear(duration: 60).repeatForever(autoreverses: true)) {
                        bImageMove.toggle()
                    }
                }
            
            VStack {
                VStack {
                    Image(systemName: "bolt.fill")
                        .imageScale(.large)
                        .font(.largeTitle)
                    
                    Text("HP")
                        .font(.custom("PartyLetPlain", size: 70))
                        .padding(.bottom, -50)
                    
                    Text("Trivia")
                        .font(.custom("PartyLetPlain", size: 60))
                }
                .padding(.top, 30)
                .offset(y: titleSlideDown ? 0 : -UIScreen.main.bounds.height/3)
                .onAppear {
                    withAnimation(.easeOut(duration: 0.7).delay(2)) {
                        titleSlideDown.toggle()
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Recent Scores")
                        .font(.title2)
                    
                    Text("\(game.recentScores[0])")
                    Text("\(game.recentScores[1])")
                    Text("\(game.recentScores[2])")
                }
                .font(.title3)
                .padding([.leading, .trailing])
                .foregroundColor(.white)
                .background(Color.black.opacity(0.7))
                .cornerRadius(15)
                .opacity(showScores ? 1 : 0)
                .onAppear {
                    withAnimation(.linear(duration: 1).delay(5)) {
                        showScores.toggle()
                    }
                }
                
                Spacer()
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button {
                        showInstructions.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                    .offset(x: iButtonSlideIn ? 0 : -UIScreen.main.bounds.width/4)
                    .onAppear {
                        withAnimation(.easeOut(duration: 0.7).delay(2.7)) {
                            iButtonSlideIn.toggle()
                        }
                    }
                    .sheet(isPresented: $showInstructions) {
                        Instructions()
                    }
                    
                    Spacer()
                    
                    Button("Play") {
                        game.startGame()
                    }
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 7)
                    .padding([.leading, .trailing], 50)
                    .background(.brown)
                    .cornerRadius(7)
                    .shadow(radius: 5)
                    .offset(y: buttonSlideUp ? 0 : UIScreen.main.bounds.height/3)
                    .onAppear {
                        withAnimation(.easeOut(duration: 0.7).delay(2)) {
                            buttonSlideUp.toggle()
                        }
                        
                        scaleButton.toggle()
                    }
                    .scaleEffect(scaleButton ? 1.2 : 1)
                    .animation(.easeInOut(duration: 1.3).repeatForever(autoreverses: true), value: scaleButton)
                    
                    Spacer()
                    
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                    .offset(x: sButtonSlideIn ? 0 : UIScreen.main.bounds.width/4)
                    .onAppear {
                        withAnimation(.easeOut(duration: 0.7).delay(2.7)) {
                            sButtonSlideIn.toggle()
                        }
                    }
                    .sheet(isPresented: $showSettings) {
                        Settings()
                    }
                    
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width)
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            audioPlayer.numberOfLoops = -1
//            audioPlayer.play()
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
            .environmentObject(Game())
    }
}
