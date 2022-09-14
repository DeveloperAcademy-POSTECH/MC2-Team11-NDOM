import Foundation
import SwiftUI

/*
 * 사용 방법:
 
 TextField("", text: $nickName)
     .modifier(PlaceholderStyle(showPlaceHolder: nickName.isEmpty, placeholder: "원하는 닉네임을 정해주세요!"))
     .foregroundColor(Color.white)
 
 이렇게 붙여야함, .foregroundColor 에서 원하는 색으로 바꾸면 됨
 */

// MARK: Placeholder color change modifier
struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .padding(.horizontal, 7)
            }
            content
                .foregroundColor(Color.white)
                .padding(5)
        }
    }
}
