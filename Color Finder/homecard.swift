//
//  homecard.swift
//  Color Finder
//
//  Created by Segun Awe on 12/22/20.
//

import SwiftUI

struct homecard: View {
    var color = Color(.blue)
    var title  = ""
    var image = ""
    var score = ""
    @State var ani: Animation = Animation.easeInOut(duration: 0.3)
    var body: some View {
        ZStack {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(color).opacity(0.8)
            .frame(width: 200, height: 250)
            .modifier(btnShadows())
        .animation(ani)
            VStack {
                Spacer().frame(height: 20)
                Text(score)
                    .foregroundColor(.white)
                    .font(.system(size: 26))
                    .modifier(textShadows())
                Spacer().frame(height: 20)
            Image(systemName: image)
                .foregroundColor(.white)
               .font(.system(size: 85))
                .modifier(textShadows())
            Spacer().frame(height: 20)
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 30))
                .modifier(textShadows())
            }
        }
    }
}

struct CFBtn: View {
    var title = ""
    var pad = CGFloat(50)
    var color = Color(.blue)
    
    var body: some View {
        Text(title)
            .font(.system(size: 25))
            .foregroundColor(Color.black)
            .padding(3)
            .padding([.leading, .trailing], pad)
            .background(color).opacity(0.8)
            .cornerRadius(8)
            .modifier(btnShadows())
    }
}

struct textShadows: ViewModifier {
    func body(content: Content) -> some View {
        content
        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 10, y: 10)
        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

struct btnShadows: ViewModifier {
    func body(content: Content) -> some View {
        content
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 10)
        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)

    }
}


struct homecard_Previews: PreviewProvider {
    static var previews: some View {
        homecard()
    }
}
