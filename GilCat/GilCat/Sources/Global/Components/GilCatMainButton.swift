import SwiftUI

// 앱에서 메인 버튼으로 쓰이는 뷰
/*
 사용방법 :
    GilCatMainButton(text: 원하는 버튼 텍스트, foreground: 원하는 글자 색, background: $원하는 버튼 색)
 
    GilCatTextField(inputText: $newCat.name, placeHolder: "고양이 이름을 지어볼까요?", textLimit: 8).padding([.leading, .bottom])
     .onChange(of: newCat.name) { _ in
         withAnimation {
             buttonColor = newCat.name.isEmpty ? Color.gray : Color.buttonColor
         }
     }
 
 */

struct GilCatMainButton: View {
    @State var text: String
    @State var foreground: Color
    @Binding var background: Color // 버튼색 변경을 위한 바인딩선언
    
    var body: some View {
        Text(text)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(foreground)
                .background(background)
                .font(.system(size: 20, weight: Font.Weight.heavy))
                .cornerRadius(20)
    }
}

struct GilGatMainButton_Previews: PreviewProvider {
    static var previews: some View {
        GilCatMainButton(text: "다음", foreground: Color.white, background: .constant(.black))
    }
}
