import SwiftUI

enum GilCatSizeInformation {
    case small
    case medium
    case big
    
    var size: CGSize {
        switch self {
        case .small:
            return CGSize(width: 60, height: 60)
        case .medium:
            return CGSize(width: 70, height: 70)
        case .big:
            return CGSize(width: 80, height: 80)
        }
    }
}
