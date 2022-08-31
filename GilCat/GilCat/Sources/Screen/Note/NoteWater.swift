//
//  NoteWaterView.swift
//  GilCat
//
//  Created by KYUBO A. SHIM on 2022/06/12.
//

import SwiftUI

struct NoteWater: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var catInfo: InfoToNote
    
    init() {
        Theme.navigationBarColors(background: .systemFill, titleColor: .white)
    }
    
    var body: some View {
        ZStack {
            Color("BackGroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                infoText(Text: "※ 시간을 선택해서 수정해주세요.")
                Spacer()
                HStack(alignment: .lastTextBaseline, spacing: 15) {
                    getwaterName(name: "물")
                }
                Image("waterBowl")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
                // custom picker View
                GilCatTimePicker(hourEx: $catInfo.waterInfo.timeIndex)
                HStack(spacing: 15) {
                    waterPercentage(amount: .less)
                    waterPercentage(amount: .mid)
                    waterPercentage(amount: .full)
                }
                .padding()
                Spacer()
                createWater()
                
            }
            .navigationTitle("급수 입력")
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .onTapGesture {
                            catInfo.waterInfo.updatedtime = Date().toString()
                            self.presentation.wrappedValue.dismiss()
                        }
                }
            }
        }
    }
    
    // MARK: 물 텍스트
    @ViewBuilder
    private func getwaterName(name foodName: String) -> some View {
        Text(foodName)
            .font(.system(size: 30, weight: .heavy))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .frame(width: 260, height: 100)
    }
    
    // MARK: 빠져나가기
    @ViewBuilder
    private func createWater() -> some View {
        Button {
            catInfo.waterInfo.updatedtime = Date().toString()
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
    
    // MARK: 급수량 선택
    @ViewBuilder
    private func waterPercentage(amount: Amount) -> some View {
        Text(amount.str)
            .font(.system(size: 22, weight: .heavy))
            .foregroundColor(.white)
            .opacity(0.6)
            .frame(width: 70, height: 70, alignment: .center)
            .overlay {
                if amount != catInfo.waterInfo.amount {
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
                    catInfo.waterInfo.amount = amount
                }
            }
            .padding()
    }
}

struct NoteWater_Previews: PreviewProvider {
    static var previews: some View {
        NoteWater().environmentObject(InfoToNote())
    }
}
