import SwiftUI
import CoreGraphics

struct HealthTagShow: View {
    @Environment(\.presentationMode) var presentation
    @Binding var tags: [HealthTag]
    @State var isModalPresented = false
    @State var tempTags = [HealthTag]()
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomSubTitle(text: "※ 해당되는 건강 태그를 선택해주세요.")
            HStack(alignment: .firstTextBaseline) {
                GilCatTitle(titleText: "건강")
                Spacer()
                getPlusButton()
            }
            getExtraExplanation(text: "✓ 태그를 터치하면 활성화되어 기록장에 추가됩니다.")
            ScrollView {
                TagArea(tags: $tempTags, type: .forEdit)
            }.frame(height: 400)
            Spacer()

            getMainButton(text: "수정 완료")
        }
        .padding()
        .background(Color.backgroundColor)
        .sheet(isPresented: $isModalPresented) {
            WriteTag(isModalPresented: $isModalPresented, tags: $tempTags)
        }
        .onAppear {
            self.tempTags = tags
        }
        .navigationTitle("태그 수정")
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
    }
    // 태그 추가 버튼
    @ViewBuilder
    private func getPlusButton() -> some View {
        Button {
            isModalPresented = true
        } label: {
            HStack {
                Spacer()
                Image(systemName: "plus")
                    .padding()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.buttonColor)
                    .background(Color.profileBackgroundColor)
                    .font(.system(size: 25, weight: Font.Weight.heavy))
                    .cornerRadius(20)
                    .padding(.leading, 4)
            }
        }
    }
    // 태그에 대한 부가 설명
    @ViewBuilder
    private func getExtraExplanation(text: String) -> some View {
        Text(text)
            .font(.caption)
            .minimumScaleFactor(0.5)
            .foregroundColor(.white)
            .padding(.leading)
            .padding(.top, -10)
            .padding(.bottom)
    }
    // 메인 버튼
    @ViewBuilder
    private func getMainButton(text: String) -> some View {
        Button {
            tags = tempTags
            presentation.wrappedValue.dismiss()
        } label: {
            GilCatMainButton(text: text, foreground: .white, background: .constant(.buttonColor))
        }
    }
}

// 태그를 새로 추가할 떄 모달창으로 나타나는 뷰
struct WriteTag: View {
    @State private var buttonColor: Color = .gray
    @FocusState var isModalFocused: Bool?
    @Binding var isModalPresented: Bool
    @Binding var tags: [HealthTag]
    @State var newTagText: String = ""
    
    var body: some View {
        VStack {
            getCloseButton()
            GilCatTextField(inputText: $newTagText, placeHolder: "태그를 추가하세요.", textLimit: 15)
                .onChange(of: newTagText) { _ in
                    withAnimation {
                        buttonColor = newTagText.isEmpty ? Color.gray : Color.buttonColor
                    }
                }
                .focused($isModalFocused, equals: true)
            Spacer()

            Text("\(newTagText.count)/15")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
            getMainButton(text: "태그 추가")
        }
        .padding()
        .background(Color.backgroundColor)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                isModalFocused = true
            }
        }
    }
    // 모달 닫기 버튼
    @ViewBuilder
    private func getCloseButton() -> some View {
        HStack {
            Spacer()
            Button {
                newTagText = ""
                isModalPresented = false
            } label: {
                Text("닫기")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: Font.Weight.heavy))
            }
        }
    }
    // 메인 버튼 (아무것도 입력 안됐을 시 비활성화 되어있음)
    @ViewBuilder
    private func getMainButton(text: String) -> some View {
        Button {
            tags.append(HealthTag(newTagText))
            newTagText = ""
            isModalPresented = false
        } label: {
            GilCatMainButton(text: text, foreground: .white, background: $buttonColor)
        }.disabled(newTagText.isEmpty)
    }
}

// 태그 나열해서 보여주는 공간
struct TagArea: View {
    enum ShowingType {
        case forDisplay, forEdit
    }
    @Binding var tags: [HealthTag]
    @State private var totalHeight = CGFloat(0)
    let type: ShowingType
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .frame(height: totalHeight)
    }
    
    // 태그 나열하기
    @ViewBuilder
    private func generateContent(in geoProxy: GeometryProxy) -> some View {
        var width = 0
        var height = 0
        
        ZStack(alignment: .topLeading) {
            ForEach(0..<self.tags.count, id: \.self) { idx in
                self.item(for: idx)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { val in
                        if abs(CGFloat(width) - val.width) > geoProxy.size.width {
                            width = 0
                            height -= Int(val.height)
                        }
                        let result = width
                        if tags[idx] == self.tags.last! {
                            width = 0
                        } else {
                            width -= Int(val.width)
                        }
                        return CGFloat(result)
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if tags[idx] == self.tags.last! {
                            height = 0
                        }
                        return CGFloat(result)
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    // 태그 형태 만들기
    @ViewBuilder
    private func item(for idx: Int) -> some View {
        if type == .forEdit {
            ZStack(alignment: .trailing) {
                Button {
                    tags[idx].isClicked.toggle()
                } label: {
                    Text(tags[idx].text)
                        .padding()
                        .padding(.trailing, 30)
                        .foregroundColor(.white)
                        .background(tags[idx].isClicked ? Color.buttonColor : Color.profileBackgroundColor)
                        .font(.system(size: 15, weight: Font.Weight.heavy))
                        .cornerRadius(20)
                }
                Image(systemName: "x.circle.fill")
                    .foregroundColor(Color.white)
                    .padding(.trailing, 12)
                    .font(.system(size: 18))
                    .onTapGesture {
                        tags.remove(at: idx)
                    }
            }
        } else {
            Text(tags[idx].text)
                .padding()
                .foregroundColor(.white)
                .background(Color.buttonColor)
                .font(.system(size: 15, weight: Font.Weight.heavy))
                .cornerRadius(20)
        }
    }
    
    // 높이 계산하기
    @ViewBuilder
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
