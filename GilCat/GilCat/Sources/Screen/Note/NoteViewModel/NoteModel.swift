//
//  NoteViewModel.swift
//  GilCat
//
//  Created by KYUBO A. SHIM on 2022/06/15.
//

import SwiftUI

class InfoToNote: ObservableObject {
    @Published var index: Int                  = 0             // 인덱스
    @Published var name: String                = "마시멜랑"      // 이름
    @Published var age: String                 = "안알랴쥼"      // 나이
    @Published var gender: GilCatGender        = .male         // 성별
    @Published var neutralized: Bool           = true          // 중성화 여부
    @Published var type: String                = "코숏"         // 종
    @Published var avatarColor: GilCatColor    = .gray         // 아바타 색깔
    @Published var avatarBodyIndex: Int        = 0             // 아바타 몸
    @Published var dietInfo: DietInfo          = .initCat      // 사료 정보
    @Published var waterInfo: WaterInfo        = .initCat      // 물 정보
    @Published var snackCount: Int             = 0             // 간식 개수
    @Published var healthTagInfo: [HealthTag]  = []            // 건강 태그
    @Published var memoInfo: [MemoInfo]        = []            // 메모 정보
    
    var imageName: String {                                    // 아바타 이미지
        return avatarColor.group[avatarBodyIndex]
    }
    
    func makeGilCatInfoModel() -> GilCatInfo {
        var gilCatInfo = GilCatInfo()
        gilCatInfo.index = index
        gilCatInfo.name = name
        gilCatInfo.age = age
        gilCatInfo.gender = gender
        gilCatInfo.neutralized = neutralized
        gilCatInfo.type = type
        gilCatInfo.avatarColor = avatarColor
        gilCatInfo.avatarBodyIndex = avatarBodyIndex
        gilCatInfo.dietInfo = dietInfo
        gilCatInfo.waterInfo = waterInfo
        gilCatInfo.snackCount = snackCount
        gilCatInfo.healthTagInfo = healthTagInfo
        gilCatInfo.memoInfo = memoInfo

        return gilCatInfo
    }
    
    func getGilCatInfoModel(gilCat: GilCatInfo) {
        index = gilCat.index
        name = gilCat.name
        age = gilCat.age
        gender = gilCat.gender
        neutralized = gilCat.neutralized
        type = gilCat.type
        avatarColor = gilCat.avatarColor
        avatarBodyIndex = gilCat.avatarBodyIndex
        dietInfo = gilCat.dietInfo
        waterInfo = gilCat.waterInfo
        snackCount = gilCat.snackCount
        healthTagInfo = gilCat.healthTagInfo
        memoInfo = gilCat.memoInfo
    }
}
