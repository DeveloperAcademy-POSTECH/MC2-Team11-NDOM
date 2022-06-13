import SwiftUI

@main
struct GilCatApp: App {
    var catInfo: GilCatInfoList = GilCatInfoList()
    
    var body: some Scene {
        WindowGroup {
            RegisterStart().environmentObject(GilCatInfoList())
        }
    }
}
