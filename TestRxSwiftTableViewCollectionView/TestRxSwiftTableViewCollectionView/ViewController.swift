//
//  ViewController.swift
//  TestRxSwiftTableViewCollectionView
//
//  Created by Mykhailo Bondarenko on 09.12.2019.
//  Copyright © 2019 Mykhailo Bondarenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let foods = Observable.just([
        Food(name: "Fastfood", flickrID: "fastfood"),
        Food(name: "Imageresizer", flickrID: "imageresizer"),
        Food(name: "Images", flickrID: "images"),
        Food(name: "Recipes-header", flickrID: "recipes-header-1600x1066")
    ])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foods.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { row, food, cell in
            cell.textLabel?.text = food.name
            cell.detailTextLabel?.text = food.flickrID
            cell.imageView?.image = food.image
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Food.self).subscribe(onNext: {
            print("You selcted: \($0)")
        }).disposed(by: disposeBag)
    }


}
/*
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        
        let food = foods[indexPath.row]
        cell.textLabel?.text = food.name
        cell.detailTextLabel?.text = food.flickrID
        cell.imageView?.image = food.image
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("your selcted: \(indexPath.row)")
    }
}
*/
