import SwiftUI

struct CustomButton: View {
    var body: some View {
        Button("다음") {
        }.frame(width: 350, height: 50).font(.system(size: 20).bold()).foregroundColor(.white).background(Color.buttonColor).cornerRadius(20)

    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton()
    }
}
