import SwiftUI

struct ComponentsTestView: View {
    var body: some View {
        Color.backgroundColor.ignoresSafeArea()
        CustomPicker(firstSelect: "첫번째", secondSelect: "두번째", isClick: false)
    }
}

struct ComponentsTestView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsTestView()
    }
}
