//
//  register8.swift
//  GilCat
//
//  Created by 김연호 on 2022/06/08.
//

import SwiftUI

struct Register8: View {
    let catImages = [
        "cat_gray_1",
        "cat_gray_2",
        "cat_gray_3",
        "cat_gray_4",
        "cat_gray_5",
        "cat_gray_6",
        "cat_gray_7",
        "cat_gray_8"
    ]
    
    var body: some View {
        VStack {
            CustomTitle(titleText: "캐릭터")
            Spacer()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<catImages.count/2, id: \.self) { index in
                            VStack {
                                Image(catImages[2*index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                Image(catImages[2*index+1])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            }
                        
                    }
                }
                .padding()
                .background()
            }
            Button {
                
            } label: {
                CustomMainButton(text: "다음", foreground: Color.white, background: Color.lightOrange)
            }
        }
        .padding()
        .background(Color.backgroundColor)
    }
}

struct Register8_Previews: PreviewProvider {
    static var previews: some View {
        Register8()
    }
}
