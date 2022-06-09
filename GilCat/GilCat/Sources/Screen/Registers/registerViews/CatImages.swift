//
//  CatImages.swift
//  GilCat
//
//  Created by 김동락 on 2022/06/09.
//

import SwiftUI

enum CatColor: CaseIterable {
    case gray, brown, peach, pink, red, orange, gold, green, emerald, sky, navy, purple
    var color: Color {
        switch self {
        case .gray:
            return Color("cat_gray")
        case .brown:
            return Color("cat_brown")
        case .peach:
            return Color("cat_peach")
        case .pink:
            return Color("cat_pink")
        case .red:
            return Color("cat_red")
        case .orange:
            return Color("cat_orange")
        case .gold:
            return Color("cat_gold")
        case .green:
            return Color("cat_green")
        case .emerald:
            return Color("cat_emerald")
        case .sky:
            return Color("cat_sky")
        case .navy:
            return Color("cat_navy")
        case .purple:
            return Color("cat_purple")
        }
    }
    var group: [String] {
        switch self {
        case .gray:
            return CatImages.cats[0]
        case .brown:
            return CatImages.cats[1]
        case .peach:
            return CatImages.cats[2]
        case .pink:
            return CatImages.cats[3]
        case .red:
            return CatImages.cats[4]
        case .orange:
            return CatImages.cats[5]
        case .gold:
            return CatImages.cats[6]
        case .green:
            return CatImages.cats[7]
        case .emerald:
            return CatImages.cats[8]
        case .sky:
            return CatImages.cats[9]
        case .navy:
            return CatImages.cats[10]
        case .purple:
            return CatImages.cats[11]
        }
    }
}

class CatImages {
    static let cats = [
        [
            "cat_gray_1",
            "cat_gray_2",
            "cat_gray_3",
            "cat_gray_4",
            "cat_gray_5",
            "cat_gray_6",
            "cat_gray_7",
            "cat_gray_8"
        ],
        [
            "cat_brown_1",
            "cat_brown_2",
            "cat_brown_3",
            "cat_brown_4",
            "cat_brown_5",
            "cat_brown_6",
            "cat_brown_7",
            "cat_brown_8"
        ],
        [
            "cat_peach_1",
            "cat_peach_2",
            "cat_peach_3",
            "cat_peach_4",
            "cat_peach_5",
            "cat_peach_6",
            "cat_peach_7",
            "cat_peach_8"
        ],
        [
            "cat_pink_1",
            "cat_pink_2",
            "cat_pink_3",
            "cat_pink_4",
            "cat_pink_5",
            "cat_pink_6",
            "cat_pink_7",
            "cat_pink_8"
        ],
        [
            "cat_red_1",
            "cat_red_2",
            "cat_red_3",
            "cat_red_4",
            "cat_red_5",
            "cat_red_6",
            "cat_red_7",
            "cat_red_8"
        ],
        [
            "cat_orange_1",
            "cat_orange_2",
            "cat_orange_3",
            "cat_orange_4",
            "cat_orange_5",
            "cat_orange_6",
            "cat_orange_7",
            "cat_orange_8"
        ],
        [
            "cat_gold_1",
            "cat_gold_2",
            "cat_gold_3",
            "cat_gold_4",
            "cat_gold_5",
            "cat_gold_6",
            "cat_gold_7",
            "cat_gold_8"
        ],
        [
            "cat_green_1",
            "cat_green_2",
            "cat_green_3",
            "cat_green_4",
            "cat_green_5",
            "cat_green_6",
            "cat_green_7",
            "cat_green_8"
        ],
        [
            "cat_emerald_1",
            "cat_emerald_2",
            "cat_emerald_3",
            "cat_emerald_4",
            "cat_emerald_5",
            "cat_emerald_6",
            "cat_emerald_7",
            "cat_emerald_8"
        ],
        [
            "cat_sky_1",
            "cat_sky_2",
            "cat_sky_3",
            "cat_sky_4",
            "cat_sky_5",
            "cat_sky_6",
            "cat_sky_7",
            "cat_sky_8"
        ],
        [
            "cat_navy_1",
            "cat_navy_2",
            "cat_navy_3",
            "cat_navy_4",
            "cat_navy_5",
            "cat_navy_6",
            "cat_navy_7",
            "cat_navy_8"
        ],
        [
            "cat_purple_1",
            "cat_purple_2",
            "cat_purple_3",
            "cat_purple_4",
            "cat_purple_5",
            "cat_purple_6",
            "cat_purple_7",
            "cat_purple_8"
        ]
    ]
}
