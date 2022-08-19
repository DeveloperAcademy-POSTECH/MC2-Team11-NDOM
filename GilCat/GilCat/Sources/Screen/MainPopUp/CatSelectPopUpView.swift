//
//  CatSelect_Popup.swift
//  GilCat
//
//  Created by Beone on 2022/06/08.
//

import SwiftUI

struct CatSelectPopup: View {    @State var inviteCode = "123456"
    @State var isInviting = false
    @State var openNote: Bool = false
    @State var openCode: Bool = false

    @Binding var isPopup: Bool
    @Binding var cat: GilCatInfo
    
    @StateObject var selectedCat: InfoToNote = InfoToNote()
    
    var body: some View {
        VStack {
            Button {
                withAnimation {isPopup = false}
            } label: {
                Color.clear
            }
            ZStack {
                VStack {
                    HStack(alignment: .center, spacing: 26) {
                        getCatInfo(Image: cat.imageName, name: cat.name)
                        VStack {
                            Button {
                                isPopup = false
                            } label: {
                                closeButton()
                            }
                            Spacer()
                        }
                    }
                    .frame(width: 281, height: 70, alignment: .center)
                    .padding(30)
                    
                    VStack(alignment: .center, spacing: 16) {
// MARK: 기록장 버튼
                        Button {
                            openNote.toggle()
                        } label: {
                            GilCatMainButton(text: "기록장", foreground: .white, background: .constant(.buttonColor)).frame(width: 281)
                        }
                        .fullScreenCover(isPresented: $openNote) {
                            Note().environmentObject(selectedCat)
                        }
                        
                        HStack(alignment: .center, spacing: 16) {
// MARK: 초대하기 버튼
                            Button {
                                self.isInviting = true
                            } label: {
                                getInviteButton(inviteCode: inviteCode, isInviting: isInviting)
                                
                            }
// MARK: 합치기 기능
                            Button {
                                openCode.toggle()
                            } label: {
                                GilCatMainButton(text: "합치기", foreground: .white, background: .constant(.mainBlack)).frame(width: 130)
                            }
                            .alert("준비중입니다", isPresented: $openCode) {
                                Button("확인") {}
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(Color.mainBlue)
            .cornerRadius(30)
            .padding(.horizontal, 16)
        }
    }
}

@ViewBuilder
private func getCatInfo(Image catImage: String, name: String) -> some View {
    HStack{
    Image(catImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding()
        .frame(width: 90, height: 90, alignment: .center)
        .background(Color("PickerColor"))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.top, 10)
    
    Text(name)
        .frame(width: 115, height: 40, alignment: .leading)
        .padding(.top, 10)
        .foregroundColor(Color.white)
        .font(.system(size: 30, weight: .heavy))
        .minimumScaleFactor(0.2)
    }
}

@ViewBuilder
private func getInviteButton(inviteCode: String, isInviting: Bool) -> some View {
    Color.mainBlack
        .frame(width: 130, height: 60, alignment: .center)
        .cornerRadius(20)
        .overlay(isInviting ? Text(inviteCode).foregroundColor(.mainOrange) : Text("초대하기").foregroundColor(.white).font(.system(size: 20, weight: .heavy)))
}

//@ViewBuilder
//private func closeButton (isPopup abc: Bool) -> some View{
//    Button {
//        abc = false
//    } label: {
//        Image(systemName: "xmark.app.fill")
//            .resizable()
//            .frame(width: 25, height: 25)
//            .foregroundColor(Color.white)
//    }
//}

@ViewBuilder
private func closeButton()-> some View{
    Image(systemName: "xmark.app.fill")
        .resizable()
        .frame(width: 25, height: 25)
        .foregroundColor(Color.white)
}

struct CatSelectPopup_Previews: PreviewProvider {
    static var previews: some View {
        CatSelectPopup(isPopup: .constant(true), cat: .constant(GilCatInfo.empty))
    }
}
