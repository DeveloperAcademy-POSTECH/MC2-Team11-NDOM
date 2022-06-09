import SwiftUI

struct Register3: View {
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack {
                HStack {
                    CustomTitle().customTitle(titleText: "이름").padding()
                    Spacer()
                }
                CustomTextField(placeHolder: "고양이 이름을 지어볼까요?").padding()
                
                Spacer().frame(height: 350)
                }
                
            }
        }
    }

struct Register3_Previews: PreviewProvider {
    static var previews: some View {
        Register3()
    }
}
