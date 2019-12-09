//
//  RepositoryViewModel.swift
//  TestRxNetworking
//
//  Created by Mykhailo Bondarenko on 09.12.2019.
//  Copyright © 2019 Mykhailo Bondarenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct RepositoryViewModel {
    let searchText = Variable("")
//    let disposeBag = DisposeBag()
    let APIProvider: APIProvider
    var data: Driver<[Repository]>
    
    init(APIProvider: APIProvider) {
        self.APIProvider = APIProvider
        data = self.searchText.asObservable().throttle(0.3, scheduler: MainScheduler.instance).distinctUntilChanged().flatMapLatest {
            APIProvider.getRepositories($0)
        }.asDriver(onErrorJustReturn: [])
    }
}
