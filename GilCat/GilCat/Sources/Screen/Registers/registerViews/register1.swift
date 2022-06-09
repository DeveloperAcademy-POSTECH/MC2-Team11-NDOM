//
//  register1.swift
//  GilCat
//
//  Created by 김연호 on 2022/06/07.
//

import SwiftUI

struct Register1: View {
    var body: some View {
        VStack(alignment: .leading) {
            CustomTitle(titleText: "나만의 길고양이 기록장을 만들어보세요!")
            VStack {
                getProcessContentView(order: 1, text: "공유 코드가 있다면 알려주세요!")
                getProcessContentView(order: 2, text: "길냥이 프로필을 적아주세요!")
                getProcessContentView(order: 3, text: "나만의 길냥이를 만들어주세요!")
            }
            Spacer()
            Button {
            
            } label: {
                CustomMainButton(text: "시작하기", foreground: Color.white, background: Color.lightOrange)
            }
        }
        .padding()
        .background(Color.backgroundColor)
    }
    
    func getProcessContentView(order: Int, text: String) -> some View {
        return HStack {
            Text(String(order))
                .frame(width: 30, height: 30)
                .foregroundColor(Color.black)
                .background(Color.lightOrange)
                .cornerRadius(10)
            Text(text)
                .foregroundColor(Color.white)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.darkBlue)
        .cornerRadius(20)
    }
}

struct Register1_Previews: PreviewProvider {
    static var previews: some View {
        Register1()
    }
}
