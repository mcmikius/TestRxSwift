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
import RxDataSources

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let foodsData = SectionFoodModel()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Food>>(configureCell: { _, tableView, indexPath, food in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = food.name
        cell.detailTextLabel?.text = food.flickrID
        cell.imageView?.image = food.image
        return cell
    })
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodsData.foodsSection.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
//        dataSource.titleForHeaderInSection = { data, section in
//            (data.sectionIndexTitles(section) as AnyObject).model
//        }
        //        foods.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { row, food, cell in
        //            cell.textLabel?.text = food.name
        //            cell.detailTextLabel?.text = food.flickrID
        //            cell.imageView?.image = food.image
        //        }.disposed(by: disposeBag)
        //
        //        tableView.rx.modelSelected(Food.self).subscribe(onNext: {
        //            print("You selcted: \($0)")
        //        }).disposed(by: disposeBag)
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(64) + 32)
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
