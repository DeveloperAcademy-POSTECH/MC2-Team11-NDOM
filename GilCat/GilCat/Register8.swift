//
//  Register8.swift
//  GilCat
//
//  Created by 김동락 on 2022/06/08.
//

import SwiftUI

struct Register8: View {
    @State var temp = false
    @State var isModalPresented = false
    @State var newTagText = ""
    @State var tags: [[Tag]] = [
        [Tag("Hello"), Tag("World"), Tag("Guys")]
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            ViewComponents.getSubTitleView(text: "※ 해당되는 건강 태그를 선택해주세요. ")
            Spacer()
            ViewComponents.getTitleView(text: "건강")
            VStack(alignment: .leading) {
                ForEach(tags.indices, id: \.self) { indexOfLine in
                    HStack {
                        ForEach(tags[indexOfLine].indices, id: \.self) { indexOfTag in
                            getTagView(indexOfLine: indexOfLine, indexOfTag: indexOfTag)
                        }
                    }
                }
                Button {
                    isModalPresented = true
                } label: {
                    Text("+")
                        .padding()
                        .foregroundColor(Color(hex: "FFFFFF"))
                        .background(Color(hex: "535353"))
                        .font(.system(size: 15, weight: Font.Weight.heavy))
                        .cornerRadius(20)
                }
            }
            Spacer()
            Button {
            
            } label: {
                ViewComponents.getMainButtonView(text: "등록 완료", foreground: Color(hex: "FFFFFF"), background: Color(hex: "FFAB73"))
            }
            
        }
        .padding()
        .background(Color(hex: "39495B"))
        .sheet(isPresented: $isModalPresented) {
            WriteTagView(newTagText: $newTagText, isModalPresented: $isModalPresented, tags: $tags)
        }
    }
    
    func getTagView(indexOfLine: Int, indexOfTag: Int) -> some View {
        var tag = tags[indexOfLine][indexOfTag]
        return Button {
            tags[indexOfLine][indexOfTag] = Tag(tag.text, isExceeded: tag.isExceeded, isClicked: !tag.isClicked)
        } label: {
            Text(tag.text)
                .padding()
                .foregroundColor(Color(hex: "FFFFFF"))
                .background(tag.isClicked ? Color(hex: "FFAB73") : Color(hex: "535353"))
                .font(.system(size: 15, weight: Font.Weight.heavy))
                .cornerRadius(20)
                .overlay(
                    GeometryReader { reader -> Color in
                        let maxX = reader.frame(in: .global).maxX
                        if maxX > UIScreen.main.bounds.width - 50 && !tag.isExceeded {
                            DispatchQueue.main.async {
                                tag.isExceeded = true
                                tags.append([tag])
                                tags[indexOfLine].remove(at: indexOfTag)
                            }
                        }
                        return Color.clear
                    },
                    alignment: .trailing
                )
        }
    }
}

struct Tag: Identifiable {
    init(_ text: String, isExceeded: Bool = false, isClicked: Bool = false) {
        self.text = text
        self.isExceeded = isExceeded
        self.isClicked = isClicked
    }
    var id = UUID().uuidString
    var text: String
    var isExceeded = false
    var isClicked = false
}

struct WriteTagView: View {
    @Binding var newTagText: String
    @Binding var isModalPresented: Bool
    @Binding var tags: [[Tag]]
    @FocusState var isModalFocused: Bool?
    var body: some View {
        VStack {
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
            TextEditor(text: $newTagText)
                .frame(height: 100)
                .focused($isModalFocused, equals: true)
            Spacer()
            Button {
                tags[tags.endIndex-1].append(Tag(newTagText))
                newTagText = ""
                isModalPresented = false
            } label: {
                ViewComponents.getMainButtonView(text: "태그 추가", foreground: Color(hex: "FFFFFF"), background: Color(hex: "FFAB73"))
            }
        }
        .padding()
        .background(Color(hex: "39495B"))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isModalFocused = true
            }
        }
    }
}

struct Register8_Previews: PreviewProvider {
    static var previews: some View {
        Register8()
    }
}
