//
//  NoteFoodView.swift
//  GilCat
//
//  Created by KYUBO A. SHIM on 2022/06/12.
//

import SwiftUI

struct NoteFood: View {
    
    @EnvironmentObject var catInfo: InfoToNote
    @Environment(\.presentationMode) var presentation

    init() {
        Theme.navigationBarColors(background: .systemFill, titleColor: .white)
    }
    
    var body: some View {
        ZStack {
            Color("BackGroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                infoText(Text: "※ 사료 이름과 시간을 선택해서 수정해주세요.")
                Spacer()
                ZStack {
                    getfoodName(name: catInfo.dietInfo.name)
                    Spacer()
                    HStack {
                        Spacer()
                            .frame(width: 300)
                        // MARK: 수정 뷰로 넘어가기
                        NavigationLink(destination: NoteFoodEdit()) {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFit()
                                .font(.largeTitle.weight(.heavy))
                                .frame(width: 20, height: 20)
                                .foregroundColor(.teal)
                                .opacity(0.7)
                        }
                    }
                }
                Image("foodBowl")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
                // MARK: 커스텀 피커 뷰
                GilCatTimePicker(hourEx: $catInfo.dietInfo.timeIndex)
                HStack(spacing: 15) {
                    foodPercentage(amount: .less)
                    foodPercentage(amount: .mid)
                    foodPercentage(amount: .full)
                }
                Spacer()
                createFood()
            }
            .navigationTitle("급식 입력")
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .onTapGesture {
                            catInfo.dietInfo.updatedtime = Date().toString()
                            self.presentation.wrappedValue.dismiss()
                        }
                }
            }
        }
    }
    
    // MARK: 사료 이름 받아오기
    @ViewBuilder
    private func getfoodName(name tenName: String) -> some View {
        
        if catInfo.dietInfo.name.count <= 10 {
            Text(tenName.prefix(10))
                .font(.system(size: 28, weight: .heavy))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 260, height: 100)
                .padding(.bottom, -5)
        } else if catInfo.dietInfo.name.count > 10 {
            VStack {
                Text(tenName.prefix(10))
                    .font(.system(size: 28, weight: .heavy))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 260, height: 50)
                    .padding(.bottom, -25)
                Text((tenName.suffix(tenName.count - 10)))
                    .font(.system(size: 28, weight: .heavy))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 260, height: 50)
            }
            
        }
    }
    
    // MARK: 빠져나가기
    @ViewBuilder
    private func createFood() -> some View {
        Button {
            catInfo.dietInfo.updatedtime = Date().toString()
            self.presentation.wrappedValue.dismiss()
        } label: {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/12, alignment: .center)
                .cornerRadius(20)
                .foregroundColor(Color("ButtonColor"))
                .overlay {
                    Text("등록 완료")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
        }
    }
    
    // MARK: 첫 안내 뷰
    @ViewBuilder
    private func infoText(Text text: String) -> some View {
        Text(text)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
            .opacity(0.6)
            .padding(.top, 15)
    }
    
    // MARK: 급식량 선택
    @ViewBuilder
    private func foodPercentage(amount: Amount) -> some View {
        Text(amount.str)
            .font(.system(size: 22, weight: .heavy))
            .foregroundColor(.white)
            .opacity(0.6)
            .frame(width: 70, height: 70, alignment: .center)
            .overlay {
                if catInfo.dietInfo.amount != amount {
                    RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 6)
                                .frame(width: 90, height: 90)
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color("ButtonColor"))
                    
                    Text(amount.str)
                        .font(.system(size: 22, weight: .heavy))
                        .foregroundColor(.white)
                }
            }
            .onTapGesture {
                withAnimation {
                    catInfo.dietInfo.amount = amount
                }
            }
            .padding()
    }
}

struct NoteFood_Previews: PreviewProvider {
    static var previews: some View {
        NoteFood()
            .environmentObject(InfoToNote())
    }
}
