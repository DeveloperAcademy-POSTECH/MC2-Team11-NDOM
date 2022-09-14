import Combine
import Foundation

// MARK: 한 마리 고양이 정보 객체
struct GilCatInfo: Codable {
    var userId: [String]            = []                                // 공유하는 사람들
    var catCode: String             = ""                                // 합치기 할때 쓸 코드
    var index: Int                  = 0                                 // 인덱스
    var name: String                = ""                                // 이름
    var age: String                 = ""                                // 나이
    var gender: GilCatGender        = .male                             // 성별
    var neutralized: Bool           = true                              // 중성화 여부
    var type: String                = ""                                // 종
    var avatarColor: GilCatColor    = .gray                             // 아바타 색깔
    var avatarBodyIndex: Int        = 0                                 // 아바타 몸
    var imageName: String {                                             // 아바타 이미지
        return avatarColor.group[avatarBodyIndex]
    }
    var dietInfo: DietInfo          = .initCat
    var waterInfo: WaterInfo        = .initCat
    var snackInfo: SnackInfo       = .initSnack
    var healthTagInfo: [HealthTag]  = []
    var memoInfo: [MemoInfo]        = []
    var gilCatMapInformation: GilCatMapCase = .none
    var removed                     = false
    
    enum CodingKeys: String, CodingKey {
        case userId
        case catCode
        case index
        case name
        case age
        case gender
        case neutralized
        case type
        case avatarColor
        case avatarBodyIndex
        case dietInfo
        case waterInfo
        case snackInfo
        case healthTagInfo
        case memoInfo
        case gilCatMapInformation
        case removed
    }
    
    func merge(other: GilCatInfo) -> GilCatInfo {
        var mergedCat = other

        mergedCat.userId += self.userId
        mergedCat.healthTagInfo += self.healthTagInfo
        mergedCat.memoInfo += self.memoInfo
        
        if mergedCat.dietInfo.updatedtime.isEmpty && !self.dietInfo.updatedtime.isEmpty {
            mergedCat.dietInfo.updatedtime = self.dietInfo.updatedtime
        } else if !mergedCat.dietInfo.updatedtime.isEmpty && !self.dietInfo.updatedtime.isEmpty {
            let compareDiet = mergedCat.dietInfo.updatedtime.toDate().compare(self.dietInfo.updatedtime.toDate())
            if compareDiet == .orderedAscending {
                mergedCat.dietInfo = self.dietInfo
            }
        }
        
        if mergedCat.waterInfo.updatedtime.isEmpty && !self.waterInfo.updatedtime.isEmpty {
            mergedCat.waterInfo.updatedtime = self.waterInfo.updatedtime
        } else if !mergedCat.dietInfo.updatedtime.isEmpty && !self.dietInfo.updatedtime.isEmpty {
            let compareWater = mergedCat.waterInfo.updatedtime.toDate().compare(self.waterInfo.updatedtime.toDate())
            if compareWater == .orderedAscending {
                mergedCat.waterInfo = self.waterInfo
            }
        }
        
        return mergedCat
    }

}

extension GilCatInfo {
    static let empty = GilCatInfo(userId: [],
                                  catCode: "",
                                  index: 0,
                                  name: "",
                                  age: "",
                                  gender: .male,
                                  neutralized: true,
                                  type: "",
                                  avatarColor: .gold,
                                  avatarBodyIndex: 4,
                                  dietInfo: DietInfo.initCat,
                                  waterInfo: WaterInfo.initCat,
                                  snackInfo: SnackInfo.initSnack,
                                  healthTagInfo: [],
                                  memoInfo: [],
                                  gilCatMapInformation: .seventh,
                                  removed: false)
}

// MARK: 먹이 정보
struct DietInfo: Codable {
    var name: String
    var timeIndex: Int
    var time: String {
        GilCatTimePicker.testTime[timeIndex]
    }
    var amount: Amount
    var updatedtime: String
    
    static let initCat: DietInfo = DietInfo(name: "-", timeIndex: 28, amount: .mid, updatedtime: "")
    
    enum CodingKeys: String, CodingKey {
        case name
        case timeIndex
        case amount
        case updatedtime
    }
}

// MARK: 물 정보
struct WaterInfo: Codable {
    var timeIndex: Int
    var time: String {
        GilCatTimePicker.testTime[timeIndex]
    }
    var amount: Amount
    var updatedtime: String
    
    static let initCat: WaterInfo = WaterInfo(timeIndex: 28, amount: .mid, updatedtime: "")
    
    enum CodingKeys: String, CodingKey {
        case timeIndex
        case amount
        case updatedtime
    }
}

// MARK: 간식 정보
struct SnackInfo: Codable {
    var snackCount: Int
    var updatedtime: String
    
    static let initSnack: SnackInfo = SnackInfo(snackCount: 0, updatedtime: Date().toString(format: "yyyy-MM-dd"))
    
    enum CodingKeys: String, CodingKey {
        case snackCount
        case updatedtime
    }
}

// MARK: 메모 정보 
struct MemoInfo: Hashable, Codable {
    var date: String
    var time: String
    var content: String
    var userId: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case time
        case content
        case userId
    }
}

// MARK: 태그 정보
struct HealthTag: Hashable, Codable {
    init(_ text: String, isClicked: Bool = true) {
        self.text = text
        self.isClicked = isClicked
    }
    var id = UUID().uuidString
    var text: String
    var isClicked = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case isClicked
    }
}

enum Amount: Codable {
    case full
    case mid
    case less

    var str: String {
        switch self {
        case .full:
            return "100%"
        case .mid:
            return "50%"
        case .less:
            return "25%"
        }
    }
}

enum GilCatGender: String, Codable {
    case male
    case female
}
