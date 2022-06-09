import SwiftUI

struct CustomTitle: View {
    @State var titleText: String = ""
    
    func customTitle(titleText: String) -> some View {
        var imageName = ""
        var imageWidth = 0
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
        CustomTitle(titleText: "aaa")
            .frame(width: 300, height: 700)
            .background(Color.backgroundColor)
    }
}
