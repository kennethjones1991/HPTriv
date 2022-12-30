//
//  Settings.swift
//  Triv
//
//  Created by Kenneth Jones on 9/24/22.
//

import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image("parchment")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .background(.brown)
            
            ScrollView {
                Text("Which books would you like to see questions from?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                LazyVGrid(columns: [GridItem(), GridItem()]) {
//                    ForEach(0..<7) { i in
//
//                    }
                    
                    // Selected book
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                        Image("hp1")
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 7)
                        
                        Image(systemName: "checkmark.circle.fill")
                            .font(.largeTitle)
                            .imageScale(.large)
                            .foregroundColor(.green)
                            .shadow(radius: 1)
                            .padding(3)
                    }
                    
                    // Unselected book
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                        Image("hp2")
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 7)
                            .overlay(Rectangle().opacity(0.33))
                        
                        Image(systemName: "circle")
                            .font(.largeTitle)
                            .imageScale(.large)
                            .foregroundColor(.green.opacity(0.5))
                            .shadow(radius: 1)
                            .padding(3)
                    }
                    
                    // Locked book
                    ZStack {
                        Image("hp3")
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 7)
                            .overlay(Rectangle().opacity(0.75))
                        
                        Image(systemName: "lock.fill")
                            .font(.largeTitle)
                            .imageScale(.large)
                            .shadow(color: .white.opacity(0.75), radius: 3)
                    }
                }
                .padding()
                
                Button("Done") {
                    dismiss()
                }
                .font(.largeTitle)
                .padding(10)
                .foregroundColor(.white)
                .background(.brown)
                .cornerRadius(15)
            }
            .foregroundColor(.black)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
