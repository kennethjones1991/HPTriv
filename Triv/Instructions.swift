//
//  Instructions.swift
//  Triv
//
//  Created by Kenneth Jones on 9/24/22.
//

import SwiftUI

struct Instructions: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image("parchment")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .background(.brown)
            
            VStack {
                Image("appiconwithradius")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top)
                
                ScrollView {
                    Text("How To Play")
                        .font(.largeTitle)
                        .padding()
                    
                    Text("Welcome to HP Trivia! In this game you will be asked random questions from the HP books and you must select the right answer or you will lose points!😱")
                        .font(.title3)
                        .padding([.leading, .trailing, .bottom])
                    
                    Text("Each question is worth 5 points, but any time you select a wrong answer, you lose 1 point.")
                        .font(.title3)
                        .padding([.leading, .trailing, .bottom])
                    
                    Text("If you are struggling with a question, there is an option to reveal a hint or reveal the book the question is from. But, only use them if you need to, as they each minus 1 point as well.")
                        .font(.title3)
                        .padding([.leading, .trailing, .bottom])
                    
                    Text("When you select the correct answer, you will be awarded all the points left for that question and they will be added to your total score.")
                        .font(.title3)
                        .padding([.leading, .trailing])
                    
                    Text("Good Luck!")
                        .font(.title)
                }
                .foregroundColor(.black)
                
                Button("Done") {
                    dismiss()
                }
                .font(.largeTitle)
                .padding(10)
                .foregroundColor(.white)
                .background(.brown)
                .cornerRadius(15)
            }
        }
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}
