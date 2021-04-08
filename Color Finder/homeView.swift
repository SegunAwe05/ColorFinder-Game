//
//  homeView.swift
//  Color Finder
//
//  Created by Segun Awe on 12/22/20.
//

import SwiftUI

struct homeView: View {
    var offWhite = Color("offWhite")
   
    @State var mainColor = Color.blue
    @State var playNow = false
    @State  var timeRemaining = 2
    @Binding var highScore: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
       @State var ani: Animation = Animation.easeInOut(duration: 0.3)
    @State var game10 = false
    @State var optionVisible = false
    func changeColor() {
        
        let R = Double.random(in: 0...255)
        let G = Double.random(in: 0...255)
        let B = Double.random(in: 0...255)
        
        let randColor = Color(red: R/255, green: G/255, blue: B/255)
        
        self.mainColor = randColor
        
    }
    
    func soloScreen() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: soloView())
            window.makeKeyAndVisible()
        }
    }
    
    func playScreen(gameScore: Int) {
      
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: duoView(winScore: gameScore, optionVisible: $optionVisible, game10: $game10))
            window.makeKeyAndVisible()
        }
    }
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(offWhite)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer().frame(height: 35)
                Text("Color Finder!")
                    .font(.system(size: 55))
                    .fontWeight(.bold)
                    .foregroundColor(mainColor)
                    .modifier(textShadows())
                Spacer().frame(height: 60)
                
                HStack {
                    Button( action:  {
                        soloScreen()
                    }) {
                        homecard(color: mainColor, title: "Solo", image: "person", score: "High Score: \(highScore)" )
                    }
             
                    Button(action: {
                        playScreen(gameScore: 5)
                    }) {
                        homecard(color: mainColor, title: "Two Player", image: "person.2", score: "Game to 5")
                    }
                   
                }
                Spacer().frame(height: 30)
                HStack {
                    Button(action: {
                        playScreen(gameScore: 10)
                        optionVisible.toggle()
                        game10.toggle()
                    }) {
                        homecard(color: mainColor, title: "Two Player", image: "person.2", score: "Game to 10")
                    }
                    Button(action: {
                        playScreen(gameScore: 15)
                        optionVisible.toggle()
                    }) {
                        homecard(color: mainColor, title: "Two Player", image: "person.2", score: "Game to 15")
                    }
                }
                Spacer()
                
               
            }
     
            
        }.onAppear{self.changeColor()}
            .onReceive(timer) { time in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
                
                if self.timeRemaining == 0 {
                    self.changeColor()
                    self.timeRemaining = 2
                }
        }
    }
    
    struct homeView_Previews: PreviewProvider {
        static var previews: some View {
            homeView(highScore: .constant(55))
        }
    }
}




