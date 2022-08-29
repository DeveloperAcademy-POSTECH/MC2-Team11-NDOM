//
//  HomeViewModel.swift
//  GilCat
//
//  Created by Woody on 2022/06/14.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    static let instance = HomeViewModel()
    
    @Published var newCatRegisterViewModel: NewCatRegisterViewModel = NewCatRegisterViewModel()
    @Published var catLists: [GilCatInfo] = []
    @Published var selectedIdx: Int = -1
    @Published var isCatPopup: Bool = false
    @Published var isNewCatRegisterPopup: Bool = false
    
    func catImageButtonTapped(_ index: Int) {
        selectedIdx = index
        print("snackCount!!")
        for cat in catLists {
            print(cat.snackCount)
        }
        withAnimation {
            isCatPopup = true
        }
    }
    
    func boxImageButtonTapped() {
        isNewCatRegisterPopup = true
    }
}
