//
//  LoginView.swift
//  GilCat
//
//  Created by KYUBO A. SHIM on 2022/06/09.
//

import SwiftUI

struct Login: View {
    
    enum FocusField: Hashable {
        case field
    }
    
    @State private var nickName = ""
    @State private var checkName = false
    @State private var checkNetwork = true
    @FocusState private var focusField: FocusField?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackGroundColor")
                    .edgesIgnoringSafeArea(.all
                    )
                VStack(alignment: .leading) {
                    nicknameTextField(name: nickName)
                    checkValidNickname(network: checkNetwork, duplicate: checkName, name: nickName)
                    Spacer()
                    NavigationLink(destination: Home(viewModel: HomeViewModel.instance)) {
                        createNicknameButton()
                    }
                    .disabled(!checkNetwork || checkName || nickName.count > 8 || nickName.count < 2)
                }
                .navigationBarHidden(false)
            }
            .navigationTitle("닉네임 등록")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: 닉네임 받기
    @ViewBuilder
    private func nicknameTextField(name nickName: String) -> some View {
        TextField("", text: $nickName)
            .focused($focusField, equals: .field)
            .onChange(of: nickName) { _ in
                if nickName.count > 8 {
                    self.nickName = String(nickName.prefix(8))
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.focusField = .field }
            }
            .modifier(PlaceholderStyle(showPlaceHolder: nickName.isEmpty, placeholder: "원하는 닉네임을 정해주세요!"))
            .foregroundColor(Color.white)
            .font(.system(size: 22, weight: .heavy))
            .disableAutocorrection(true)
            .padding(.horizontal, 40)
            .padding(.top, 40)
    }
    
    // MARK: 조건 맞는지 확인하고 넘어가는 버튼
    @ViewBuilder
    private func createNicknameButton() -> some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/12, alignment: .center)
            .cornerRadius(20)
            .foregroundColor(!checkNetwork || checkName || nickName.count > 8 || nickName.count < 2 ? .gray : Color("ButtonColor"))
            .overlay {
                Text("다음")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
    }
    
    // MARK: 닉네임 조건에 따른 안내 문구
    @ViewBuilder
    private func checkValidNickname(network checkNetwork: Bool, duplicate checkName: Bool, name nickName: String) -> some View {
        if checkNetwork && checkName {
            Text("중복된 이름입니다.")
                .font(.system(size: 13, weight: .light))
                .foregroundColor(.red.opacity(0.7))
                .padding(.horizontal, 50)
        } else if !checkNetwork {
            Text("네트워크를 확인해 주세요.")
                .font(.system(size: 13, weight: .light))
                .foregroundColor(.red.opacity(0.7))
                .padding(.horizontal, 50)
        } else {
            Text("닉네임은 2~8글자로 적어주세요.")
            .font(.system(size: 13, weight: .light))
            .foregroundColor((nickName.count > 8) ? .red : .green)
            .opacity(0.8)
            .padding(.horizontal, 50)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
