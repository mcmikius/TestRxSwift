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
