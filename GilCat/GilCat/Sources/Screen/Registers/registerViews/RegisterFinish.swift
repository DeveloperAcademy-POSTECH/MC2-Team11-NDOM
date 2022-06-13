//
//  register8.swift
//  GilCat
//
//  Created by 김동락 on 2022/06/10.
//

import SwiftUI
import ConfettiSwiftUI

struct RegisterFinish: View {
    @EnvironmentObject var catInfo: GilCatInfoList
    @Binding var buildNavigationStack: Bool
    @State var timerCounter: Int = 4
    @State var effectCounter: Int = 3
    let timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
    
    init(_ buildNavigationStack: Binding<Bool>) {
        self._buildNavigationStack = buildNavigationStack
    }
    
    var body: some View {
        VStack {
            // 제목
            GilCatTitle(titleText: "축하드려요🎉")
            // 커스텀한 아바타 + 약간 빛나는 느낌의 효과
            ZStack {
                Rectangle()
                    .frame(width: 130, height: 130)
                    .background(.white)
                    .blur(radius: 50.0)
                Image(catInfo.infoList[catInfo.infoList.endIndex-1].imageName!)
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
            // 입력했던 정보들
            VStack(spacing: 15) {
                getDescribeView(title: "이름", index: 0)
                getDescribeView(title: "성별", index: 1)
                getDescribeView(title: "중성화", index: 2)
                getDescribeView(title: "나이", index: 3)
                getDescribeView(title: "종", index: 4)
            }
            Spacer()
            // 메인 버튼
            Button {
                // Todo: 완성된 고양이 정보 객체를 서버에 보내기
                catInfo.infoList[catInfo.infoList.endIndex-1].isUploadedToServer = true
                buildNavigationStack = false
            } label: {
                GilCatMainButton(text: "관리 시작하기", foreground: Color.white, background: .buttonColor)
            }
            .padding()
            
        }
        .background(Color.backgroundColor)
        .navigationBarTitle("등록 완료", displayMode: .inline)
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
    // 린트.. 고치려 노력은 해봤지만 방법을 모르겠습니다....
    // 각각의 고양이 정보 뷰 반환하기
    func getDescribeView(title: String, index: Int) -> some View {
        var content = "-"
        // 고양이 정보 중 어떤 것인지 구분하기
        switch index {
        case 0:
            if let name = catInfo.infoList[catInfo.infoList.endIndex-1].name {
                content = name
            }
        case 1:
            if let gender = catInfo.infoList[catInfo.infoList.endIndex-1].gender {
                content = gender
            }
        case 2:
            if let neutralized = catInfo.infoList[catInfo.infoList.endIndex-1].neutralized {
                content = neutralized
            }
        case 3:
            if let age = catInfo.infoList[catInfo.infoList.endIndex-1].age {
                content = age
            }
        case 4:
            if let type = catInfo.infoList[catInfo.infoList.endIndex-1].type {
                content = type
            }
        default:
            content = "-"
        }
        // 비어있으면 짝대기로 하기
        if content.isEmpty {
            content = "-"
        }
        // 뷰 반환하기
        return HStack {
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
}

struct RegisterFinish_Previews: PreviewProvider {
    static var previews: some View {
        RegisterFinish(.constant(false)).environmentObject(GilCatInfoList().self)
    }
}
