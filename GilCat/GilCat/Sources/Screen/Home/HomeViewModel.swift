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
    
    @Published var catLists: [GilCatInfo] = [
//        GilCatInfo(name: "제갈현우프로젝트",
//                   age: "2",
//                   gender: .male,
//                   neutralized: true,
//                   type: "페르시안",
//                   avatarColor: .gold,
//                   avatarBodyIndex: 4,
//                   dietInfo: DietInfo.initCat,
//                   waterInfo: WaterInfo.initCat,
//                   snackCount: 0,
//                   healthTagInfo: [],
//                   memoInfo: [],
//                   gilCatMapInformation: .first),
//        GilCatInfo(name: "나비 Dophie",
//                   age: "2",
//                   gender: .male,
//                   neutralized: true,
//                   type: "페르시안",
//                   avatarColor: .gold,
//                   avatarBodyIndex: 4,
//                   dietInfo: DietInfo.initCat,
//                   waterInfo: WaterInfo.initCat,
//                   snackCount: 0,
//                   healthTagInfo: [],
//                   memoInfo: [],
//                   gilCatMapInformation: .second),
//        GilCatInfo(name: "나비 Dophie",
//                   age: "2",
//                   gender: .male,
//                   neutralized: true,
//                   type: "페르시안",
//                   avatarColor: .gold,
//                   avatarBodyIndex: 4,
//                   dietInfo: DietInfo.initCat,
//                   waterInfo: WaterInfo.initCat,
//                   snackCount: 0,
//                   healthTagInfo: [],
//                   memoInfo: [],
//                   gilCatMapInformation: .third),
//        GilCatInfo(name: "나비 Dophie",
//                   age: "2",
//                   gender: .male,
//                   neutralized: true,
//                   type: "페르시안",
//                   avatarColor: .gold,
//                   avatarBodyIndex: 4,
//                   dietInfo: DietInfo.initCat,
//                   waterInfo: WaterInfo.initCat,
//                   snackCount: 0,
//                   healthTagInfo: [],
//                   memoInfo: [],
//                   gilCatMapInformation: .fourth),
//        GilCatInfo(name: "우도",
//                   age: "1",
//                   gender: .male,
//                   neutralized: true,
//                   type: "페르시안",
//                   avatarColor: .emerald,
//                   avatarBodyIndex: 3,
//                   dietInfo: DietInfo.initCat,
//                   waterInfo: WaterInfo.initCat,
//                   snackCount: 0,
//                   healthTagInfo: [],
//                   memoInfo: [],
//                   gilCatMapInformation: .fifth),
//        GilCatInfo(name: "디피",
//                   age: "3",
//                   gender: .male,
//                   neutralized: true,
//                   type: "페르시안",
//                   avatarColor: .navy,
//                   avatarBodyIndex: 2,
//                   dietInfo: DietInfo.initCat,
//                   waterInfo: WaterInfo.initCat,
//                   snackCount: 0,
//                   healthTagInfo: [],
//                   memoInfo: [],
//                   gilCatMapInformation: .sixth),
//        GilCatInfo(name: "디피",
//                   age: "3",
//                   gender: .male,
//                   neutralized: true,
//                   type: "페르시안",
//                   avatarColor: .navy,
//                   avatarBodyIndex: 2,
//                   dietInfo: DietInfo.initCat,
//                   waterInfo: WaterInfo.initCat,
//                   snackCount: 0,
//                   healthTagInfo: [],
//                   memoInfo: [],
//                   gilCatMapInformation: .seventh),
//        GilCatInfo(name: "디피",
//                   age: "3",
//                   gender: .male,
//                   neutralized: true,
//                   type: "페르시안",
//                   avatarColor: .navy,
//                   avatarBodyIndex: 2,
//                   dietInfo: DietInfo.initCat,
//                   waterInfo: WaterInfo.initCat,
//                   snackCount: 0,
//                   healthTagInfo: [],
//                   memoInfo: [],
//                   gilCatMapInformation: .eighth)
//        GilCatInfo(name: "디피",
//                   age: "3",
//                   gender: .male,
//                   neutralized: true,
//                   type: "페르시안",
//                   avatarColor: .navy,
//                   avatarBodyIndex: 2,
//                   dietInfo: DietInfo.initCat,
//                   waterInfo: WaterInfo.initCat,
//                   snackCount: 0,
//                   healthTagInfo: [],
//                   memoInfo: [],
//                   gilCatMapInformation: .),
    ]
    @Published var selectedCat: GilCatInfo = .empty
    @Published var isCatPopup: Bool = false
    @Published var isNewCatRegisterPopup: Bool = false
    
    func catImageButtonTapped(_ index: Int) {
        selectedCat = catLists[index]
        withAnimation {
            isCatPopup = true
        }
    }
    
    func boxImageButtonTapped() {
        isNewCatRegisterPopup = true
    }
}
