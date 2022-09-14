import SwiftUI

struct NoteProfile: View {
    @EnvironmentObject var catInfo: InfoToNote
    
    var body: some View {
        ZStack {
            Color("BackGroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 15) {
                Spacer()
                HStack(spacing: 20) {
                    getCatName(Text: catInfo.name)
                    getTNRInfo(TNR: catInfo.neutralized)
                }
                textProfile()
                    .padding(.vertical, 10)
            }
            .padding(.top, 30)
        }
        .frame(width: .infinity, height: 160)
    }
    
    // MARK: 고양이 이름 표시
    @ViewBuilder
    private func getCatName(Text text: String) -> some View {
        Text(text)
            .font(.system(size: 30, weight: .heavy))
            .foregroundColor(.white)
    }
    
    // MARK: TNR 정보 표시
    @ViewBuilder
    private func getTNRInfo(TNR checkTNR: Bool) -> some View {
        RoundedRectangle(cornerRadius: 21)
            .frame(width: 74, height: 40)
            .foregroundColor(checkTNR ? Color(.red).opacity(0.7) : Color("ButtonColor") )
            .overlay {
                Text(checkTNR ? "중성화X" : "중성화")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
            }
    }
    
    // MARK: 프로필 상세 내용
    @ViewBuilder
    private func textProfile() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("나이 ")
                    .font(.title3)
                    .foregroundColor(.white)
                    .opacity(0.7)
                Text(catInfo.age)
                    .bold()
                    .font(.title3)
                    .foregroundColor(Color.buttonColor)
                    .opacity(0.9)
            }
            .padding(.leading, 5)
            .padding(.top, -5)
            
            HStack {
                Text("성별 ")
                    .font(.title3)
                    .foregroundColor(.white)
                    .opacity(0.7)
                Text(catInfo.gender == .male ? "수컷" : "암컷")
                    .bold()
                    .font(.title3)
                    .foregroundColor(Color.buttonColor)
                    .opacity(0.9)
            }
            .padding(.leading, 5)
            .padding(.top, -5)
            
            HStack {
                Text("  종   ")
                    .font(.title3)
                    .foregroundColor(.white)
                    .opacity(0.7)
                Text(catInfo.type)
                    .bold()
                    .font(.title3)
                    .foregroundColor(Color.buttonColor)
                    .opacity(0.9)
            }
            .padding(.leading, 5)
            .padding(.top, -5)

        }
    }
}

struct NoteProfile_Previews: PreviewProvider {
    static var previews: some View {
        NoteProfile()
            .environmentObject(InfoToNote())
    }
}
