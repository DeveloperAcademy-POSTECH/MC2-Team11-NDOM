import SwiftUI

struct RegisterAvatar: View {
    @EnvironmentObject var newCat: NewCatRegisterViewModel
    @Environment(\.presentationMode) private var presentation
    @Binding private var isActiveForPopToRoot: Bool
    @State private var viewChoice: GilCatPicker.Choice = .first
    @State private var isLinkActive = false
    private let gridSpace: CGFloat = 20
    private let viewFirstChoice: String = "외형"
    private let viewSecondChoice: String = "색"
    
    init(popToRoot: Binding<Bool>) {
        Theme.navigationBarColors(background: .systemFill, titleColor: .white)
        self._isActiveForPopToRoot = popToRoot
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                getTitleView("캐릭터")
                getAvatar()
                GilCatPicker(isClick: $viewChoice, firstSelect: viewFirstChoice, secondSelect: viewSecondChoice)
                    .padding(.vertical)
                // 피커 선택에 따라 보여지는 커스텀 칸
                switch viewChoice {
                case .first:
                    getBodySelectView()
                case .second:
                    getColorSelectView()
                }
                Spacer()
                getMainButtomView()
            }
            .navigationTitle("아바타")
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
    // 아바타 뷰 반환하기
    @ViewBuilder
    private func getAvatar() -> some View {
        Image(newCat.avatarColor.group[newCat.avatarBodyIndex])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 130, height: 130)
            .padding()
            .background(Color.profileBackgroundColor)
            .cornerRadius(50)
            .frame(maxWidth: .infinity)
    }
    // 몸체를 선택할 때 반복되는 이미지에 대한 뷰를 반환하기
    @ViewBuilder
    private func getImageView(_ index: Int) -> some View {
        Image(newCat.avatarColor.group[index])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(newCat.avatarBodyIndex == index ? Color.buttonColor : Color.profileBackgroundColor, lineWidth: 4)
            )
            .onTapGesture {
                newCat.avatarBodyIndex = index
            }
    }
    // 몸체 선택하는 창 뷰 나오게 하기
    @ViewBuilder
    private func getBodySelectView() -> some View {
        ZStack {
            Rectangle()
                .padding()
                .frame(height: 250)
                .foregroundColor(Color.pickerColor)
                .background(Color.pickerColor)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: gridSpace) {
                    ForEach(0..<newCat.avatarColor.group.count/2, id: \.self) { index in
                        VStack(spacing: gridSpace) {
                            getImageView(2*index)
                            getImageView(2*index+1)
                        }
                    }
                }
                .padding()
                .frame(height: 250)
                .background(Color.pickerColor)
            }
        }
    }
    // 색깔을 선택할 때 반복되는 도형에 대한 뷰를 반환
    @ViewBuilder
    private func getColorView(_ catColor: GilCatColor) -> some View {
        Circle()
            .fill(catColor.color)
            .frame(width: 50, height: 50)
            .overlay(
                Circle()
                    .stroke(newCat.avatarColor == catColor ? Color.buttonColor : Color.profileBackgroundColor, lineWidth: 4)
            ) // 색깔 선택시 구분 선 보이게 함
            .onTapGesture {
                newCat.avatarColor = catColor
            }
        
    }
    // 색깔 선택하는 창 나오게 하기
    @ViewBuilder
    private func getColorSelectView() -> some View {
        HStack(spacing: gridSpace) {
            ForEach(0..<GilCatColor.allCases.count/3, id: \.self) { index in
                VStack(spacing: gridSpace) {
                    getColorView(GilCatColor.allCases[3*index])
                    getColorView(GilCatColor.allCases[3*index+1])
                    getColorView(GilCatColor.allCases[3*index+2])
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 250)
        .background(Color.pickerColor)
    }
    // 메인 버튼 뷰 반환하기
    @ViewBuilder
    private func getMainButtomView() -> some View {
        NavigationLink(destination: RegisterFinish(popToRoot: $isActiveForPopToRoot), isActive: $isLinkActive) {
            Button {
                isLinkActive = true
            } label: {
                GilCatMainButton(text: "다음", foreground: Color.white, background: .constant(.buttonColor))
            }
            .padding()
        }
        .isDetailLink(false)
    }
}

struct RegisterAvatar_Previews: PreviewProvider {
    static var previews: some View {
        RegisterGender(popToRoot: .constant(false)).environmentObject(NewCatRegisterViewModel())
    }
}
