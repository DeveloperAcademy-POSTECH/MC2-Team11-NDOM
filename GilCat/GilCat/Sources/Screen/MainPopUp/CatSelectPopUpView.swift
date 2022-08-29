//
//  CatSelect_Popup.swift
//  GilCat
//
//  Created by Beone on 2022/06/08.
//

import SwiftUI

@ViewBuilder
private func getCatImage(Image catImage: String) -> some View {
    Image(catImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding()
        .frame(width: 90, height: 90, alignment: .center)
        .background(Color("PickerColor"))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.top, 10)
}

struct CatSelectPopup: View {
    static let cardWidth: CGFloat = 352
    static let cardHeight: CGFloat = 303
    
    @State var isInviting = false
    @State var inviteCode = "123456"
    @State var openNote: Bool = false
    @State var openCode: Bool = false

    @Binding var isPopup: Bool
    @Binding var catList: [GilCatInfo]
    @Binding var catIdx: Int
    
    @StateObject var selectedCat: InfoToNote = InfoToNote()
    
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    isPopup = false
                }
            } label: {
                Color.clear
            }
            ZStack {
                VStack {
                    HStack(alignment: .center, spacing: 26) {
                        getCatImage(Image: catList[catIdx].imageName)
                        Text(catList[catIdx].name)
                            .frame(width: 115, height: 40, alignment: .center)
                            .padding(.top, 10)
                            .foregroundColor(Color.white)
                            .font(.system(size: 30, weight: .heavy))
                            .minimumScaleFactor(0.2)
//                        Spacer()
                        
                        VStack {
                            Button {
                                isPopup = false
                            } label: {
                                Image(systemName: "xmark.app.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color.white)
                            }
                            Spacer()
                        }
                    }
                    .frame(width: 281, height: 70, alignment: .center)
                    .padding([.leading, .trailing], 30)
                    .padding([.top], 30)
                    .padding(.bottom, 20)
                    
                    VStack(alignment: .center, spacing: 16) {
                        Button {
// MARK: 기록장으로 가는 기능을 여기에
                            openNote.toggle()
                        } label: {
                            Color.mainOrange
                                .frame(width: 281, height: 60)
                                .cornerRadius(20)
                                .overlay(Text("기록장")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .heavy)))
                        }
                        .fullScreenCover(isPresented: $openNote) {
                            Note().environmentObject(selectedCat)
                        }
                        .onChange(of: openNote) { _ in
                            if openNote {
                                selectedCat.name = catList[catIdx].name
                                selectedCat.age = catList[catIdx].age
                                selectedCat.gender = catList[catIdx].gender
                                selectedCat.neutralized = catList[catIdx].neutralized
                                selectedCat.type = catList[catIdx].type
                                selectedCat.imageName = catList[catIdx].imageName
                                selectedCat.dietInfo = catList[catIdx].dietInfo
                                selectedCat.waterInfo = catList[catIdx].waterInfo
                                selectedCat.snackCount = catList[catIdx].snackCount
                                selectedCat.healthTagInfo = catList[catIdx].healthTagInfo
                                selectedCat.memoInfo = catList[catIdx].memoInfo
                            } else {
                                catList[catIdx].dietInfo = selectedCat.dietInfo
                                catList[catIdx].waterInfo = selectedCat.waterInfo
                                catList[catIdx].snackCount = selectedCat.snackCount
                                catList[catIdx].healthTagInfo = selectedCat.healthTagInfo
                                catList[catIdx].memoInfo = selectedCat.memoInfo
                            }
                        }
                        
                        HStack(alignment: .center, spacing: 16) {
                            Button {
// MARK: 초대하기 기능
                                self.isInviting = true
                            } label: {
                                Color.mainBlack
                                    .frame(width: 130, height: 60, alignment: .center)
                                    .cornerRadius(20)
                                    .overlay(isInviting ? Text(inviteCode).foregroundColor(.mainOrange) : Text("초대하기").foregroundColor(.white).font(.system(size: 20, weight: .heavy)))
                            }
                            Button {
// MARK: 합치기 기능
                                openCode.toggle()
                            } label: {
                                Color.mainBlack
                                    .frame(width: 130, height: 60, alignment: .center)
                                    .cornerRadius(20)
                                    .overlay(Text("합치기").foregroundColor(.white).font(.system(size: 20, weight: .heavy)))
                            }
                            .alert("준비중입니다", isPresented: $openCode) {
                                Button("확인") {}
//                            .fullScreenCover(isPresented: $openCode) {
//                                MergeCat(openCode: $openCode)
                            }
                        }
                        
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(Color.mainBlue)
            .cornerRadius(30)
            .padding([.leading, .trailing], 16)
        }
    }
}
//
//struct CatSelectPopup_Previews: PreviewProvider {
//    static var previews: some View {
//        CatSelectPopup(isPopup: .constant(true), cat: .constant(GilCatInfo.empty))
//    }
//}
