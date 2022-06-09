import SwiftUI

struct register3: View {
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack {
                HStack {
                    CustomTitle().customTitle(TitleText: "이름").padding()
                    Spacer()
                }
                CustomTextField(placeHolder: "고양이 이름을 지어볼까요?").padding()
                
                Spacer().frame(height: 350)
                }
                
            }
        }
    }

struct register3_Previews: PreviewProvider {
    static var previews: some View {
        register3()
    }
}
