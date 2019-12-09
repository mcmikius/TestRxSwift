//
//  APIProvider.swift
//  TestRxNetworking
//
//  Created by Mykhailo Bondarenko on 09.12.2019.
//  Copyright © 2019 Mykhailo Bondarenko. All rights reserved.
//

import Foundation
import RxSwift

class APIProvider {
    
    func getRepositories(_ gitHubId: String) -> Observable<[Repository]> {
        guard !gitHubId.isEmpty, let url = URL(string: "https://api.github.com/users/\(gitHubId)/repos") else {
            return Observable.just([])
        }
        return URLSession.shared.rx.json(request: URLRequest(url: url)).retry(3).map {
            var repositories = [Repository]()
            if let items = $0 as? [[String: AnyObject]] {
                items.forEach {
                    guard let name = $0["name"] as? String, let url = $0["html_url"] as? String else {
                        return
                    }
                    repositories.append(Repository(name: name, url: url))
                }
            }
            return repositories
        }
    }
}

