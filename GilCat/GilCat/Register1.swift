//
//  Register1.swift
//  GilCat
//
//  Created by 김동락 on 2022/06/08.
//

import SwiftUI

struct Register1: View {
    var body: some View {
        VStack(alignment: .leading) {
            ViewComponents.getTitleView(text: "나만의 길고양이 기록장을 만들어보세요!")
            VStack {
                getProcessContentView(order: 1, text: "공유 코드가 있다면 알려주세요!")
                getProcessContentView(order: 2, text: "길냥이 프로필을 적아주세요!")
                getProcessContentView(order: 3, text: "나만의 길냥이를 만들어주세요!")
            }
            Spacer()
            Button {
            
            } label: {
                ViewComponents.getMainButtonView(text: "시작하기", foreground: Color(hex: "FFFFFF"), background: Color(hex: "FFAB73"))
            }
        }
        .padding()
        .background(Color(hex: "39495B"))
    }
    
    func getProcessContentView(order: Int, text: String) -> some View {
        return HStack {
            Text(String(order))
                .frame(width: 30, height: 30)
                .foregroundColor(Color(hex: "000000"))
                .background(Color(hex: "FFAB73"))
                .cornerRadius(10)
            Text(text)
                .foregroundColor(Color(hex: "FFFFFF"))
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(hex: "252E37"))
        .cornerRadius(20)
    }
}

struct Register1_Previews: PreviewProvider {
    static var previews: some View {
        Register1()
    }
}
