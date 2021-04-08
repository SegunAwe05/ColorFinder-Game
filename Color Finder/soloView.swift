//
//  soloView.swift
//  Color Finder
//
//  Created by Segun Awe on 12/22/20.
//

import SwiftUI

import SwiftUI

struct soloView: View {
    var offWhite = Color("offWhite")
    @State var mainColor = Color("offWhite")
    @State var borderColor = Color("offwhite")
    @State var randCard = 4
    @State var soloScore = 0
    @State var loserScreen = false
    @State  var timeRemaining = 5
    @State var highScore = UserDefaults.standard.integer(forKey: "High Score")
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var newHigh = false
    func changeColor() {
        
        let R = Double.random(in: 0...255)
        let G = Double.random(in: 0...255)
        let B = Double.random(in: 0...255)
        
        let randColor = Color(red: R/255, green: G/255, blue: B/255)
        self.mainColor = randColor
        
        randCard = Int.random(in: 1...4)
        print("correct card is card \(randCard)")
        
        if soloScore > highScore {
            UserDefaults.standard.setValue(soloScore, forKey: "High Score")
            newHigh.toggle()
        }
    }
    
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(offWhite)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Color Finder!")
                    .font(.system(size: 55))
                    .fontWeight(.bold)
                    .foregroundColor(mainColor)
                    .modifier(textShadows())
                Spacer()
                
                HStack {
                    Text("Time: \(timeRemaining)")
                        .font(.system(size: 33))
                        .foregroundColor(.black)
                    Spacer().frame(width: 50)
                    Text("High Score: \(highScore)")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                }
                
                HStack {
                    if randCard == 1 {
                        ColorCardView(mainColor: $mainColor, borderColor: $borderColor)
                            .onTapGesture {
                                changeColor()
                                soloScore += 1
                                timeRemaining = 5
                            }
                    } else {
                        cardView(mainColor: $mainColor)
                            .onTapGesture {
                                loserScreen.toggle()
                            }
                    }
                    
                    if randCard == 2 {
                        ColorCardView(mainColor: $mainColor, borderColor: $borderColor)
                            .onTapGesture {
                                changeColor()
                                soloScore += 1
                                timeRemaining = 5
                            }
                    } else {
                        cardView(mainColor: $mainColor)
                            .onTapGesture {
                                loserScreen.toggle()
                            }
                    }
                }
                
                HStack {
                    if randCard == 3 {
                        ColorCardView(mainColor: $mainColor, borderColor: $borderColor)
                            .onTapGesture {
                                changeColor()
                                soloScore += 1
                                timeRemaining = 5
                            }
                    } else {
                        cardView(mainColor: $mainColor)
                            .onTapGesture {
                                loserScreen.toggle()
                            }
                    }
                    
                    if randCard == 4 {
                        ColorCardView(mainColor: $mainColor, borderColor: $borderColor)
                            .onTapGesture {
                                changeColor()
                                soloScore += 1
                                timeRemaining = 5
                            }
                    } else {
                        cardView(mainColor: $mainColor)
                            .onTapGesture {
                                loserScreen.toggle()
                            }
                    }
                }
                
                Group {
                    Spacer().frame(height: 50)
                    
                    Text("Score")
                        .font(.system(size: 35))
                        .frame(width: 200, height: 25)
                        .foregroundColor(Color.black)
                        .padding(10)
                        .background(mainColor)
                        .cornerRadius(18)
                        .modifier(btnShadows())
                    
                    Spacer().frame(height: 25)
                    
                    Text("\(soloScore)")
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                        .bold()
                    
                }
                
                Spacer()
            }
            
            if loserScreen {
                Losercard(loserScreen: $loserScreen, soloScore: $soloScore, mainColor: $mainColor, randCard: $randCard, newHigh: $newHigh, highScore: $highScore)
                
            }
            
            if timeRemaining == 0 {
                Losercard(loserScreen: $loserScreen, soloScore: $soloScore, mainColor: $mainColor, randCard: $randCard, newHigh: $newHigh, highScore: $highScore)
            }
            
        }.onAppear{
            changeColor()
            
        }
        .onReceive(timer) { time in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            
        }
        
    }
}

struct soloView_Previews: PreviewProvider {
    static var previews: some View {
        soloView()
    }
}


struct Losercard: View {
    @Binding var loserScreen : Bool
    @State var offWhite = Color("offWhite")
    @Binding var soloScore : Int
    @Binding var mainColor : Color
    @Binding var randCard : Int
    @Binding var newHigh : Bool
    @Binding var highScore : Int
    
    func homeScreen() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: homeView(highScore: .constant(UserDefaults.standard.integer(forKey: "High Score"))))
            window.makeKeyAndVisible()
        }
    }
    
    func soloScreen() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: soloView())
            window.makeKeyAndVisible()
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black.opacity(0.4))
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                if soloScore > highScore {
                    Text("New High Score! \(soloScore)")
                        .font(.system(size: 30))
                        .frame(width: 320, height: 55)
                        .foregroundColor(.black)
                        .background(mainColor)
                        .cornerRadius(18)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 10)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(offWhite)
                        .frame(width:350, height: 250)
                        .modifier(btnShadows())
                    VStack {
                        Text("You lost, Score: \(soloScore)")
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                            .fontWeight(.medium)
                            .modifier(textShadows())
                        Spacer().frame(height: 25)
                        
                        Button(action: {
                            soloScreen()
                        }) {
                            CFBtn(title: "Play Again", color: mainColor)
                        }
                        Spacer().frame(height: 10)
                        
                        Button(action: {
                            homeScreen()
                        }) {
                            CFBtn(title: "Go Home", pad: 55, color: mainColor)
                        }
                    }
                }
                Spacer().frame(height: 20)
                Text("Correct Card was \(randCard)")
                    .font(.system(size: 30))
                    .frame(width: 320, height: 55)
                    .foregroundColor(.black)
                    .background(mainColor)
                    .cornerRadius(18)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 10)
            }
        }
    }
}
