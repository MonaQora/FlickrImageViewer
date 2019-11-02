//
//  FlickrImgURL+URL.swift
//  FlickrImageViewer
//
//  Created by Mona Qora on 11/2/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import UIKit

enum PhotoSizeNeeded {
    case small
    case large
}

extension URL {
    static func flickrPhotoURL(photoItem: FlickrPhotoItem, photoSizeNeeded: PhotoSizeNeeded = .small) -> URL? {
        let returnURL:URL?
        var photoSize = String()
        switch photoSizeNeeded {
        case .small:
            photoSize = "m"
        case .large:
            photoSize = "b"
        }
        returnURL =  URL(string: "https://farm\(photoItem.farm ?? 0).staticflickr.com/\(photoItem.server ?? "")/\(photoItem.photoID ?? "")_\(photoItem.secret ?? "")_\(photoSize).jpg")
        return returnURL
    }
}
