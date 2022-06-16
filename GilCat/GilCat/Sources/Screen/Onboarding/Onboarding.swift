//
//  Onboarding.swift
//  GilCat
//
//  Created by Beone on 2022/06/15.
//

import SwiftUI

struct Onboarding: View {
    @Binding var isFirstLaunching: Bool
    var body: some View {
            ZStack{
                Color.backgroundColor.ignoresSafeArea(.all)
                VStack{
                    Spacer()
                    HStack{
                        Text("나만의 길고양이를 등록하고\n매일 관리해보세요!")
                            .foregroundColor(Color.white)
                            .font(.system(size: 30, weight: .heavy))
                            .padding()
                        
                        //같이 관리하는 길고양이가 있다면, 공유코드를 통해 함께 관리해보세요!
                        //상단 도움말 버튼을 통해 궁금증을 풀어드립니다! 그럼, 관리를 시작해볼까요?
                        Spacer()
                    }
                    Spacer()
                    Image("cat_gray_3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 150)
                    Spacer()
                    Button{
                        isFirstLaunching.toggle()
                    }label: {
                        GilCatMainButton(text: "다음", foreground: .white, background: .buttonColor).padding()
                    }
                    
                }
            }
        
    }
}
