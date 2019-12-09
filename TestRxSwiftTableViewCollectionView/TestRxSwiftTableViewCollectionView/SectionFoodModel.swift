//
//  SectionFoodModel.swift
//  TestRxSwiftTableViewCollectionView
//
//  Created by Mykhailo Bondarenko on 09.12.2019.
//  Copyright © 2019 Mykhailo Bondarenko. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class SectionFoodModel {
    let foodsSection = Observable.just([
        SectionModel(model: "F", items: [Food(name: "Fastfood", flickrID: "fastfood")]),
        SectionModel(model: "I", items: [Food(name: "Imageresizer", flickrID: "imageresizer"),
        Food(name: "Images", flickrID: "images")]),
        SectionModel(model: "R", items: [Food(name: "Recipes-header", flickrID: "recipes-header-1600x1066")])
    ])
    let foods = Observable.just([
        Food(name: "Fastfood", flickrID: "fastfood"),
        Food(name: "Imageresizer", flickrID: "imageresizer"),
        Food(name: "Images", flickrID: "images"),
        Food(name: "Recipes-header", flickrID: "recipes-header-1600x1066")
    ])
}
