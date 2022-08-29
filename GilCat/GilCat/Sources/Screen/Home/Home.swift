//
//  Home.swift
//  GilCat
//
//  Created by Woody on 2022/06/14.
//

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
                    .onAppear {
                        
                    }
                
                if $viewModel.isCatPopup.wrappedValue {
                    CatSelectPopup(isPopup: $viewModel.isCatPopup,
                                   cat: $viewModel.selectedCat)
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
