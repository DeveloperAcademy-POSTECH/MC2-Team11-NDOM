import SwiftUI

struct Home: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
            ZStack {
                HomeContainer(viewModel: viewModel)
                    .ignoresSafeArea()
                    .fullScreenCover(isPresented: $viewModel.isNewCatRegisterPopup) {
                        RegisterStart(popToRoot: $viewModel.isNewCatRegisterPopup)
                            .environmentObject(viewModel.newCatRegisterViewModel)
                    }
                if $viewModel.isCatPopup.wrappedValue {
                    CatSelectPopup(isPopup: $viewModel.isCatPopup,
                                   catList: $viewModel.catLists, catIdx: $viewModel.selectedIdx)
                }
            }
            .onChange(of: viewModel.isCatPopup) { _ in
                if !viewModel.isCatPopup {
                    viewModel.myController?.zoomOut()
                }
            }
    }
}
/*
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(viewModel: HomeViewModel())
    }
}
*/
