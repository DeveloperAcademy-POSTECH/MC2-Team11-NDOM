import SwiftUI

struct CustomTextField: View {
    @State var catName : String = ""
    @State var placeHolder : String = ""
    
    private func customTextField() -> some View {
        return ZStack{
            if catName.isEmpty {
                HStack {
                    Text("\(placeHolder)").foregroundColor(.gray).padding()
                
                Spacer()
                }
            }
            TextField("",text: $catName).padding()
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
