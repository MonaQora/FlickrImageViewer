//
//  ZoomingPhotoViewModel.swift
//  FlickrImageViewer
//
//  Created by Mona Qora on 11/2/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import UIKit

class ZoomingPhotoViewModel {
    
    var size = CGSize()
    
    func minScale(bounds: CGRect) -> CGFloat {
        let widthScale = size.width / bounds.width
        let heightScale = size.height / bounds.height
        let minScale = min(widthScale, heightScale)
        return minScale
    }
    
    func xOffset(frame: CGRect) -> CGFloat {
        let xOffset = max(0, (size.width - frame.width) / 2)
        return xOffset
    }
    
    func yOffset(frame: CGRect) -> CGFloat {
        let yOffset = max(0, (size.height - frame.height) / 2)
        return yOffset
    }
}
