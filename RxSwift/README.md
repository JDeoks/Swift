# RxSwift

```swift
import UIKit
import RxSwift
import RxCocoa

class NickNameSettingViewController: UIViewController {

    // 자원 정리를 위한 DisposeBag
    let disposeBag = DisposeBag()
    let viewModel = NickNameSettingViewModel()

    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        action()
    }

    // UI 이벤트 구독
    private func action() {
        nickNameTextField.rx.text.orEmpty
            .bind(to: viewModel.nickname)
            .disposed(by: disposeBag)

        startButton.rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.generateUser()
            })
            .disposed(by: disposeBag)
    }

    /// 뷰모델의 옵저버블 구독
    private func bind() {
        viewModel.validation
            .subscribe(onNext: { isValid in
                self.startButton.isEnabled = isValid
                self.startButton.backgroundColor = isValid ? .blue : .gray
            })
            .disposed(by: disposeBag)

        viewModel.isSuccess
            .subscribe(onNext: { _ in
                // TODO
            })
            .disposed(by: disposeBag)

        viewModel.errorMsg
            .subscribe(onNext: { msg in
                print(msg)
            })
            .disposed(by: disposeBag)
    }
}
```

```swift
class NickNameSettingViewModel {

    let disposeBag = DisposeBag()

    let nickname = BehaviorSubject(value: "")
    let validation = BehaviorSubject(value: false)
    let isSuccess = PublishSubject<Void>()
    let errorMsg = PublishSubject<String>()

    init() {
        nickname
            .subscribe(onNext: { text in
                self.validation.onNext(!text.isEmpty)
            })
            .disposed(by: disposeBag)
    }

    func generateUser() {
        // TODO: 유저 생성 로직
        /// 성공여부 플래그
        var isSuccess = true

        if isSuccess {
            self.isSuccess.onNext(())
        } else {
            self.errorMsg.onNext("Something wrong")
        }
    }
}
```
