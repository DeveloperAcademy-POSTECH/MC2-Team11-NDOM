import SwiftUI

struct NoteFoodEdit: View {
    
    enum FocusField1: Hashable {
        case field
    }
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var catInfo: InfoToNote
    @FocusState private var focusField: FocusField1?
    
    init() {
        Theme.navigationBarColors(background: .systemFill, titleColor: .white)
    }
    
    var body: some View {
        ZStack {
            Color("BackGroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                infoText(Text: "※ 사료 이름과 시간을 선택해서 수정해주세요.")
                infoName()
                foodTextField()
                lastFood()
                Spacer()
                putFoodButton()
            }
        }
        .navigationTitle("급식사료 수정")
        .navigationViewStyle(.stack)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
                    .onTapGesture {
                        self.presentation.wrappedValue.dismiss()
                    }
            }
        }
    }
    
    // MARK: 새로운 사료 이름 적는 Textfield
    @ViewBuilder
    private func foodTextField() -> some View {
        TextField("", text: $catInfo.dietInfo.name)
            .focused($focusField, equals: .field)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.focusField = .field }
            }
            .onChange(of: catInfo.dietInfo.name) { _ in
                if catInfo.dietInfo.name.count > 15 {
                    self.catInfo.dietInfo.name = String(catInfo.dietInfo.name.prefix(15))
                    // nickName -> self.nickName 으로 바뀜
                }
            }
            .modifier(PlaceholderStyle(showPlaceHolder: catInfo.dietInfo.name.isEmpty, placeholder: "오늘 준 사료를 입력해 주세요!"))
            .foregroundColor(Color.white.opacity(0.7))
            .font(.system(size: 20, weight: .medium))
            .disableAutocorrection(true)
            .padding(.horizontal, 40)
    }
    
    // MARK: 맨 상단 안내문
    @ViewBuilder
    private func infoText(Text text: String) -> some View {
        Text(text)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
            .opacity(0.6)
            .padding(.top, 15)
    }
    
    // MARK: 급식사료
    @ViewBuilder
    private func infoName() -> some View {
        HStack {
            ZStack {
                Image("fourLetter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 80, alignment: .center)
                    .offset(y: 14)
                    
                Text("급식사료")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.white)
            }
            .offset(y: -10)
            .padding(.bottom, -10)
            .padding(.horizontal, 50)
            .padding(.top, 40)
            
            Spacer()
        }
    }
    
    // MARK: 마지막 사료 - 아직 변수 넣지 않음, 데이터가 없음
    @ViewBuilder
    private func lastFood() -> some View {
            HStack {
                Text("마지막 사료 :")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .opacity(0.9)
                    .padding(.leading, 10)
                
                Text("캐츠랑 리브레")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(height: 1)
                    .padding()
                    .background(Color.mint)
                    .cornerRadius(30)
                
                Spacer()
                
            }
            .padding(.leading, 40)
            .padding(.top, 20)
    }
    
    // MARK: 빠져나가기
    @ViewBuilder
    private func putFoodButton() -> some View {
        Button {
            self.presentation.wrappedValue.dismiss()
        } label: {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/12, alignment: .center)
                .cornerRadius(20)
                .foregroundColor(catInfo.dietInfo.name.count < 3 ? Color.gray : Color("ButtonColor"))
                .overlay {
                    Text("등록 완료")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
        }
        .disabled(catInfo.dietInfo.name.count < 3)
    }
}

struct NoteFoodEdit_Previews: PreviewProvider {
    static var previews: some View {
        NoteFoodEdit()
            .environmentObject(InfoToNote())
    }
}
