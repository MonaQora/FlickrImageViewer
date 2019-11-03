//
//  PhotoDetailsViewController.swift
//  FlickrImageViewer
//
//  Created by Mona Qora on 11/2/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import UIKit

class PhotoDetailsViewController:UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    var photoItem = FlickrPhotoItem()
    var imageURL:URL?
    
    private let segueIdentifier = "zooming"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Details"
        titleLbl.text = photoItem.title
        if let url = photoItem.photoLargeUrl {
            imageURL = url
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageURL)
        }
    }

    @IBAction func openZoomingController(_ sender: AnyObject) {
        self.performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    override open func prepare(for segue: UIStoryboardSegue,
                               sender: Any?) {
        if let id = segue.identifier,
            let zoomedPhotoViewController = segue.destination as? ZoomingPhotoViewController,
            id == segueIdentifier {
            zoomedPhotoViewController.imageURL = imageURL
        }
    }
}
