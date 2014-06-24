//
//  Album.swift
//  SwiftForm
//
//  Created by Jordan Rose on 6/9/14.
//  Copyright (c) 2014 Jordan Rose. All rights reserved.
//

import UIKit

class Album {
    var title: String?
    var price: String?
    var thumbnailImageURL: String?
    var largeImageURL: String?
    var itemURL: String?
    var artistURL: String?
    var collectionId: Int?
    
    init(name: String!, price: String!, thumbnailImageURL: String!, largeImageURL: String!, itemURL: String!, artistURL: String!, collectionId: Int?) {
        self.title = name
        self.price = price
        self.thumbnailImageURL = thumbnailImageURL
        self.largeImageURL = largeImageURL
        self.itemURL = itemURL
        self.artistURL = artistURL
        self.collectionId = collectionId
    }
}
