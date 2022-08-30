//
//  register8.swift
//  GilCat
//
//  Created by 김동락 on 2022/06/10.
//

import SwiftUI
import ConfettiSwiftUI

struct RegisterFinish: View {
    @EnvironmentObject var newCat: NewCatRegisterViewModel
    @Environment(\.presentationMode) private var presentation
    @Binding private var isActiveForPopToRoot: Bool
    @State private var isLinkActive = false
    @State private var timerCounter: Int = 4
    @State private var effectCounter: Int = 3
    // 폭죽 터지는 간격
    let timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
    
    init(popToRoot: Binding<Bool>) {
        Theme.navigationBarColors(background: .systemFill, titleColor: .white)
        self._isActiveForPopToRoot = popToRoot
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                GilCatTitle(titleText: "축하드려요🎉")
                getShiningAvatarView()
                getTotalInfo()
                Spacer()
                getMainButtomView()
            }
            .navigationTitle("등록 완료")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(.stack)

            .onTapGesture {
                self.presentation.wrappedValue.dismiss()
            }
            
            // 폭죽 효과
            .confettiCannon(counter: $effectCounter)
            // 폭죽 효과 간격 세팅 (현재는 0.4, 0.8, 1.6초 이렇게 3번 터지게 해놨음)
            .onReceive(timer) { _ in
                if timerCounter > 0 && effectCounter > 0 {
                    if timerCounter != 2 {
                        effectCounter -= 1
                    }
                    timerCounter -= 1
                }
            }
        }
    }
    // 커스텀한 아바타 + 약간 빛나는 느낌의 효과의 뷰 반환하기
    @ViewBuilder
    private func getShiningAvatarView() -> some View {
        ZStack {
            Rectangle()
                .frame(width: 130, height: 130)
                .background(.white)
                .blur(radius: 50.0)
            Image(newCat.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 130)
                .padding()
                .background(Color.profileBackgroundColor)
                .cornerRadius(50)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    // 이미지를 클릭하면 폭죽효과 더 볼 수 있음
                    effectCounter -= 1
                }
        }.padding(30)
    }
    // 지금까지 입력한 정보 뷰 반환하기
    @ViewBuilder
    private func getTotalInfo() -> some View {
        VStack(spacing: 15) {
            getDescribeView(title: "이름", index: 0)
            getDescribeView(title: "성별", index: 1)
            getDescribeView(title: "중성화", index: 2)
            getDescribeView(title: "나이", index: 3)
            getDescribeView(title: "종", index: 4)
        }
    }
    // 메인 버튼 뷰 반환하기
    @ViewBuilder
    private func getMainButtomView() -> some View {
        Button {
            var newModel = newCat.makeGilCatInfoModel()
            let catCount = HomeViewModel.instance.catLists.count
            newModel.index = catCount
            newModel.catCode = CodeTool.instance.makeRandomCode()
            FirebaseTool.instance.addCat(newCat: newModel) { error in
                if let error = error {
                    print("새로운 고양이 업로드 에러: \(error)")
                } else {
                    print("새로운 고양이 업로드 성공")
                }
            }
            isActiveForPopToRoot = false
            newCat.initcat()
        } label: {
            GilCatMainButton(text: "관리 시작하기", foreground: Color.white, background: .constant(.buttonColor))
        }
        .padding()
    }
    // 각각의 고양이 정보 뷰 반환하기
    @ViewBuilder
    private func getDescribeView(title: String, index: Int) -> some View {
        let content = getInfoText(title, index)
        // 뷰 반환하기
        HStack {
            Text(title)
                .foregroundColor(.white)
                .opacity(0.7)
                .font(.system(size: 18, weight: .heavy))
            Spacer()
            Text(content)
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .heavy))
        }
        .frame(width: 200)
    }
    // 인덱스에 따라 줘야 할 정보 주기
    private func getInfoText(_ title: String, _ index: Int) -> String {
        var content: String
        // 고양이 정보 중 어떤 것인지 구분하기
        switch index {
        case 0:
            content = newCat.name
        case 1:
            content = newCat.gender == .male ? "수컷" : "암컷"
        case 2:
            content = newCat.neutralized ? "⭕️" : "❌"
        case 3:
            content = newCat.age
        case 4:
            content = newCat.type
        default:
            content = ""
        }
        // 비어있으면 짝대기로 하기
        if content.isEmpty {
            content = "-"
        }
        return content
    }
}

struct RegisterFinish_Previews: PreviewProvider {
    static var previews: some View {
        RegisterFinish(popToRoot: .constant(false))
            .environmentObject(NewCatRegisterViewModel())
    }
}
