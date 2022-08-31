//
//  HomeViewController.swift
//  GilCat
//
//  Created by Woody on 2022/06/14.
//

import SwiftUI
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var viewModel: HomeViewModel?
    var imageViewList = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBoxImageView() // 가장 먼저 실행되야하는 함수
        setupScrollView()
        initializeCats()
    }
    
    private func setupBoxImageView() {
        let image = UIImage(named: "boxWithCat")
        let boxImageView = UIImageView(image: image)
        
        contentView.addSubview(boxImageView)
        boxImageView.contentMode = .scaleAspectFit
        boxImageView.frame.size = CGSize(width: GilCatMapInformation.box.size.size.width,
                                         height: GilCatMapInformation.box.size.size.height)
        boxImageView.frame.origin = CGPoint(x: GilCatMapInformation.box.location.xPercent,
                                            y: GilCatMapInformation.box.location.yPercent)
        
        let touchGesture = UITapGestureRecognizer(target: self,
                                               action: #selector(boxImageViewTapped))
        boxImageView.isUserInteractionEnabled = true
        boxImageView.addGestureRecognizer(touchGesture)
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    func updateList() {
        guard let viewModel = viewModel else { return }
        for imgview in imageViewList {
            imgview.removeFromSuperview()
        }
        imageViewList = []
        viewModel.catLists.enumerated().forEach {
            var curCat = $0.element
            switch $0.offset {
            case 0:
                curCat.gilCatMapInformation = .first
            case 1:
                curCat.gilCatMapInformation = .second
            case 2:
                curCat.gilCatMapInformation = .third
            case 3:
                curCat.gilCatMapInformation = .fourth
            case 4:
                curCat.gilCatMapInformation = .fifth
            case 5:
                curCat.gilCatMapInformation = .sixth
            case 6:
                curCat.gilCatMapInformation = .seventh
            case 7:
                curCat.gilCatMapInformation = .eighth
            default:
                break
            }
            self.locateCatToScreen(curCat, $0.offset)
        }
    }
    
    private func initializeCats() {
        guard let viewModel = viewModel else { return }
        FirebaseTool.instance.addListener { index, cat, error in
            if let error = error {
                print("고양이 리스너 에러: \(error)")
            } else {
                if index == -1 {
                    if cat.userId.contains(CodeTool.instance.getUserId()) && !cat.removed {
                        viewModel.catLists.append(cat)
                    }
                } else {
                    var catListIndex = -1
                    for (idx, originCat) in viewModel.catLists.enumerated() where originCat.index == index {
                        catListIndex = idx
                    }
                    if catListIndex != -1 {
                        if cat.removed {
                            viewModel.catLists.remove(at: catListIndex)
                        } else {
                            viewModel.catLists[catListIndex] = cat
                        }
                    } else {
                        viewModel.catLists.append(cat)
                        viewModel.catLists.sort {$0.index < $1.index}
                    }
                }
                self.updateList()
            }
        }
    }
    
    private func locateCatToScreen(_ catInfo: GilCatInfo, _ index: Int ) {
        let catSize = catInfo.gilCatMapInformation.mapInformation.size.size
        let catLocation = catInfo.gilCatMapInformation.mapInformation.location
        
        let catImage = UIImage(named: catInfo.imageName)
        let catImageView = UIImageView(image: catImage)
        imageViewList.append(catImageView)
        contentView.addSubview(catImageView)
        
        catImageView.tag = index
        catImageView.contentMode = .scaleAspectFit
        catImageView.frame.size = CGSize(width: catSize.width,
                                         height: catSize.height)
        catImageView.frame.origin = CGPoint(x: catLocation.xPercent,
                                            y: catLocation.yPercent)
        
        let catTouchGesture = UITapGestureRecognizer(target: self,
                                                     action: #selector(catImageButtonTapped))
        catImageView.isUserInteractionEnabled = true
        catImageView.addGestureRecognizer(catTouchGesture)
    }
    
    @objc private func catImageButtonTapped(gesture: UITapGestureRecognizer) {
        guard let selectedView = gesture.view else { return }
        let viewTagIndex = selectedView.tag
        scrollView.zoom(to: selectedView.frame, animated: true)
        
        viewModel?.catImageButtonTapped(viewTagIndex)
    }
    
    @objc private func boxImageViewTapped(gesture: UITapGestureRecognizer) {
        viewModel?.boxImageButtonTapped()
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
}
