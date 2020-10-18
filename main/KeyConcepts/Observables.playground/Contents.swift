//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

/*:
 # Observables
 */

//Observable
//= Observable Sequence
//= Sequence
//
//Observable → Event → Observer(=subscriber)
//          ← Subscribe ←
//
//- event 방출시 next를 사용한다. 이벤트 방출 Emission
//- 종료시 Error 혹은 Completed를 방출. 이때는 emission이 아닌 notification 라고 한다.

//#1
let o1 = Observable<Int>.create { (observer) -> Disposable in
    observer.on(.next(0))
    observer.onNext(1)
    
    observer.onCompleted()
    
    return Disposables.create()
}

o1.subscribe {
    print("-------------------- <start> --------------------")
    print($0)
    
    if let elem = $0.element {
        print(elem)
    }
    print("-------------------- <end> --------------------")
}
print("-------------------- <vs. onNext> --------------------")
o1.subscribe(onNext: { elem in
    print(elem)
    
})
    
//#2
Observable.from([0, 1]) //순서대로 방출!!!!!!

//Observer가 Observable을 구독할때 이벤트가 방출된다.
//방출하기 전까지는 이벤트가 생성되어 있는 상태
//이벤트가 전달되는 시점은 옵저버가 옵저버블을 구독하기 시작하는 시점!!!














