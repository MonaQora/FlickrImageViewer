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
    
    var imageURL: URL?

    override func viewDidLoad() {
      if let imageURL = imageURL {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageURL)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
    }
}

extension ZoomingPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
