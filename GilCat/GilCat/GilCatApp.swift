import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct GilCatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel: HomeViewModel = HomeViewModel.instance
    @StateObject var newCatModel: NewCatRegisterViewModel = NewCatRegisterViewModel()
    var body: some Scene {
        WindowGroup {
            Home(viewModel: viewModel)
        }
    }
}
