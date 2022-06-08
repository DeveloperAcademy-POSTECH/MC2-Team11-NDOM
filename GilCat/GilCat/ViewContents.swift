//
//  ViewContents.swift
//  GilCat
//
//  Created by 김동락 on 2022/06/08.
//

import SwiftUI

struct ViewComponents {
    static func getTitleView(text: String) -> some View {
        return Text(text)
            .foregroundColor(Color.white)
            .font(.system(size: 40, weight: Font.Weight.heavy))
    }
    
    static func getSubTitleView(text: String) -> some View {
        return Text(text)
            .foregroundColor(Color.white)
            .font(.system(size: 20, weight: Font.Weight.heavy))
    }
    
    static func getMainButtonView(text: String, foreground: Color, background: Color) -> some View {
        return Text(text)
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(foreground)
            .background(background)
            .font(.system(size: 20, weight: Font.Weight.heavy))
            .cornerRadius(20)
    }
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let red = Double((rgb >> 16) & 0xFF) / 255.0
    let green = Double((rgb >>  8) & 0xFF) / 255.0
    let blue = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: red, green: green, blue: blue)
  }
}
