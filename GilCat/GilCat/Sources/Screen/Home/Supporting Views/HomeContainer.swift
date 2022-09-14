import SwiftUI

struct HomeContainer: UIViewControllerRepresentable {
    @ObservedObject var viewModel: HomeViewModel
    @State var myController: HomeViewController?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboardName = String(describing: "HomeViewController")
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: storyboardName)
        guard let homeViewContoller = controller as? HomeViewController else { fatalError() }
        homeViewContoller.viewModel = viewModel
        
        DispatchQueue.main.async {
            myController = homeViewContoller
            viewModel.myController = myController
        }
        return homeViewContoller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}
