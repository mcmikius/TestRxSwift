/*:
 > # IMPORTANT: To use **Rx.playground**:
 1. Open **Rx.xcworkspace**.
 1. Build the **RxExample-macOS** scheme (**Product** → **Build**).
 1. Open **Rx** playground in the **Project navigator** (under RxExample project).
 1. Show the Debug Area (**View** → **Debug Area** → **Show Debug Area**).
 */
import RxSwift
/*:
 # Try Yourself
 
 It's time to play with Rx 🎉
 */
playgroundShouldContinueIndefinitely()

// First Lessons
 
example("Try yourself") {
  // let disposeBag = DisposeBag()
  _ = Observable.just("Hello, RxSwift!")
    .debug("Observable")
    .subscribe()
    // .disposed(by: disposeBag) // If dispose bag is used instead, sequence will terminate on scope exit
}

example("just") {
    let observable = Observable.just("Hello, Swift")
    observable.subscribe({(event) in
        print(event)
    })
}

example("Test") {
    let intObservable = Observable.just(30)
    let stringObservable = Observable.just("Hello")
}

example("of") {
    let observable = Observable.of(1, 2, 3, 4)
    observable.subscribe { (event) in
        print(event)
    }
    observable.subscribe {
        print($0)
    }
}

example("Create") {
    let items = [1, 2, 3, 4, 5]
    Observable.from(items).subscribe(onNext: { (event) in
        print(event)
    }, onError: { (error) in
        print("error")
    }, onCompleted: {
        print("Ok!")
    }) {
        print("disposed")
    }
}

example("Disposable") {
    let items = [1, 2, 3, 4, 5]
    Observable.from(items).subscribe { (event) in
        print(event)
    }
    Disposables.create()
}

example("dispose") {
    let items = [1, 2, 3, 4, 5]
    let subscription = Observable.from(items)
    subscription.subscribe { (event) in
        print(event)
    }.dispose()
}

example("disposeBag") {
    let disposeBag = DisposeBag()
    let items = [1, 2, 3, 4, 5]
    let subscription = Observable.from(items)
    subscription.subscribe { (event) in
        print(event)
    }.disposed(by: disposeBag)
}

example("takeUntil") {
    let items = [1, 2, 3, 4, 5]
    let stopSequence = Observable.just(1).delaySubscription(2, scheduler: MainScheduler.instance)
    let sequence = Observable.from(items).takeUntil(stopSequence)
    sequence.subscribe {
        print($0)
    }
}

example("filter") {
//    let items = [1, 20, 3, 40, 5, 60]
    let sequence = Observable.of(1, 20, 3, 40, 5, 60).filter{ $0 > 10 }
    sequence.subscribe( { (event) in
        print(event)
    })
}

example("map") {
    let sequence = Observable.of(1, 20, 3, 40, 5, 60).map{ $0 * 10 }
    sequence.subscribe { (event) in
        print(event)
    }
}

example("merge") {
    let firstSequence = Observable.of(1, 2, 3)
    let secondSequence = Observable.of(6, 7, 8)
    let bothSequence = Observable.of(firstSequence, secondSequence)
    let mergeSequence = bothSequence.merge()
    mergeSequence.subscribe { (event) in
        print(event)
    }
}


// Second Lessons


example("PublishSubject") {
    let disposableBag = DisposeBag()
    let subject = PublishSubject<String>()
    subject.subscribe {
        print("Subscription First: ", $0)
    }.disposed(by: disposableBag)
    
    enum MyError: Error {
        case Text
    }
    
    subject.on(Event<String>.next("Hello"))
//    subject.onCompleted()
//    subject.onError(MyError.Text)
    subject.onNext("RxSwift")
    subject.subscribe(onNext: {
        print("Subscription Second: ", $0)
    }).disposed(by: disposableBag)
    subject.onNext("Hi")
    subject.onNext("Swift")
}

example("BehaviorSubject") {
    let disposableBag = DisposeBag()
    let subject = BehaviorSubject(value: 1)
    
    let firstSubscription = subject.subscribe(onNext: {
        print(#line, $0)
        }).disposed(by: disposableBag)
    subject.onNext(2)
    subject.onNext(3)
    let secondSubscrioption = subject.map({ $0 + 2 }).subscribe(onNext: {
        print(#line, $0)
    }).disposed(by: disposableBag)
}

example("ReplaySubject") {
    let disposableBag = DisposeBag()
//    let subject = ReplaySubject<String>.create(bufferSize: 1)
//
//    subject.subscribe {
//        print("Subscription First: ", $0)
//    }.disposed(by: disposableBag)
//
//    subject.onNext("a")
//    subject.onNext("b")
//
//    subject.subscribe {
//        print("Subscription Second: ", $0)
//    }.disposed(by: disposableBag)
//
//    subject.onNext("c")
//    subject.onNext("d")
    
    let subject = ReplaySubject<Int>.create(bufferSize: 3)
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)
    
    subject.subscribe {
            print( $0)
        }.disposed(by: disposableBag)
}

example("Variables") {
    let disposableBag = DisposeBag()
    
    let variable = Variable("A")
    
    variable.asObservable().subscribe(onNext:{
        print($0)
    }).disposed(by: disposableBag)
    
    variable.value = "B"
}

// Third Lessons

example("SideEffect") {
    let disposableBag = DisposeBag()
    let sequence = [0, 32, 100, 300]
    let tempSequence = Observable.from(sequence)
    tempSequence.do(onNext: {
        print("\($0)F = ", terminator: "")
        }).map({
            Double($0 - 32) * 5 / 9.0
        }).subscribe(onNext: {
            print(String(format: "%.1f", $0))
        }).disposed(by: disposableBag)
}

// Fourth Lessons

//example("without observeOn") {
//    _ = Observable.of(1, 2, 3).subscribe(onNext: {
//        print("\(Thread.current): ", $0)
//    }, onError: nil, onCompleted: {
//        print("Completed")
//    }, onDisposed: nil)
//}
//
//example("observeOn") {
//    _ = Observable.of(1, 2, 3).observeOn(ConcurrentDispatchQueueScheduler(qos: .background)).subscribe(onNext: {
//        print("\(Thread.current): ", $0)
//    }, onError: nil, onCompleted: {
//        print("Completed")
//    }, onDisposed: nil)
//}

//example("subscribeOn and observeOn") {
//    let queueOne = DispatchQueue.global(qos: .default)
//    let queueTwo = DispatchQueue.global(qos: .default)
//
//    print("init Thread: \(Thread.current)")
//    _ = Observable.create({(observer) -> Disposable in
//        print("Observeble Thread: \(Thread.current)")
//        observer.on(.next(1))
//        observer.on(.next(2))
//        observer.on(.next(3))
//        return Disposables.create()
//        })
//        .subscribeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "queueOne")).observeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "queueTwo"))
//        .subscribe(onNext: {
//                print("\(Thread.current): ", $0)
//            })
//}
