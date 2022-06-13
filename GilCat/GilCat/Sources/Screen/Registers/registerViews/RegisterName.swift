import SwiftUI

struct RegisterName: View {
    @EnvironmentObject var catInfo: GilCatInfoList
    @FocusState var isFocused: Bool?
    @Binding var buildNavigationStack: Bool
    @State var isLinkActive = false
    @State var inputText = ""
    @State var isAlertActive = false
    
    init(_ buildNavigationStack: Binding<Bool>) {
        self._buildNavigationStack = buildNavigationStack
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack {
                HStack {
                    GilCatTitle(titleText: "이름").padding([.top, .leading])
                    Spacer()
                }
                GilCatTextField(inputText: $inputText, placeHolder: "고양이 이름을 지어볼까요?").padding([.leading, .bottom])
                
                Spacer()
                
                NavigationLink(destination: RegisterGender($buildNavigationStack), isActive: $isLinkActive) {
                    Button {
                        // 이름이 입력이 안됐다면, 팝업 창 보여주기
                        if inputText.isEmpty {
                            isAlertActive = true
                        } else {
                            catInfo.infoList[catInfo.infoList.endIndex-1].name = inputText
                            isLinkActive = true
                        }
                    } label: {
                        GilCatMainButton(text: "다음", foreground: Color.white, background: .buttonColor)
                    }
                    .padding()
                }
                .isDetailLink(false)
            }
        }
        .navigationBarTitle("이름", displayMode: .inline)
        .focused($isFocused, equals: true)
        .alert("이름을 입력해주세요", isPresented: $isAlertActive) {
            Button("확인") {}
        }
        .onAppear {
            // 뒤로가기로 돌아왔다면 기존에 입력했던 정보를 받아오기
            if !catInfo.infoList[catInfo.infoList.endIndex-1].isUploadedToServer &&  catInfo.infoList[catInfo.infoList.endIndex-1].name != nil {
                inputText = catInfo.infoList[catInfo.infoList.endIndex-1].name!
            }
            // 화면이 나타나고 0.5초 뒤에 자동으로 공유코드 첫번째 입력칸에 포커스 되도록 하기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isFocused = true
            }
        }
    }
}
struct RegisterName_Previews: PreviewProvider {
    static var previews: some View {
        RegisterName(.constant(false)).environmentObject(GilCatInfoList().self)
    }
}
