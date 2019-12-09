//
//  ViewController.swift
//  TestRxSwiftCollectionView
//
//  Created by Mykhailo Bondarenko on 09.12.2019.
//  Copyright © 2019 Mykhailo Bondarenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var longGestureRecognizer: UILongPressGestureRecognizer!
    
    let disposeBag = DisposeBag()
    
    let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatedSectionModel>(configureCell: { _, collectionView, IndexPath, title in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: IndexPath) as! CellCollectionViewCell
        cell.titleLabel.text = title
        return cell
    })
    
    let data = BehaviorRelay(value: [AnimatedSectionModel(title: "Section 0", data: ["0-0"])])

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! HeaderCollectionReusableView
            header.titleLabel.text = "Section: \(self.data.value.count)"
            return header
        }
        data.asDriver().drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }


}

