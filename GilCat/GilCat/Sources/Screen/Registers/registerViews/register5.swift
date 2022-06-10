import SwiftUI

struct register5: View {
    var body: some View {
        ZStack{
        Color.backgroundColor.ignoresSafeArea()
        
            VStack {
                HStack {
                    CustomTitle(titleText: "나이").padding([.top, .leading])
                    Spacer()
                }
                CustomTextField(placeHolder: "나비는 몇 살인가요?").padding([.leading, .bottom]).keyboardType(.numberPad)
                	
                Spacer().frame(height: 300)
                
                HStack {
                    //여기에 navigationLink로 버튼처럼 만들어야 하지않나?
                    CustomButton()
                }
            }
        }
    }
}

struct register5_Previews: PreviewProvider {
    static var previews: some View {
        register5()
    }
}
