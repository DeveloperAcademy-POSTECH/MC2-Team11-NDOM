//
//  CustomSubTitle.swift
//  GilCat
//
//  Created by 김동락 on 2022/06/09.
//

import SwiftUI

struct CustomSubTitle: View {
    @State var text: String
    
    var body: some View {
        return Text(text)
            .foregroundColor(Color.white)
            .font(.system(size: 20, weight: Font.Weight.heavy))
    }
}

struct CustomSubTitle_Previews: PreviewProvider {
    static var previews: some View {
        CustomSubTitle(text: "gogogogo")
    }
}
