//
//   register2.swift
//  GilCat
//
//  Created by 김연호 on 2022/06/08.
//

import SwiftUI

struct RegisterCode: View {
    @EnvironmentObject var catInfo: GilCatInfoList
    @FocusState var focusedCode: Int?
    @Binding var buildNavigationStack: Bool
    @State var isLinkActive = false
    @State var isAlertActice = false
    @State var codeInput = ["", "", "", "", "", ""]
    
    init(_ buildNavigationStack: Binding<Bool>) {
        UITextView.appearance().backgroundColor = .clear
        self._buildNavigationStack = buildNavigationStack
    }
    
    var body: some View {
        VStack {
            // 설명
            CustomSubTitle(text: "※ 다른 사람과 공유할 시, 개인 메모를 제외한 이전 기록이 모두 공유됩니다. ")
                .padding()
            // 제목
            HStack {
                GilCatTitle(titleText: "공유 코드").padding([.top, .leading])
                Spacer()
            }
            // 코드 입력 칸
            HStack {
                getCodeInputView(index: 0)
                getCodeInputView(index: 1)
                getCodeInputView(index: 2)
                Spacer()
                getCodeInputView(index: 3)
                getCodeInputView(index: 4)
                getCodeInputView(index: 5)
            }
            .padding()
            Spacer()
            // 메인 버튼
            NavigationLink(destination: RegisterName($buildNavigationStack), isActive: $isLinkActive) {
                HStack {
                    Button {
                        isLinkActive = true
                    } label: {
                        GilCatMainButton(text: "건너뛰기", foreground: .white, background: .pickerColor)
                    }
                    Button {
                        // Todo: 코드에 따라 서버에서 다른 고양이 룸 정보 받아오기
                        // 코드가 다 입력이 안됐다면, 팝업 창 보여주기
                        for code in codeInput where code.isEmpty {
                            isAlertActice = true
                        }
                        if !isAlertActice {
                            isLinkActive = true
                        }
                    } label: {
                        GilCatMainButton(text: "다음", foreground: .white, background: .buttonColor)
                    }
                }
                .padding()
            }
            .isDetailLink(false)
        }
        .navigationBarTitle("코드", displayMode: .inline)
        .background(Color.backgroundColor)
        .alert("코드를 모두 입력하거나 건너뛰기를 눌러주세요", isPresented: $isAlertActice) {
            Button("확인") {}
        }
        .onAppear {
            // 화면이 나타나고 0.5초 뒤에 자동으로 공유코드 첫번째 입력칸에 포커스 되도록 하기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    focusedCode = 0
            }
        }
    }
    
    // 코드 입력 칸 반환하기
    func getCodeInputView(index: Int) -> some View {
        return TextEditor(text: $codeInput[index])
            .frame(width: 50, height: 65)
            .background(Color.pickerColor)
            .cornerRadius(20)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.white)
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

struct RegisterCode_Previews: PreviewProvider {
    static var previews: some View {
        RegisterCode(.constant(false))
    }
}
