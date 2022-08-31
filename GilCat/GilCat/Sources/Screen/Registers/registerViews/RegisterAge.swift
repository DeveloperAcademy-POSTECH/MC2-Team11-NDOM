//  register5.swift
//  GilCat
//
//  Created by 김연호 on 2022/06/08.
//

import SwiftUI

struct RegisterAge: View {
    @EnvironmentObject var newCat: NewCatRegisterViewModel
    @Environment(\.presentationMode) private var presentation
    @FocusState private var isFocused: Int?
    @Binding private var isActiveForPopToRoot: Bool
    @State private var isLinkActive = false
    @State private var isShowingType = false
    @State private var isFirstClick = true
    @State private var buttonColor: Color = .gray
    // 나이랑 종 값 입력 다 할 경우 건너뛰기 버튼은 사라지고 다음만 남도록 하기 위한 변수
    @State private var isInputFinish = false
    private var catName: String = ""
    
    init(popToRoot: Binding<Bool>) {
        Theme.navigationBarColors(background: .systemFill, titleColor: .white)
        self._isActiveForPopToRoot = popToRoot
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea(.all)
            VStack {
                getTitleView("나이")
                getAgeTextField()
                if isShowingType {
                    VStack {
                        getTitleView("종")
                        getTypeTextField()
                    }.transition(.opacity)
                }
                Spacer()
                getMainButtomView()
            }
            .navigationTitle("나이 & 종")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(.stack)
            // MARK: 툴바 수정
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Image(systemName: "chevron.backward")
                        .frame(width: 50, height: 40, alignment: .leading)
                        .contentShape(Rectangle())
                        .foregroundColor(.white)
                        .onTapGesture {
                            self.presentation.wrappedValue.dismiss()
                        }
                }
            }
            .onAppear {
                // 화면이 나타나고 0.6초 뒤에 자동으로 입력칸에 포커스 되도록 하기
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    isFocused = 1
                }
            }
        }
    }
    // 제목 뷰 반환하기
    @ViewBuilder
    private func getTitleView(_ text: String) -> some View {
        HStack {
            GilCatTitle(titleText: text).padding([.top, .leading])
            Spacer()
        }
    }
    // 나이 입력 필드 뷰 반환하기
    @ViewBuilder
    private func getAgeTextField() -> some View {
        GilCatTextField(inputText: $newCat.age,
                        placeHolder: "\(newCat.name)은(는) 몇 살인가요?", textLimit: 2)
               .padding([.leading, .bottom])
               .focused($isFocused, equals: 1)
               .keyboardType(.numberPad)
               .onChange(of: newCat.age) { _ in
                   withAnimation {
                       buttonColor = newCat.age.isEmpty ? Color.gray : Color.buttonColor
                   }
               }
    }
    // 종 입력 필드 뷰 반환하기
    @ViewBuilder
    private func getTypeTextField() -> some View {
        GilCatTextField(inputText: $newCat.type, placeHolder: "\(newCat.name)의 종을 아신다면 알려주세요. ", textLimit: 8)
            .padding([.leading, .bottom])
            .onChange(of: newCat.type) { _ in
                withAnimation {
                    buttonColor = newCat.type.isEmpty ? Color.gray : Color.buttonColor
                    isInputFinish = newCat.type.isEmpty ? false : true
                }
            }
            .focused($isFocused, equals: 2)
    }
    // 메인 버튼 뷰 반환하기
    @ViewBuilder
    private func getMainButtomView() -> some View {
        HStack {
            if !isInputFinish {
                NavigationLink(destination: RegisterAvatar(popToRoot: $isActiveForPopToRoot), isActive: $isLinkActive) {
                    Button {
                        if isFirstClick {
                            withAnimation {
                                isShowingType.toggle()
                            }
                            isFirstClick = false
                            isFocused = 2
                        } else if newCat.age.isEmpty || newCat.type.isEmpty {
                            isLinkActive = true
                        }
                    } label: {
                        GilCatMainButton(text: "건너뛰기", foreground: .white, background: .constant(.pickerColor))
                    }
                }
                .isDetailLink(false)
            }

            NavigationLink(destination: RegisterAvatar(popToRoot: $isActiveForPopToRoot), isActive: $isLinkActive) {
                Button {
                    if isFirstClick {
                        withAnimation {
                            isShowingType.toggle()
                        }
                        isFirstClick = false
                        isFocused = 2
                    } else {
                        isLinkActive = true
                    }
                } label: {
                    GilCatMainButton(text: "다음", foreground: .white, background: $buttonColor)
                }.frame(maxWidth: .infinity)
            }
            .isDetailLink(false)
            .disabled(newCat.age.isEmpty && newCat.type.isEmpty)
        }
        .padding()
    }
}

struct RegisterAge_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAge(popToRoot: .constant(false)).environmentObject(NewCatRegisterViewModel())
    }
}
