//
//  ChallengeCard.swift
//  Git-Challenges
//
//  Created by 권은빈 on 2022/01/15.
//

import SwiftUI

struct ChallengeCard: View {
    // Check if the app has initial value
    @State private var hasInitialValue: Bool = false
    
    // Challenge Title and Count
    @State private var challengeTitle: String = "1일 1깃 한다..."
    @State private var challengeGoalCount: String = "100"
    
    // Calculated Count and Percentage of Progress Done
    @State private var countDone: CGFloat = 80
    @State private var percentDone: CGFloat = 0.8
    
    // Main View's size
    let size: CGSize
    
    init(size: CGSize) {
        self.size = size
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Challenge")
                .font(.system(size: 18))
                .bold()
                .frame(width: size.width * 0.8, alignment: .leading)
            VStack {
                if hasInitialValue {
                    Spacer()
                    fields
                    Spacer()
                    progress
                    Spacer()
                }
                else {
                    cover
                }
            }
            .modifier(CardModifier(size: size))
            .onTapGesture {
                if !hasInitialValue {
                    hasInitialValue = true
                }
            }
        }
    }
    
    private var cover: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.white)
                .frame(width: size.width * 0.9, height: size.height * 0.2)
                .cornerRadius(20)
            Text("😱 목표가 없어요")
                .font(.system(size: 18))
                .bold()
                .foregroundColor(Color.init(hex: ColorPalette.Pink.pinkLevelOne))
        }
    }
    
    // TODO: Save title and count value when submitted
    // TODO: Replace TextField placeholder to AttributedString
    // TODO: Set Constraints to the textfield input
    // e.g. challengeTitle.count <= 20, challengeGoalCount <= 365
    
    private var fields: some View {
        HStack {
            // Text Field
            TextField("Title", text: $challengeTitle, onCommit: {
            })
                .padding(.leading, 30)
            
            Spacer()
            
            // Number Field
            HStack(spacing: 0) {
                Text("\(Int(countDone))")
                Text("/")
                TextField("365", text: $challengeGoalCount, onCommit: {
                })
                    .keyboardType(.numberPad)
                    .frame(width: 40, height: 30)
            }
            .padding(.trailing, 20)
        }
    }
    
    private var progress: some View {
        
        // progress field's full width
        let fullWidth: CGFloat = size.width
        
        // TODO: Modify Size with Design
        // progress bar's width and height
        let progressBarWidth: CGFloat = size.width * 0.75
        let progressBarHeight: CGFloat = 10.0
        
        // default padding of indicator
        let defaultPadding: CGFloat = fullWidth * 0.09
        
        return VStack(alignment: .center, spacing: 0) {
            // Indicator
            HStack(spacing: 0) {
                Text(Emoji.Pink.progressIndicatior)
                    .font(.system(size: 15))
                    .padding(.bottom, 5)
                    .padding(.leading, defaultPadding + progressBarWidth * percentDone)
                Spacer()
            }
            
            // Progress Bar
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: progressBarWidth, height: progressBarHeight, alignment: .leading)
                    .foregroundColor(Color(hex: ColorPalette.defaultGray))
                Capsule()
                    .frame(width: progressBarWidth * percentDone , height: progressBarHeight, alignment: .leading)
                    .foregroundColor(Color(hex: ColorPalette.Pink.progressDone))
            }
        }
        .frame(width: fullWidth)
    }
}

// Color Extension to use hex color
extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

//struct ChallengeCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeCard()
//    }
//}
