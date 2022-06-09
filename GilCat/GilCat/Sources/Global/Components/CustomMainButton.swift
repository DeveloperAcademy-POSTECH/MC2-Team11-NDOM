//
//  CustomMainButton.swift
//  GilCat
//
//  Created by 김동락 on 2022/06/09.
//

import SwiftUI

struct CustomMainButton: View {
    @State var text: String
    @State var foreground: Color
    @State var background: Color
    
    var body: some View {
        Text(text)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(foreground)
                .background(background)
                .font(.system(size: 20, weight: Font.Weight.heavy))
                .cornerRadius(20)
    }
}

struct CustomMainButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomMainButton(text: "다음", foreground: Color.white, background: Color.black)
    }
}
