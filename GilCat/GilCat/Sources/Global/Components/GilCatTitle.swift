import SwiftUI

// 얼룩 무늬와 함께 제목이 나타나게 해주는 뷰
struct GilCatTitle: View {
    @State var titleText: String = ""
    /*
     사용방법:
        customTitle(titleText: String값으로 원하는 텍스트 주면 count값이 5 이하할때는 한줄짜리 점박이, 그 이상이면 두줄짜리 그림이 백그라운드에 생김)
     
     */
    func customTitle(titleText: String) -> some View {
        var imageName = ""
        var imageWidth = 0
        // 글자의 길이에 따라 어떤 얼룩 무늬로 할지, 얼룩 무늬 이미지의 크기는 얼마나 할지 정하기
        if titleText.count == 1 {
            imageName = "oneLetter"
            imageWidth = 30
        } else if titleText.count == 2 {
            imageName = "twoLetter"
            imageWidth = 60
        } else if titleText.count == 3 {
            imageName = "threeLetter"
            imageWidth = 90
        } else if titleText.count == 4 {
            imageName = "fourLetter"
            imageWidth = 120
        } else if titleText.count == 5 {
            imageName = "fiveLetter"
            imageWidth = 150
        } else if titleText.count > 5 {
            imageName = "twoLine"
            imageWidth = 200
        }
        return HStack {
            ZStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .offset(x: 11, y: 11).opacity(0.85)
                    .frame(width: CGFloat(imageWidth))
                Text("\(titleText)").bold().foregroundColor(.white).font(.system(size: 40)).padding()
            }
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
