import SwiftUI

struct RegisterName: View {
    @EnvironmentObject var newCat: NewCatRegisterViewModel
    @Environment(\.presentationMode) private var presentation
    @FocusState private var isFocused: Bool?
    @Binding private var isActiveForPopToRoot: Bool
    @State private var isLinkActive = false
    @State private var isAlertActive = false
    @State private var buttonColor: Color = .gray
    
    init(popToRoot: Binding<Bool>) {
        Theme.navigationBarColors(background: .systemFill, titleColor: .white)
        self._isActiveForPopToRoot = popToRoot
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea(.all)
            VStack {
                getTitleView("이름")
                getNameTextView()
                Spacer()
                getMainButtomView()
            }
        }
        .navigationTitle("별명")
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
        .focused($isFocused, equals: true)
        .alert("이름을 입력해주세요", isPresented: $isAlertActive) {
            Button("확인") {}
        }
        .onAppear {
            // 화면이 나타나고 0.5초 뒤에 자동으로 공유코드 첫번째 입력칸에 포커스 되도록 하기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                isFocused = true
            }
        }
    }
    // 이름 텍스트 필트 반환하기
    @ViewBuilder
    private func getNameTextView() -> some View {
        GilCatTextField(inputText: $newCat.name, placeHolder: "고양이 이름을 지어볼까요?", textLimit: 8).padding([.leading, .bottom])
            .onChange(of: newCat.name) { _ in
                withAnimation {
                    buttonColor = newCat.name.isEmpty ? Color.gray : Color.buttonColor
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
    // 메인 버튼 뷰 반환하기
    @ViewBuilder
    private func getMainButtomView() -> some View {
        NavigationLink(destination: RegisterGender(popToRoot: $isActiveForPopToRoot), isActive: $isLinkActive) {
            Button {
                // 이름이 입력이 안됐다면, 팝업 창 보여주기
                if newCat.name.isEmpty {
                    isAlertActive = true
                } else {
                    isLinkActive = true
                }
            } label: {
                GilCatMainButton(text: "다음", foreground: Color.white, background: $buttonColor)
            }
            .padding()
        }
        .isDetailLink(false)
        .disabled(newCat.name.isEmpty) // 회색일떄 안 넘어가게 하는 구문
    }
    
}
struct RegisterName_Previews: PreviewProvider {
    static var previews: some View {
        RegisterName(popToRoot: .constant(false)).environmentObject(NewCatRegisterViewModel())
    }
}
