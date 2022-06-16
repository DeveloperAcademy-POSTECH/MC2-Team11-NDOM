//
//  FirstStart.swift
//  GilCat
//
//  Created by Beone on 2022/06/15.
//

import SwiftUI

struct FirstStart: View {
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true

    var body: some View {
            // 앱 최초 구동 시 전체화면으로 Onboarding 띄우기
        ZStack{
        if isFirstLaunching{
                Onboarding(isFirstLaunching: $isFirstLaunching)
            }
        }
    }
}
