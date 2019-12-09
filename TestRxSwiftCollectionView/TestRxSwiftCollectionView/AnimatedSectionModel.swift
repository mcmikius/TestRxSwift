//
//  AnimatedSectionModel.swift
//  TestRxSwiftCollectionView
//
//  Created by Mykhailo Bondarenko on 09.12.2019.
//  Copyright © 2019 Mykhailo Bondarenko. All rights reserved.
//

import Foundation
import RxDataSources

struct AnimatedSectionModel {
    let title: String
    var data: [String]
}

extension AnimatedSectionModel: AnimatableSectionModelType {
    
    
    typealias Item = String
    
    typealias Identity = String
    
    var items: [String] {
        return data
    }
    
    init(original: AnimatedSectionModel, items: [String]) {
        self = original
        data = items
    }
    
    var identity: String {
        return title
    }
}

extension String {
    public typealias Identity = String
    public var identity: Identity { return self }
}
