//
//  DateExtension.swift
//  GilCat
//
//  Created by 김동락 on 2022/08/31.
//

import SwiftUI

extension Date {
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
}
