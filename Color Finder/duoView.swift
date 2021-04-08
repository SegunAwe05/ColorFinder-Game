//
//  ContentView.swift
//  Color Finder
//
//  Created by Segun Awe on 12/22/20.
//

import SwiftUI

struct duoView: View {
  @State var offWhite = Color("offWhite")
    @State var mainColor = Color("offWhite")
    @State var borderColor = Color("offwhite")
    @State var randCard = 4
    @State var Score = 0
    @State var Score2 = 0
    @State var currentPlayer = "one"
    @State var ani: Animation = Animation.easeInOut(duration: 0.3)
    @State var Correct = false
    @State var winScore = 100
    @State  var timeRemaining = 5
    @Binding var optionVisible : Bool
    @Binding var game10 : Bool
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func changeColor() {
        
        let R = Double.random(in: 0...255)
        let G = Double.random(in: 0...255)
        let B = Double.random(in: 0...255)
        
        let randColor = Color(red: R/255, green: G/255, blue: B/255)
        
        self.mainColor = randColor
        
        randCard = Int.random(in: 1...4)
        print("correct card is card \(randCard)")
        
    }
    
   
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(offWhite)
                .edgesIgnoringSafeArea(.all)
                .animation(ani)
            
         
            
            if self.Correct {
                correctView(Correct: $Correct, timeRemaining: $timeRemaining)
                   .animation(.easeInOut(duration: 0.3))
            }
            
            VStack {
                Spacer()
                Text("Color Finder!")
                    .font(.system(size: 55))
                    .fontWeight(.bold)
                    .foregroundColor(mainColor)
                    .modifier(textShadows())
                Spacer()
                
                Text("Time: \(timeRemaining)")
                    .font(.system(size: 33))
                    .foregroundColor(.black)
                   
                
                HStack{
                    Spacer()
                    if randCard == 1 {
                      ColorCardView(mainColor: $mainColor, borderColor: $borderColor)
                        .onTapGesture {
                                self.changeColor()
                                if self.currentPlayer == "one"{
                                    self.Score = self.Score + 1
                                } else {
                                    self.Score2 = self.Score2 + 1
                                }
                                self.switchPlayer()
                        }
                        
                    } else {
                        cardView(mainColor: $mainColor)
                            .onTapGesture {
                                self.changeColor()
                                if self.currentPlayer == "one"{
                                    self.Score = self.Score - 3
                                } else {
                                    self.Score2 = self.Score2 - 3
                                }
                                self.switchPlayer()
                            }
                    }
                    
                    Spacer()
                    if randCard == 2 {
                        ColorCardView(mainColor: $mainColor, borderColor: $borderColor)
                            .onTapGesture {
                                self.changeColor()
                                if self.currentPlayer == "one"{
                                    self.Score = self.Score + 1
                                } else {
                                    self.Score2 = self.Score2 + 1
                                }
                                self.switchPlayer()
                        }
                    } else {
                        cardView(mainColor: $mainColor)
                            .onTapGesture {
                                self.changeColor()
                                if self.currentPlayer == "one"{
                                    self.Score = self.Score - 3
                                } else {
                                    self.Score2 = self.Score2 - 3
                                }
                                self.switchPlayer()
                        }
                    }
                    Spacer()
                }
                Spacer().frame(height: 30)
                
                HStack{
                    Spacer()
                    if randCard == 3 {
                        ColorCardView(mainColor: $mainColor, borderColor: $borderColor)
                            .onTapGesture {
                                self.changeColor()
                                if self.currentPlayer == "one"{
                                    self.Score = self.Score + 1
                                } else {
                                    self.Score2 = self.Score2 + 1
                                }
                                self.switchPlayer()
                        }
                    } else {
                        cardView(mainColor: $mainColor)
                            .onTapGesture {
                                self.changeColor()
                                if self.currentPlayer == "one"{
                                    self.Score = self.Score - 3
                                } else {
                                    self.Score2 = self.Score2 - 3
                                }
                                self.switchPlayer()
                        }
                    }
                    
                    Spacer()
                    if randCard == 4 {
                          ColorCardView(mainColor: $mainColor, borderColor: $borderColor)
                           
                            .onTapGesture {
                                self.changeColor()
                                if self.currentPlayer == "one"{
                                    self.Score = self.Score + 1
                                } else {
                                    self.Score2 = self.Score2 + 1
                                }
                                self.switchPlayer()
                            
                        }
                        
                    } else {
                        cardView(mainColor: $mainColor)
                            .onTapGesture {
                                self.changeColor()
                                if self.currentPlayer == "one"{
                                    self.Score = self.Score - 3
                                } else {
                                    self.Score2 = self.Score2 - 3
                                }
                                self.switchPlayer()
                        }
                    }
                    Spacer()
                }
                Spacer()
                
                HStack{
                    Spacer()
                    
                    if self.currentPlayer == "one" {
                        playerViewOne(color: mainColor, Score: Score, text: "PLAYER ONE")
                    } else {
                        playerViewOne(color: offWhite, Score: Score, text: "PLAYER ONE")
                    }
                    
                    Spacer()
                    
                    if self.currentPlayer == "two" {
                        playerViewOne(color: mainColor, Score: Score2, text: "PLAYER TWO")
                    } else {
                        playerViewOne(color: offWhite, Score: Score2, text: "PLAYER TWO")
                    }
                    
                    Spacer()
                }
                Spacer()
                
            }// end of VStack
            
