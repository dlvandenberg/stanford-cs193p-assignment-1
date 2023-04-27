//
//  ContentView.swift
//  Memorize
//
//  Created by Dennis van den Berg on 27/04/2023.
//

import SwiftUI

struct ContentView: View {
    let transportTheme = ["🚓", "🚜", "🚂", "🚗", "🚀", "🏎️", "🚚", "🛵", "🚑", "🚒", "🛴", "🏍️", "🛺", "🚡", "🛶", "🛥️", "🚁", "🛸", "🚅", "🦼", "⛵️"]
    let foodTheme = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑"]
    let animalTheme = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🐣", "🪿", "🦆", "🦅"]
    
    @State var activeTheme: [String]
    @State var emojiCount = 8
    
    init() {
        self.activeTheme = self.transportTheme
    }
    
    var body: some View {
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(activeTheme[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            
            HStack {
                ThemeButton(systemName: "carrot", name: "Food", emojis: foodTheme) {
                    activeTheme = $0
                    emojiCount = $1
                }
                Spacer()
                ThemeButton(systemName: "car", name: "Transport", emojis: transportTheme) {
                    activeTheme = $0
                    emojiCount = $1
                }
                Spacer()
                ThemeButton(systemName: "bolt.circle", name: "Animals", emojis: animalTheme) {
                    activeTheme = $0
                    emojiCount = $1
                }
            }
            .padding(.horizontal)
            
        }
        .padding(.horizontal)
    }
}

struct ThemeButton: View {
    var systemName: String
    var name: String
    var emojis: [String]
    var updateTheme: ([String], Int) -> Void
    
    var body: some View {
        Button {
            let shuffledEmojis = emojis.shuffled()
            let count = Int.random(in: 8..<shuffledEmojis.count)
            
            updateTheme(shuffledEmojis, count)
        } label: {
            VStack {
                Image(systemName: systemName)
                    .font(.title)
                Text(name)
            }
            .font(.title3)
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                
                shape.strokeBorder(lineWidth: 3)
                
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
