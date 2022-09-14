import Foundation
import SwiftUI

/*
 * 사용 방법:
 
        init(){Theme.navigationBarColors(background: .systemFill, titleColor: .white)}
        var body: some View {} ~
 
 위 코드를 View 안에 넣고 원하는 UIColor 의 Color 로 설정해주면 된다.
 */

// MARK: Navigation Bar Color change
class Theme {
    static func navigationBarColors(background: UIColor?, titleColor: UIColor? = nil, tintColor: UIColor? = nil ) {
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
       
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance

        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}