            if self.Score == winScore {
                PlayerOneWin(mainColor: $mainColor, game10: $game10, optionVisible: $optionVisible, text: "Player One Wins")
            }
            
            if self.Score2 == winScore {
                PlayerOneWin(mainColor: $mainColor, game10: $game10, optionVisible: $optionVisible, text: "Player Two Wins")
            }
            
        }.onAppear{self.changeColor()}
        .onReceive(timer) { time in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            
            if self.timeRemaining == 0 {
                self.timeRemaining = 5

                if self.currentPlayer == "one" {
                    self.Score = self.Score - 2
                }
                
                if self.currentPlayer == "two" {
                    self.Score2 = self.Score2 - 2
                }
                
                if self.timeRemaining == 4 {
                    self.Correct = false
                }
                
                self.switchPlayer()
                self.changeColor()
            }
        }
    }
    func switchPlayer() {
        if self.currentPlayer == "one" {
            self.currentPlayer = "two"
            self.timeRemaining = 5
        }
        else{
            self.currentPlayer = "one"
            self.timeRemaining = 5
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        duoView(winScore: 5, optionVisible: .constant(false), game10: .constant(false))
    }
}


struct correctView: View {
    @Binding var Correct : Bool
    @State var offWhite = Color("offWhite")
    
    @Binding  var timeRemaining : Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color.green.opacity(0.5))
            .edgesIgnoringSafeArea(.all)
            .animation(.easeInOut(duration: 0.3))
            .onTapGesture {
                self.Correct.toggle()
        }
        
    }
}



struct NormalView: View {
   @State var offWhite = Color("offWhite")
    var body: some View {
        Rectangle()
            .foregroundColor(offWhite)
            .edgesIgnoringSafeArea(.all)
         
    }
}




struct cardView: View {
    @Binding var mainColor : Color
    @State var ani: Animation = Animation.easeInOut(duration: 0.3)
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(mainColor)
            .animation(ani)
            .frame(width: 200, height: 250)
            .modifier(btnShadows())
    }
}




struct ColorCardView: View {
    @Binding var mainColor: Color
    @State var ani: Animation = Animation.easeInOut(duration: 0.3)
    @Binding var borderColor: Color
     var offWhite = Color("offWhite")
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(mainColor).opacity(0.8)
            .animation(ani)
            .frame(width: 200, height: 250)
            .modifier(btnShadows())
    }
}

struct playerViewOne: View {
    var color : Color
     var Score : Int
        var text = ""
    var body: some View {
        VStack{
            Text(text)
                .font(.system(size: 25))
                .foregroundColor(Color.black)
                .padding(10)
                .background(color)
                .cornerRadius(18)
                .modifier(btnShadows())
            Spacer()
                .frame(height: 25)
            Text("\(Score)")
                .foregroundColor(.black)
                .font(.system(size: 30))
                .bold()
        }
    }
}

struct PlayerOneWin: View {
    @State var offWhite = Color("offWhite")
    @Binding var mainColor : Color
    @Binding var game10 : Bool
    @Binding var optionVisible : Bool

   var text = ""
    
    func homeScreen() {
          if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: homeView(highScore:  .constant(UserDefaults.standard.integer(forKey: "High Score"))))
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
        ZStack{
            Rectangle()
                .foregroundColor(.black).opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(offWhite)
                        .frame(width: 356, height: 200)
                        .modifier(btnShadows())
                    VStack{
                        Spacer()
                        Text(text)
                            .foregroundColor(mainColor)
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .modifier(textShadows())
                        
                        Spacer().frame(height: 30)
                        
                        if optionVisible {
                            Button(action: {
                                if game10 {
                                self.playScreen(gameScore: 10)
                                } else {
                                    self.playScreen(gameScore: 15)
                                }
                            }) {
                                CFBtn(title: "Play Again", color: mainColor)
                            }
                        } else {
                            Button(action: {
                                self.playScreen(gameScore: 5)
                                print("game to 10")
                            }) {
                                CFBtn(title: "Play Again", color: mainColor)
                            }
                        }
                        
                     

                        Spacer().frame(height: 20)
                        
                        Button(action: {
                            self.homeScreen()
                            optionVisible = false
                            game10 = false
                        }, label: {
                            CFBtn(title: "Go home", pad: 54, color: mainColor)
                        })
                        Spacer()
                    }
                }
            }
        }
    }
}

struct GreenScreen: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color.green.opacity(0.5))
            .edgesIgnoringSafeArea(.all)
         .animation(.easeInOut(duration: 1.0))
    }
}


