import SwiftUI

struct ComponentsTestView: View {
    var body: some View {
        CustomTitle().customTitle(titleText: "히히히히히히")
    }
}

struct ComponentsTestView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsTestView()
    }
}
