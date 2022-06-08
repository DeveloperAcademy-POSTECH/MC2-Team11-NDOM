//
//  Register2.swift
//  GilCat
//
//  Created by 김동락 on 2022/06/08.
//

import SwiftUI

struct Register2: View {
    @FocusState private var focusedCode: Int?
    @State private var codeInput = ["", "", "", "", "", ""]
    
    init() {
            UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ViewComponents.getSubTitleView(text: "※ 다른 사람과 공유할 시, 개인 메모를 제외한 이전 기록이 모두 공유됩니다. ")
            Spacer()
            ViewComponents.getTitleView(text: "공유 코드")
            HStack {
                getCodeInputView(index: 0)
                getCodeInputView(index: 1)
                getCodeInputView(index: 2)
                Spacer()
                getCodeInputView(index: 3)
                getCodeInputView(index: 4)
                getCodeInputView(index: 5)
            }

            Spacer()
            HStack {
                Button {
                
                } label: {
                    ViewComponents.getMainButtonView(text: "건너뛰기", foreground: Color(hex: "FFFFFF"), background: Color(hex: "252E37"))
                }
                Button {
                
                } label: {
                    ViewComponents.getMainButtonView(text: "시작하기", foreground: Color(hex: "FFFFFF"), background: Color(hex: "FFAB73"))
                }
            }
        }
        .padding()
        .background(Color(hex: "39495B"))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    focusedCode = 0
               }
        }
    }
    
    func getCodeInputView(index: Int) -> some View {
        return TextEditor(text: $codeInput[index])
            .frame(width: 50, height: 65)
            .background(Color(hex: "252E37"))
            .cornerRadius(20)
            .multilineTextAlignment(.center)
            .foregroundColor(Color(hex: "FFFFFF"))
            .font(.system(size: 40, weight: Font.Weight.heavy))
            .keyboardType(.numberPad)
            .focused($focusedCode, equals: index)
            .onChange(of: codeInput[index]) { _ in
                if codeInput[index].count > 1 {
                    codeInput[index] = String(codeInput[index].suffix(1))
                }
                if focusedCode != nil {
                    focusedCode! += 1
                    if focusedCode == 5 {
                        focusedCode = nil
                    }
                }
            }
    }
}

struct Register2_Previews: PreviewProvider {
    static var previews: some View {
        Register2()
    }
}
