//
//  CodeTool.swift
//  GilCat
//
//  Created by 김동락 on 2022/08/30.
//

import Foundation
import SwiftUI

class CodeTool {
    static let instance = CodeTool()
    private let charList = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    private let numList = "0123456789"
    
    // 랜덤한 사용자 아이디 생성하거나 기존에 생성했던거 가져오기
    func getUserId() -> String {
        let value = UserDefaults.standard.string(forKey: "UserId")
        if let value = value {
            return value
        } else {
            let randomId = (0 ..< 10).map { _ in charList.randomElement()! }
            let result = String(randomId)
            UserDefaults.standard.set(result, forKey: "UserId")
            return result
        }
    }

    // 랜덤한 고양이 코드 생성
    func makeRandomCode() -> String {
        let randomCode = (0 ..< 6).map { _ in numList.randomElement()! }
        let result = String(randomCode)
        return result
    }
}
