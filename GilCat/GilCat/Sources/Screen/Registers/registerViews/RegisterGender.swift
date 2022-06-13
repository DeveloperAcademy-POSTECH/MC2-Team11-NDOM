import SwiftUI

struct RegisterGender: View {
    @EnvironmentObject var catInfo: GilCatInfoList
    @Binding var buildNavigationStack: Bool
    @State var isLinkActive = false
    @State var genderChoice: GilCatPicker.Choice = .first
    @State var TNRChoice: GilCatPicker.Choice = .first
    let genderFirstChoice = "암컷"
    let genderSecondChoice = "수컷"
    let TNRFirstChoice = "❌"
    let TNRSecondChoice = "⭕️"
    
    init(_ buildNavigationStack: Binding<Bool>) {
        self._buildNavigationStack = buildNavigationStack
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack {
                // 성별 피커
                HStack {
                    GilCatTitle(titleText: "성별").padding([.top, .leading])
                    Spacer()
                }
                GilCatPicker(isClick: $genderChoice, firstSelect: genderFirstChoice, secondSelect: genderSecondChoice)
                // 중성화 여부 피커
                HStack {
                    GilCatTitle(titleText: "중성화 여부").padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0))
                    Spacer()
                }
                GilCatPicker(isClick: $TNRChoice, firstSelect: TNRFirstChoice, secondSelect: TNRSecondChoice)
                
                Spacer()
                NavigationLink(destination: RegisterAge($buildNavigationStack), isActive: $isLinkActive) {
                    Button {
                        // 어떤게 클릭됐는지에 따라 값 줘야함
                        if genderChoice == .first {
                            catInfo.infoList[catInfo.infoList.endIndex-1].gender = genderFirstChoice
                        } else {
                            catInfo.infoList[catInfo.infoList.endIndex-1].gender = genderSecondChoice
                        }
                        if TNRChoice == .first {
                            catInfo.infoList[catInfo.infoList.endIndex-1].neutralized = TNRFirstChoice
                        } else {
                            catInfo.infoList[catInfo.infoList.endIndex-1].neutralized = TNRSecondChoice
                        }
                        isLinkActive = true
                    } label: {
                        GilCatMainButton(text: "다음", foreground: Color.white, background: .buttonColor)
                    }
                    .padding()
                }
                .isDetailLink(false)
            }
        }
        .navigationBarTitle("성별 및 중성화", displayMode: .inline)
        .onAppear {
            // 뒤로가기로 돌아왔다면 기존에 입력했던 정보를 받아오기
            if !catInfo.infoList[catInfo.infoList.endIndex-1].isUploadedToServer {
                if catInfo.infoList[catInfo.infoList.endIndex-1].gender != nil {
                    if genderFirstChoice == catInfo.infoList[catInfo.infoList.endIndex-1].gender! {
                        genderChoice = .first
                    } else {
                        genderChoice = .second
                    }
                }
                if catInfo.infoList[catInfo.infoList.endIndex-1].neutralized != nil {
                    if TNRFirstChoice == catInfo.infoList[catInfo.infoList.endIndex-1].neutralized! {
                        TNRChoice = .first
                    } else {
                        TNRChoice = .second
                    }
                }
            }
        }
    }
}
struct RegisterGender_Previews: PreviewProvider {
    static var previews: some View {
        RegisterGender(.constant(false)).environmentObject(GilCatInfoList().self)
    }
}
