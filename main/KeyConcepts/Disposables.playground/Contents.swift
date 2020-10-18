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
 # Disposables
 */
let subscription1 = Observable.from([1, 2, 3])
    .subscribe { (elem) in
        print("Next", elem)
    } onError: { (error) in
        print("Error")
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        print("Disposed")
    }
//= subscription disposable
//ㄴ 리소스 해제, 실행취소에 사용

subscription1.dispose()

var bag = DisposeBag()

print("-------------------- < .vs > --------------------")

Observable.from([1, 2, 3])
    .subscribe {
        print($0)
    }
    .disposed(by: bag)
//completed 다음에 disposed가 호출되지 않음
//disposed가 출력되지 않았으니까 리소스가 해제되지 않았을까?
//Observable이 completed, error로 종료되었다면 관련된 리소스가 자동으로 해제됨 -> 정상 해제 맞음
//왜 disposed가 출력되지 않았을까? > disposed는 Observable이 전달하는 이벤트가 아님. 1번의 경우 disposed가 콜 되는 시점에 해당 이벤트를 콜해주는것일뿐


print("-------------------- <subscription disposable을 실행취소에 사용하는 경우> --------------------")

let subscription2 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .subscribe { (elem) in
        print("Next", elem)
    } onError: { (error) in
        print("Error")
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        print("Disposed")
    }

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    subscription2.dispose()
    //실행취소기 때문에 completed 이벤트가 방출되지 않기 때문에 최대한 직접 dispose를 호출하는건 피하는게 좋음
}













