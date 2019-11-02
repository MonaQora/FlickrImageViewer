//
//  earchFlickrPhotosViewModel.swift
//  FlickrImageViewer
//
//  Created by Mona Qora on 11/2/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Foundation

class searchFlickrPhotosViewModel {
    var searchResults: [FlickrPhotoItem]?
    
    func getListOfPhotots(searchKey: String , completionHandler: @escaping (String?) -> Void)  {
        fetchFlickrSerachResults(searchKey: searchKey, taskCallback: {success,error,result in
            if success {
                if let result = result {
                    self.searchResults = result.photos?.photo
                    if self.searchResults?.count != 0 {
                        for item in self.searchResults! {
                            let photoURL = URL.flickrPhotoURL(photoItem: item)
                            item.photoUrl = photoURL
                        }
                        completionHandler(nil)
                    }
                    else {
                        completionHandler(noDataMessage)
                    }
                }
                else {
                    completionHandler(noDataMessage)
                }
            }
            else {
                completionHandler(error?.localizedDescription)
            }
        })
    }
}
