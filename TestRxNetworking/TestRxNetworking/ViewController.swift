//
//  ViewController.swift
//  TestRxNetworking
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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
    var repositoriesViewModel: RepositoryViewModel?
    let api = APIProvider()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureSearchController()
        repositoriesViewModel = RepositoryViewModel(APIProvider: api)
        if let repositoriesViewModel = repositoriesViewModel {
            repositoriesViewModel.data.drive(tableView.rx.items(cellIdentifier: "Cell")) { _, repository, cell in
                cell.textLabel?.text = repository.name
                cell.detailTextLabel?.text = repository.url
            }.disposed(by: disposeBag)
            searchBar.rx.text.orEmpty.bind(to: repositoriesViewModel.searchText).disposed(by: disposeBag)
            searchBar.rx.cancelButtonClicked.map {""}.bind(to: repositoriesViewModel.searchText).disposed(by: disposeBag)
            repositoriesViewModel.data.asDriver().map {
                "\($0.count) Repositories"
            }.drive(navigationItem.rx.title).disposed(by: disposeBag)
        }
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = ""
        searchBar.placeholder = "Enter user..."
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    


}

