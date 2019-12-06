//
//  ViewController.swift
//  TestRxSwiftGUI
//
//  Created by Mykhailo Bondarenko on 06.12.2019.
//  Copyright © 2019 Mykhailo Bondarenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentedControlLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewLabel: UILabel!
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureRecognizer.rx.event.asDriver().drive(onNext: { [unowned self] _ in
            self.view.endEditing(true)
        }).disposed(by: disposeBag)
        
        textField.rx.text.orEmpty.bind {
            self.textFieldLabel.text = $0
        }.disposed(by: disposeBag)
        
        textView.rx.text.orEmpty.bind {
            self.textViewLabel.text = "Characters count: \($0.count)"
        }.disposed(by: disposeBag)
        
        button.rx.tap.asDriver().drive(onNext: {
            self.buttonLabel.text! += "RxSwift"
            self.view.endEditing(true)
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
        
        slider.rx.value.asDriver().drive(progressView.rx.progress).disposed(by: disposeBag)
        
        segmentedControl.rx.value.asDriver().skip(1).drive(onNext: {
            self.segmentedControlLabel.text = "Selected segment = \($0)"
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
        
        datePicker.rx.date.asDriver().map {
            self.dateFormatter.string(from: $0)
        }.drive(onNext: {
            self.datePickerLabel.text = "Selected date: \($0)"
        }).disposed(by: disposeBag)
        
        stepper.rx.value.asDriver().map {
            String(Int($0))
        }.drive(stepperLabel.rx.text).disposed(by: disposeBag)
        
        mySwitch.rx.value.asDriver().map { !$0 }.drive(activityIndicator.rx.isHidden).disposed(by: disposeBag)
        mySwitch.rx.value.asDriver().drive(activityIndicator.rx.isAnimating).disposed(by: disposeBag)
    }


}

