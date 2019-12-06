//
//  ViewController.swift
//  RxSwiftGUI
//
//  Created by Mykhailo Bondarenko on 06.12.2019.
//  Copyright © 2019 Mykhailo Bondarenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    let disposeBag = DisposeBag()
    let textFieldText = BehaviorRelay<String?>(value: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField.rx.text.orEmpty.bind(to: textFieldText).disposed(by: disposeBag)
        textFieldText.asObservable().subscribe(onNext: {
            print($0!)
        }).disposed(by: disposeBag)
    }

}

