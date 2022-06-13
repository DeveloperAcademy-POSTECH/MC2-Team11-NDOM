//
//  register1.swift
//  GilCat
//
//  Created by 김연호 on 2022/06/07.
//

import SwiftUI

struct RegisterStart: View {
    @EnvironmentObject var catInfo: GilCatInfoList
//    @Binding var buildNavigationStack: Bool
    @State var isLinkActive = false

    var body: some View {
        // Todo: 현재는 네비게이션뷰로 다른 뷰들을 연결했지만 괜찮은 애니메이션 전환 요소를 찾으면 바꿀 예정입니다.
        NavigationView {
            VStack {
                // 제목
                HStack {
                    GilCatTitle(titleText: "나만의 길고양이 기록장을 만들어보세요!").padding([.top, .leading])
                    Spacer()
                }
                // 목차
                VStack(alignment: .leading) {
                    getProcessContentView(order: 1, text: "공유 코드가 있다면 알려주세요!")
                    getProcessContentView(order: 2, text: "길냥이 프로필을 적어주세요!")
                    getProcessContentView(order: 3, text: "나만의 길냥이를 만들어주세요!")
                }
                .padding()
                Spacer()
                // 메인 버튼
                NavigationLink(destination: RegisterCode($isLinkActive), isActive: $isLinkActive) {
                    Button {
                        isLinkActive = true
                        // 고양이 정보를 저장하는 새로운 객체 생성
                        // 등록하다가 뒤로 가기로 다시 왔다면 객체 생성을 하지 않고 기존 객체를 씀
                        if catInfo.infoList.isEmpty || catInfo.infoList[catInfo.infoList.endIndex-1].isUploadedToServer {
                            catInfo.infoList.append(GilCatInfo())
                        }
                    } label: {
                        GilCatMainButton(text: "시작하기", foreground: Color.white, background: .buttonColor)
                    }
                    .padding()
                }
                .isDetailLink(false)
            }
            .background(Color.backgroundColor)
            .navigationBarTitle("목차", displayMode: .inline)
        }
    }
    
    // 목차 뷰 반환하기
    func getProcessContentView(order: Int, text: String) -> some View {
        return HStack {
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
}

struct RegisterStart_Previews: PreviewProvider {
    static var previews: some View {
        RegisterStart()
    }
}
