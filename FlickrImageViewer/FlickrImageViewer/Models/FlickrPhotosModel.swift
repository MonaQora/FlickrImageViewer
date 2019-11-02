//
//  FlickrPhotosModel.swift
//  FlickrImageViewer
//
//  Created by Mona Qora on 11/2/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import ObjectMapper

class FlickrPhotosModel: NSObject, Mappable {
  var photos :FlickrPhotoList?
  
  override init() {
      super.init()
  }
  
  convenience required public init?(map: Map) {
      self.init()
  }
  
  public func mapping(map: Map) {
      photos <- map["photos"]
  }
}

class FlickrPhotoList: NSObject, Mappable {
  var photo :[FlickrPhotoItem]?
  
  override init() {
      super.init()
  }
  
  convenience required public init?(map: Map) {
      self.init()
  }
  
  public func mapping(map: Map) {
      photo <- map["photo"]
  }
}

class FlickrPhotoItem: NSObject, Mappable {
  var photoID :String!
  var owner :String?
  var secret :String!
  var server :String!
  var farm :Int!
  var title :String?
  var photoUrl: URL?
  
  init (photoID: String, farm: Int, server: String, secret: String) {
    self.photoID = photoID
    self.farm = farm
    self.server = server
    self.secret = secret
  }
  
  override init() {
      super.init()
  }
  
  convenience required public init?(map: Map) {
      self.init()
  }
  
  public func mapping(map: Map) {
    photoID <- map["id"]
    owner <- map["owner"]
    secret <- map["secret"]
    server <- map["server"]
    farm <- map["farm"]
    title <- map["title"]
  }
}
