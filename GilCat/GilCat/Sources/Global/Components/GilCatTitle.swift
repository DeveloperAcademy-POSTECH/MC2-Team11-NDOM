import SwiftUI

// 얼룩 무늬와 함께 제목이 나타나게 해주는 뷰
struct GilCatTitle: View {
    @State var titleText: String = ""
    /*
     사용방법:
        customTitle(titleText: String값으로 원하는 텍스트 주면 count값이 5 이하할때는 한줄짜리 점박이, 그 이상이면 두줄짜리 그림이 백그라운드에 생김)
     
     */
    func customTitle(titleText: String) -> some View {
        return HStack {
            Text("\(titleText)").bold().foregroundColor(.white).font(.system(size: 40)).padding()
        }
    }
    var body: some View {
        customTitle(titleText: titleText)
        }
    }

struct CustomTitle_Previews: PreviewProvider {
    static var previews: some View {
        GilCatTitle(titleText: "aaa")
            .frame(width: 300, height: 700)
            .background(Color.backgroundColor)
    }
}
