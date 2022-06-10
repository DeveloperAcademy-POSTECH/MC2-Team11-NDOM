import SwiftUI

struct CustomTextField: View {

    @State var catInfo: String = ""
    @State var placeHolder: String = ""
    
    private func customTextField() -> some View {
        return ZStack {
            if catInfo.isEmpty {
                HStack {
                    Text("\(placeHolder)").foregroundColor(.gray).padding()
                
                Spacer()
                }
            }
            TextField("",text: $catInfo).padding()
        }
    }

    var body: some View {
        customTextField()
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField()
    }
}
