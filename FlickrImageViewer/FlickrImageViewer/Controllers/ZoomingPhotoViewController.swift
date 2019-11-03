//
//  ZoomingPhotoViewController.swift
//  FlickrImageViewer
//
//  Created by Mona Qora on 11/2/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import UIKit
import Kingfisher

class ZoomingPhotoViewController:UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    var photoName: String?
    var imageURL: URL?

    private var zoomingPhotoViewModel = ZoomingPhotoViewModel()

    override func viewDidLoad() {
      if let imageURL = imageURL {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageURL)
        }
        zoomingPhotoViewModel.size = view.bounds.size
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let minScale = zoomingPhotoViewModel.minScale(bounds: imageView.bounds)
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    fileprivate func updateImageConstraints() {
        let imageFrame = imageView.frame
        let yOffset = zoomingPhotoViewModel.yOffset(frame: imageFrame)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = zoomingPhotoViewModel.xOffset(frame: imageFrame)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
}

extension ZoomingPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateImageConstraints()
    }
}
