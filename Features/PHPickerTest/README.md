# PHPickerViewController

`PHPickerViewController` 는 iOS 14부터 도입된 PhotosUI 프레임워크의 일부로, 사용자가 사진 라이브러리에서 미디어(사진, 비디오)를 선택할 수 있게 해주는 뷰 컨트롤러.  
기존의 UIImagePickerController와 달리 모든 미디어에 접근 권한을 요청하지 않아도 됨

### 코드 예시

```swift
import UIKit
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    @IBAction func selectImageTapped(_ sender: UIButton) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1 // 사용자가 한 번에 선택할 수 있는 이미지 수
        config.filter = .images // 이미지만 선택하도록 필터 설정

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self?.imageView.image = image
                    }
                }
            }
        }

    }
}
```

`PHPickerViewController`에서 선택된 결과를 가져와 첫 번째 항목의 `itemProvider`를 확인.  
`itemProvider`가 이미지 객체(`UIImage`)를 로드할 수 있는지 확인한 다음, 이미지를 비동기적으로 로드하고 메인 스레드에서 `UIImageView`에 이미지를 설정.

# NSItemProvider:

다양한 타입의 콘텐츠(예: 텍스트, 이미지, URL, 문서 등)를 비동기적으로 로드하고, 드래그 앤 드롭, 유니버설 클립보드, 문서 브라우저 등에서 데이터를 공유하고 관리하는 데 사용되는 클래스.  
앱이나 앱 간에 데이터를 전달할 때 중간자 역할을 함.

## 기본 사용법

`NSItemProvider`는 하나 이상의 타입 식별자를 가지며, 이를 통해 해당 데이터 타입을 로드할 수 있는지 여부를 확인할 수 있음.  
`canLoadObject(ofClass:)` 메소드를 사용하여 `UIImage` 클래스의 인스턴스를 로드할 수 있는지 확인.

```swift
let itemProvider = NSItemProvider(contentsOf: imageURL)
if itemProvider.canLoadObject(ofClass: UIImage.self) {
    // 이미지 로드 가능
}
```

## 드래그 앤 드롭

드래그를 시작하는 부분은 `UIDragInteractionDelegate` 프로토콜을 구현하여 설정 가능. 먼저, 드래그 가능한 뷰에 `UIDragInteraction`을 추가하고, 델리게이트를 설정함.

```swift
import UIKit

class ViewController: UIViewController, UIDragInteractionDelegate {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 이미지 뷰에 드래그 인터랙션 추가
        let dragInteraction = UIDragInteraction(delegate: self)
        imageView.addInteraction(dragInteraction)

        // 사용자가 이미지를 드래그할 수 있도록 허용
        imageView.isUserInteractionEnabled = true
    }

    // 드래그 항목 제공
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = imageView.image else { return [] }

        let itemProvider = NSItemProvider(object: image)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
}
```

`imageView`에서 드래그를 시작할 수 있게 하는 코드. 사용자가 이미지를 드래그하기 시작하면, 해당 이미지의 `NSItemProvider`를 포함하는 `UIDragItem` 배열을 반환.

### 드롭 받기

드롭을 받는 부분은 `UIDropInteractionDelegate` 프로토콜을 구현하여 설정할 수 있음. 드롭을 받을 뷰에 `UIDropInteraction`을 추가하고, 델리게이트를 설정해야 함.

```swift
class DropViewController: UIViewController, UIDropInteractionDelegate {

    @IBOutlet weak var dropAreaView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 드롭 영역에 드롭 인터랙션 추가
        let dropInteraction = UIDropInteraction(delegate: self)
        dropAreaView.addInteraction(dropInteraction)
    }

    // 드롭 세션을 수락할 수 있는지 여부를 결정
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }

    // 사용자가 뷰 위에 항목을 드롭하려고 할 때의 반응
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self) { imageItems in
            let images = imageItems as! [UIImage]
            // 첫 번째 이미지 처리
            if let image = images.first {
                DispatchQueue.main.async {
                    // 이미지를 UI에 표시하는 로직 구현
                }
            }
        }
    }
}
```

`dropAreaView`에 이미지를 드롭할 수 있게 하는 코드.  
 사용자가 이미지를 드롭 영역 위로 드래그하면 `performDrop` 메소드가 호출되고, 세션을 통해 이미지를 로드하여 UI에 표시하거나 다른 처리를 할 수 있음.
