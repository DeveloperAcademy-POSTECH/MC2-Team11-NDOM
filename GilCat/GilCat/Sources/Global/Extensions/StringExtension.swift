//
//  StringExtension.swift
//  GilCat
//
//  Created by 김동락 on 2022/08/31.
//

import SwiftUI

extension String {
    func toDate() -> Date { // "yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return Date()
        }
    }
}
