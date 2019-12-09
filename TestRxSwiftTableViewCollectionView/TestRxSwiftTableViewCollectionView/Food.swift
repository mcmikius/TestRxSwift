//
//  Food.swift
//  TestRxSwiftTableViewCollectionView
//
//  Created by Mykhailo Bondarenko on 09.12.2019.
//  Copyright © 2019 Mykhailo Bondarenko. All rights reserved.
//

import Foundation
import UIKit

struct Food {
    let name: String
    let flickrID: String
    let image: UIImage?
    
    init(name: String, flickrID: String) {
        self.name = name
        self.flickrID = flickrID
        image = UIImage(named: flickrID)
    }
}

extension Food: CustomStringConvertible {
    var description: String {
        return "\(name): flickr.com/\(flickrID)"
    }
    
}
