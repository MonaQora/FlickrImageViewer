//
//  FlickrPhotosService.swift
//  FlickrImageViewer
//
//  Created by Mona Qora on 11/2/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

let apiKey = "b7f196710b73e1c80f610f5ff450c281"
let noDataMessage = "NO Data Returned, try another search key."

func fetchFlickrSerachResults(searchKey:String, taskCallback: @escaping (Bool, Error?, FlickrPhotosModel?) -> ())
{
    if let searchKey = searchKey.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) {
        let requestURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(searchKey))&per_page=24&format=json&nojsoncallback=1"
        
        AF.request(requestURL).validate().responseObject { (response: AFDataResponse<FlickrPhotosModel>) in
            switch(response.result) {
            case .success(_):
                taskCallback(true, nil, response.value)
                break
                
            case .failure(_):
                print("** Error while fetching url: \(response.result) **")
                taskCallback(false, response.error, nil)
                break
            }
        }
    }
}
