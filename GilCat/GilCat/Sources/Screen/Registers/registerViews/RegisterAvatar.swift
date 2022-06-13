import SwiftUI

struct RegisterAvatar: View {
    @EnvironmentObject var catInfo: GilCatInfoList
    @Binding var buildNavigationStack: Bool
    @State var isLinkActive = false
    @State var viewChoice: GilCatPicker.Choice = .first
    @State var selectedCatColor = GilCatColor.gray
    @State var selectedImageIndex = 0
    let gridSpace: CGFloat = 20
    let viewFirstChoice: String = "외형"
    let viewSecondChoice: String = "색"
    
    init(_ buildNavigationStack: Binding<Bool>) {
        UIScrollView.appearance().bounces = false
        self._buildNavigationStack = buildNavigationStack
    }
    
    var body: some View {
        VStack {
            // 제목
            HStack {
                GilCatTitle(titleText: "캐릭터").padding([.top, .leading])
                Spacer()
            }
            // 커스텀한 아바타
            Image(selectedCatColor.group[selectedImageIndex])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 130)
                .padding()
                .background(Color.profileBackgroundColor)
                .cornerRadius(50)
                .frame(maxWidth: .infinity)
            // 색과 외형 중 고를 수 있는 피커
            GilCatPicker(isClick: $viewChoice, firstSelect: viewFirstChoice, secondSelect: viewSecondChoice)
                .padding(.vertical)
            // 피커에 따라 보여지는 커스텀 칸
            if viewChoice == .first {
                getBodySelectView()
            } else {
                getColorSelectView()
            }
            Spacer()
            // 메인 버튼
            NavigationLink(destination: RegisterFinish($buildNavigationStack), isActive: $isLinkActive) {
                Button {
                    // 커스텀해서 선택된 이미지 정보 저장하기
                    catInfo.infoList[catInfo.infoList.endIndex-1].avatarColor = selectedCatColor
                    catInfo.infoList[catInfo.infoList.endIndex-1].avatarBodyIndex = selectedImageIndex
                    isLinkActive = true
                } label: {
                    GilCatMainButton(text: "다음", foreground: Color.white, background: .buttonColor)
                }
                .padding()
            }
            .isDetailLink(false)
        }
        .background(Color.backgroundColor)
        .navigationBarTitle("아바타", displayMode: .inline)
        .onAppear {
            // 뒤로가기로 돌아왔다면 기존에 입력했던 정보를 받아오기
            if !catInfo.infoList[catInfo.infoList.endIndex-1].isUploadedToServer {
                if catInfo.infoList[catInfo.infoList.endIndex-1].avatarColor != nil {
                    selectedCatColor = catInfo.infoList[catInfo.infoList.endIndex-1].avatarColor!
                }
                if catInfo.infoList[catInfo.infoList.endIndex-1].avatarBodyIndex != nil {
                    selectedImageIndex = catInfo.infoList[catInfo.infoList.endIndex-1].avatarBodyIndex!
                }
            }
        }
    }
    
    // 몸체를 선택할 때 반복되는 이미지에 대한 뷰를 반환
    func getImageView(_ index: Int) -> some View {
        return Image(selectedCatColor.group[index])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(selectedImageIndex == index ? Color.buttonColor : Color.profileBackgroundColor, lineWidth: 4)
            )
            .onTapGesture {
                selectedImageIndex = index
            }
    }
    
    // 몸체 선택하는 창 나오게 하기
    func getBodySelectView() -> some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: gridSpace) {
                ForEach(0..<selectedCatColor.group.count/2, id: \.self) { index in
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
    
    // 색깔을 선택할 때 반복되는 도형에 대한 뷰를 반환
    func getColorView(_ catColor: GilCatColor) -> some View {
        return Circle()
            .fill(catColor.color)
            .frame(width: 50, height: 50)
            .onTapGesture {
                selectedCatColor = catColor
            }
            
    }
    
    // 색깔 선택하는 창 나오게 하기
    func getColorSelectView() -> some View {
        return HStack(spacing: gridSpace) {
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
}

struct RegisterAvatar_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAvatar(.constant(false)).environmentObject(GilCatInfoList().self)
    }
}
