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
            print("이미 존재하는 아이디: \(value)")
            return value
        } else {
            let randomId = (0 ..< 10).map { _ in charList.randomElement()! }
            let result = String(randomId)
            print("새로 만든 아이디: \(result)")
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
    
    // 고양이 코드들 가져오기
    func getCatCodes() -> [String] {
        let value = UserDefaults.standard.stringArray(forKey: "CatCodes")
        if let value = value {
            return value
        } else {
            return []
        }
    }
    
    // 특정 고양이 코드 내부에 저장
    func saveCatCode(code: String) {
        let value = UserDefaults.standard.stringArray(forKey: "CatCodes")
        if let value = value {
            print("이미 존재하는 고양이 코드 리스트: \(value)")
            var originCodeList = value
            originCodeList.append(code)
            UserDefaults.standard.set(originCodeList, forKey: "CatCodes")
        } else {
            let newCodeList = [code]
            UserDefaults.standard.set(newCodeList, forKey: "CatCodes")
        }
    }
}
