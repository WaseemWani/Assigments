//
//  File.swift
//  Employees World
//
//  Created by Waseem Wani on 21/06/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation

struct GoogleImages: Codable {
    let items: [ImageDetails]?
    
}
extension GoogleImages {
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}

struct ImageDetails: Codable{
    let title: String?
    let link: String?
    let image: ThumbNailImg?
}
extension ImageDetails {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case link = "link"
        case image = "image"
    }
}

struct ThumbNailImg: Codable {
    //let height: Int
    //let width: Int
    let thumbnailLink: String?
    //let thumbnailHeight: Int
    //let thumbnailWidth: Int
}

extension ThumbNailImg {
    enum CodingKeys: String, CodingKey {
        // case height = "height"
        //case width = "width"
        case thumbnailLink = "thumbnailLink"
        //case thumbnailHeight = "thumbnailHeight"
        //case thumbnailWidth = "thumbnailWidth"
    }
}
