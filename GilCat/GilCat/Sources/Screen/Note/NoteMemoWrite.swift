//
//  NoteMemoWriteView.swift
//  GilCat
//
//  Created by 김동락 on 2022/06/15.
//

import SwiftUI

struct NoteMemoWrite: View {
    @Environment(\.presentationMode) private var presentation
    @EnvironmentObject private var catInfo: InfoToNote
    @FocusState private var isFocused: Bool?
    @State private var inputText: String = ""
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea(.all)
            VStack {
                GilCatTextField(inputText: $inputText, placeHolder: "원하는 메모를 작성해보세요!", textLimit: 54).padding([.leading, .bottom])
                Spacer()
                getTextLimit()
                getMainButtom()
            }
        }
        .navigationTitle("메모장 기록")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
        // MARK: 툴바 수정
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
                    .onTapGesture {
                        self.presentation.wrappedValue.dismiss()
                    }
            }
        }
        .focused($isFocused, equals: true)

        .onAppear {
            // 화면이 나타나고 0.5초 뒤에 자동으로 공유코드 첫번째 입력칸에 포커스 되도록 하기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                isFocused = true
            }
        }
    }
    // 제목 뷰 반환하기
    @ViewBuilder
    private func getTitle(_ text: String) -> some View {
        HStack {
            GilCatTitle(titleText: text).padding([.top, .leading])
            Spacer()
        }
    }
    // 메인 버튼 뷰 반환하기
    @ViewBuilder
    private func getMainButtom() -> some View {
        Button {
            // 현재 날짜와 시각 구하기
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YY/MM/dd"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let currentDate = dateFormatter.string(from: Date.now)
            let currentTime = timeFormatter.string(from: Date.now)
            catInfo.memoInfo.append(MemoInfo(date: currentDate, time: currentTime, content: inputText))
            presentation.wrappedValue.dismiss()
        } label: {
            GilCatMainButton(text: "작성 완료", foreground: Color.white, background: .constant(.buttonColor))
        }
        .padding()
    }
    // 글자 수 제한과 지금까지 얼마나 쳤는지 보여주는 뷰 반환하기
    @ViewBuilder
    private func getTextLimit() -> some View {
        Text("\(inputText.count)/54")
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .bold))
    }
}
struct NoteMemoWrite_Previews: PreviewProvider {
    static var previews: some View {
        NoteMemoWrite()
    }
}
