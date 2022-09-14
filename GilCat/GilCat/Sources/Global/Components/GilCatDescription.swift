import SwiftUI

// 주의사항이나 간단한 문구를 적을 때를 위한 뷰
struct CustomSubTitle: View {
    @State var text: String
    
    var body: some View {
        return Text(text)
            .foregroundColor(Color.white)
            .font(.system(size: 15, weight: Font.Weight.heavy))
            .padding()
    }
}

struct CustomSubTitle_Previews: PreviewProvider {
    static var previews: some View {
        CustomSubTitle(text: "※ 다른 사람과 공유할 시, 개인 메모를 제외한 이전 기록이 모두 공유됩니다. ")
    }
}
