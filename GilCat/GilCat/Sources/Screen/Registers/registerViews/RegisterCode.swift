//
//   register2.swift
//  GilCat
//
//  Created by 김연호 on 2022/06/08.
//

import SwiftUI

struct RegisterCode: View {
    @EnvironmentObject var catInfo: GilCatInfoList
    @FocusState var isFocused: Bool?
    @Binding var buildNavigationStack: Bool
    @State var isLinkActive = false
    @State var isAlertActice = false
    @State var codeInput = ""
    
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
            ZStack {
                TextField("", text: $codeInput)
                    .frame(width: 0, height: 0)
                    .focused($isFocused, equals: true)
                    .keyboardType(.numberPad)
                    .onChange(of: codeInput) { _ in
                        if codeInput.count > 6 {
                            codeInput = String(codeInput.prefix(6))
                        }
                    }
                HStack {
                    getCodeInputView(index: 0)
                    getCodeInputView(index: 1)
                    getCodeInputView(index: 2)
                    getCodeInputView(index: 3)
                    getCodeInputView(index: 4)
                    getCodeInputView(index: 5)
                }
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
                        if codeInput.count != 6 {
                            isAlertActice = true
                        } else {
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
                    isFocused = true
            }
        }
    }
    
    // 코드 입력 칸 반환하기
    func getCodeInputView(index: Int) -> some View {
        var codes = ["", "", "", "", "", ""]
        for (idx, code) in codeInput.enumerated() {
            if codeInput.count > 6 {
                break
            }
            codes[idx] = String(code)
        }
        return Text(codes[index])
            .frame(width: 50, height: 65)
            .background(Color.pickerColor)
            .cornerRadius(20)
            .foregroundColor(Color.white)
            .font(.system(size: 40, weight: Font.Weight.heavy))
    }
}

struct RegisterCode_Previews: PreviewProvider {
    static var previews: some View {
        RegisterCode(.constant(false))
    }
}
