//
//  HomeContainer.swift
//  GilCat
//
//  Created by Woody on 2022/06/14.
//

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
        }
        return homeViewContoller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}
