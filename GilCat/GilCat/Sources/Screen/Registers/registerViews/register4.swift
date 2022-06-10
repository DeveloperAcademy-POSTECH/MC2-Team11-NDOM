import SwiftUI

struct register4: View {
    @State var isClick: Bool = false
    let male : String = "수컷"
    let female : String = "암컷"
    
//    enum Gender: String, CaseIterable, Identifiable {
//        case 수컷, 암컷
//        var id: Self { self }
//    }
//    @State private var selectedGender: Gender = .수컷
//    init(){
//        UISegmentedControl.appearance().backgroundColor = UIColor(named: "PickerColor" )
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.orange], for: .selected)
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
//    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack {
                HStack {
                    CustomTitle(titleText: "성별").padding([.top, .leading])
                    Spacer()
                }
//                Picker("Gender", selection: $selectedGender) {
//                    ForEach(Gender.allCases) {gender in Text(gender.rawValue.capitalized).bold()}
//                }.pickerStyle(.segmented).frame(width: 350).cornerRadius(30)
//                    .scaledToFit()
//                    .scaleEffect(CGSize(width: 1, height: 1.5))
                
                CustomPicker(firstSelect: "수컷", secondSelect: "암컷", isClick: true)
                //picker로 select된 값들 저장하게 만들어야함
                HStack{
                    CustomTitle(titleText: "중성화 여부").padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing:0))
//                    Text("여부").bold().foregroundColor(.white).font(.system(size: 40))
                    Spacer()
                }
                
                CustomPicker(firstSelect: "⭕️", secondSelect: "❌", isClick: true)
                //picker로 select된 값들 저장하게 만들어야함
                
                Spacer().frame(height: 300)
                CustomButton()
            }
        }
    }
}
struct register4_Previews: PreviewProvider {
    static var previews: some View {
        register4()
    }
}


//ZStack {
//    Rectangle().frame(width: 200, height: 50).cornerRadius(20).foregroundColor(.white).offset(x: isClick ? 100 : -100).onTapGesture {
//        //하얀색과 배경이 같이 클릭될 시 안 움직이게 하는 방법
//    }
//    HStack {
//        Text(male).offset(x: -70).foregroundColor(isClick ? .white : .buttonColor)
//        Text(female).offset(x: 70).foregroundColor(isClick ? .buttonColor : .white)
//    }//클릭시 좌표값에 따라 도형이 안움직이게 해야함
//}.frame(width: 350, height: 50).background(Color.pickerColor).cornerRadius(20).onTapGesture {
//        withAnimation {
//        isClick.toggle()
//        }
//    }
