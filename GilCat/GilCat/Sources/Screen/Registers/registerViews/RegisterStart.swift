import SwiftUI

struct RegisterStart: View {
    @EnvironmentObject var newCat: NewCatRegisterViewModel
    @Environment(\.presentationMode) private var presentation
    @Binding private var isActiveForPopToRoot: Bool
    @State private var isLinkActive = false
    
    init(popToRoot: Binding<Bool>) {
        Theme.navigationBarColors(background: .systemFill, titleColor: .white)
        self._isActiveForPopToRoot = popToRoot
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor.ignoresSafeArea(.all)
                VStack {
                    getTitleView("나만의 길고양이 기록장을 만들어보세요!")
                    getTotalProcessContentView()
                    Spacer()
                    getMainButtomView()
                }
                .navigationTitle("목차")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationViewStyle(.stack)
                // MARK: 툴바 수정
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .onTapGesture {
                                self.presentation.wrappedValue.dismiss()
                            }
                    }
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
    // 각각의 목차 하나의 뷰 반환하기
    @ViewBuilder
    private func getProcessContentView(order: Int, text: String) -> some View {
        HStack {
            Text(String(order))
                .frame(width: 30, height: 30)
                .foregroundColor(Color.black)
                .background(Color.buttonColor)
                .cornerRadius(10)
            Text(text)
                .foregroundColor(Color.white)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.pickerColor)
        .cornerRadius(20)
    }
    // 목차 뷰 반환하기
    @ViewBuilder
    private func getTotalProcessContentView() -> some View {
        VStack(alignment: .leading) {
            getProcessContentView(order: 1, text: "공유 코드가 있다면 알려주세요!")
            getProcessContentView(order: 2, text: "길냥이 프로필을 적어주세요!")
            getProcessContentView(order: 3, text: "나만의 길냥이를 만들어주세요!")
        }.padding()
    }
    // 메인 버튼 뷰 반환하기
    @ViewBuilder
    private func getMainButtomView() -> some View {
        NavigationLink(destination: RegisterCode(popToRoot: $isActiveForPopToRoot, mode: .register), isActive: $isLinkActive) {
            Button {
                isLinkActive = true
            } label: {
                GilCatMainButton(text: "시작하기", foreground: Color.white, background: .constant(.buttonColor))
            }
            .padding()
        }
        .isDetailLink(false)
    }
}

struct RegisterStart_Previews: PreviewProvider {
    static var previews: some View {
        RegisterStart(popToRoot: .constant(false)).environmentObject(NewCatRegisterViewModel())
    }
}
