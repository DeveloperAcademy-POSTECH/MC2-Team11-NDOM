import SwiftUI

struct GilCatTimePicker: View {

    @Binding var hourEx: Int
    static let testTime = ["00:00", "00:30", "01:00", "01:30", "02:00", "02:30", "03:00", "03:30", "04:00", "04:30", "05:00", "05:30", "06:00", "06:30", "07:00", "07:30", "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30", "24:00"]
    
    var body: some View {
        ZStack {
            Color("BackGroundColor")
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                                
                Picker("time", selection: $hourEx) {
                    ForEach(0..<49) {
                        Text("\(GilCatTimePicker.testTime[$0])")
                            .font(.system(size: 30, weight: .heavy))
                            .foregroundColor(Color("ButtonColor"))
                    }
                }
                .pickerStyle(.wheel)
                .labelsHidden()
            }
        }
        .frame(width: 400, height: 200, alignment: .center)
    }
}

// struct GilCatTimePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        GilCatTimePicker()
//    }
// }
