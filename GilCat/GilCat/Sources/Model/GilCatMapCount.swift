//
//  GilCatCount.swift
//  GilCat
//
//  Created by Woody on 2022/06/14.
//

import Foundation

// MARK: GilCatMapCase
// - 고양이 위치를 가리키는 enum 입니다.
// -
enum GilCatMapCase: Codable {
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    case eighth
    case none
    
    var next: GilCatMapCase {
        switch self {
        case .first:
            return .second
        case .second:
            return .third
        case .third:
            return .fourth
        case .fourth:
            return .fifth
        case .fifth:
            return .sixth
        case .sixth:
            return .seventh
        case .seventh:
            return .eighth
        case .eighth:
            return .none
        case .none:
            return .none
        }
    }
    
    var mapInformation: GilCatMapInformation {
        switch self {
        case .first:
            return .points[0]
        case .second:
            return .points[1]
        case .third:
            return .points[2]
        case .fourth:
            return .points[3]
        case .fifth:
            return .points[4]
        case .sixth:
            return .points[5]
        case .seventh:
            return .points[6]
        case .eighth:
            return .points[7]
        case .none:
            // TODO: 없을 경우 처리해주기.
            return .points[0]
        }
    }
}
