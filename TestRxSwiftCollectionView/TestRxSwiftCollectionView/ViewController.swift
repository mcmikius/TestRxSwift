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
    
    let data = Variable([AnimatedSectionModel(title: "Section 0", data: ["0-0"])])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! HeaderCollectionReusableView
            header.titleLabel.text = "Section: \(self.data.value.count)"
            return header
        }
        data.asDriver().drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        addBarButtonItem.rx.tap.asDriver().drive(onNext: {
            let section = self.data.value.count
            let items: [String] = {
                var items = [String]()
                let random = arc4random_uniform(5) + 1
                (0...random).forEach {
                    items.append("\(section)-\($0)")
                }
                return items
            }()
            self.data.value += [AnimatedSectionModel(title: "Section: \(section)", data: items)]
        }).disposed(by: disposeBag)
        
        longGestureRecognizer.rx.event.subscribe(onNext: {
            switch $0.state {
            case .began:
                guard let selectedIndexPath = self.collectionView.indexPathForItem(at: $0.location(in: self.collectionView)) else { break }
                self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            case .changed:
                self.collectionView.updateInteractiveMovementTargetPosition($0.location(in: $0.view!))
            case .ended:
                self.collectionView.endInteractiveMovement()
            default:
                self.collectionView.cancelInteractiveMovement()
            }
        }).disposed(by: disposeBag)
    }
    
    
}

