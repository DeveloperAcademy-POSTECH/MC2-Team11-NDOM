import SwiftUI

struct CustomTitle: View {
    @State var titleText: String = ""
    
    func customTitle(titleText: String) -> some View {
        return HStack {
            ZStack {
                if titleText.count == 1 {
                    Image("oneLetter").offset(x: 11, y: 11).opacity(0.85)
                        
                    Text("\(titleText)").bold().foregroundColor(.white).font(.system(size: 40)).padding()
                } else if titleText.count == 2 {
                    Image("twoLetter").offset(x: 11, y: 11).opacity(0.85)
                        
                    Text("\(titleText)").bold().foregroundColor(.white).font(.system(size: 40)).padding()
                } else if titleText.count == 3 {
                    Image("threeLetter").offset(x: 11, y: 11).opacity(0.85)
                        
                    Text("\(titleText)").bold().foregroundColor(.white).font(.system(size: 40)).padding()
                } else if titleText.count == 4 {
                    Image("fourLetter").offset(x: 11, y: 11).opacity(0.85)
                        
                    Text("\(titleText)").bold().foregroundColor(.white).font(.system(size: 40)).padding()
                } else if titleText.count == 5 {
                    Image("fiveLetter").offset(x: 11, y: 11).opacity(0.85)
                        
                    Text("\(titleText)").bold().foregroundColor(.white).font(.system(size: 40)).padding()
                } else if titleText.count > 5 {
                    Image("twoLine").offset(x: 11, y: 11).opacity(0.85)
                        
                    Text("\(titleText)").bold().foregroundColor(.white).font(.system(size: 40)).padding()
                }
            }
        }
    }
    var body: some View {
        customTitle(titleText: titleText)
        }
    }

struct CustomTitle_Previews: PreviewProvider {
    static var previews: some View {
        CustomTitle()
    }
}
