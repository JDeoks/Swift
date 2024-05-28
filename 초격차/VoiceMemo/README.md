프로젝트 계층

- App
  - app에 대한 파일들
- Core
  - Service:
    뷰에 영향을 끼칠 수 있는 작업을 해주는 것들(manager)
  - 익스텐션
- 컴포넌트:
  커스텀한 뷰를 넣는 곳
- feature:
  하나하나의 기능별 단위(온보딩, 홈, )
- 모델:
  뷰모델에서 사용될 스텁, DTO

# **ObservableObject**

뷰에서 상태변화를 감지할 수 있게 해줌

**`@Published` 로 선언된 프로퍼티의 값이 변경될 때마다 `objectWillChange` 를 통해 방출됨**

뷰모델 클래스에 사용하는 프로토콜

```swift
class MyViewModel: ObservableObject {
    @Published var someData: String = "Hello, World!"
}

struct ContentView: View {
    @StateObject private var viewModel = MyViewModel()

    var body: some View {
        VStack {
            Text(viewModel.someData)
            Button(action: {
                viewModel.someData = "Data Changed!"
            }) {
                Text("Change Data")
            }
        }
    }
}
```

# **@Published**

`PublishSubject`와 비슷

`ObservableObject`에서 속성을 선언할 때 사용하는 PropertyWrapper.

`@Published`로 선언된 속성이 `ObservableObject`에 포함되어 있다면 해당 속성이 업데이트 될 때마다 뷰를 업데이트 함

```swift
class UserModel: ObservableObject {
    @Published var username: String = ""
}

struct ContentView: View {
    @StateObject private var model = UserModel()

    var body: some View {
        VStack {
            TextField("Enter username", text: $model.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Username: \(model.username)")
        }
    }
}
```

# 상태 프로퍼티

뷰의 상태를 관리하고, 상태가 변경될 때 뷰를 업데이트하는데 사용됨

## **@State**

단일 뷰의 로컬 상태를 관리

간단한 값의 상태를 관리할 때 사용됨

생명주기가 뷰와 동일함

```swift
struct ContentView: View {
    @State private var isOn: Bool = false

    var body: some View {
		    // 토글도 양방향이므로 $추가
        Toggle(isOn: $isOn) {
            Text("Toggle")
        }
    }
}
```

## - $

$는 바인딩을 나타내는 접두사

UI 요소(예: Toggle, TextField)와 데이터 모델 간에 양방향 데이터 바인딩을 설정하여, 사용자가 UI에서 입력한 값, 데이터 모델의 변경 값이 서로 반영됨

## **@Binding**

부모 뷰의 상태를 자식 뷰에 참조로 전달함

부모 뷰와 자식 뷰 간에 상태를 공유하고 동기화할 수 있음

생명주기가 상태를 소유한 부모뷰의 생명주기에 종속됨

```swift
struct ParentView: View {
    @State private var isOn: Bool = false

    var body: some View {
        ChildView(isOn: $isOn)
    }
}

struct ChildView: View {
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            Text("Toggle")
        }
    }
}
```

`@Binding` 대신 `@State` 사용했을 경우, 각각의 isOn은 각각의 뷰에서 독립된 상태를 가지며, 동기화 되지 않음

## @StateObject

뷰에서 자체적으로 생성한 객체(`ObservableObject` 채택)의 상태 변화를 감지하고, 이에 따라 뷰를 다시 렌더링

이 객체를 뷰의 생명주기동안 유지하고, 뷰가 다시 그려질 때 객체를 재생성하지 않음

```swift
class MyViewModel: ObservableObject {
    @Published var someData: String = "Hello, World!"
}

struct ContentView: View {
    @StateObject private var viewModel = MyViewModel()

    var body: some View {
        VStack {
            Text(viewModel.someData)
            Button(action: {
                viewModel.someData = "Data Changed!"
            }) {
                Text("Change Data")
            }
        }
    }
}
```

### init 함수 안에서 @State 초기화

```swift
struct MyView: View {
    @State private var isRemoveSelected: Bool

    init(isRemoveSelected: Bool = false) {
		    // @State 초기화
        _isRemoveSelected = State(initialValue: isRemoveSelected)
    }

    var body: some View {
        VStack {
            Text(isRemoveSelected ? "Selected" : "Not Selected")
            Button(action: {
                isRemoveSelected.toggle()
            }) {
                Text("Toggle Selection")
            }
        }
    }
}
```

변수 이름 앞에 \_추가해서 선언한 text가 프로퍼티 래퍼라는 것을 컴파일러에게 알림

## **@ObservedObject**

외부에서 참조 전달된 객체의 상태를 관찰. 뷰는 객체의 소유권을 가지지 않음

뷰가 사라져도 객체는 유지

부모 뷰에서 자식 뷰로 상태를 전달할 때 사용

**생명주기**: 뷰 외부에서 생성되고, 뷰의 생명주기와 독립적으로 관리

```swift
class MyViewModel: ObservableObject {
    @Published var someData: String = "Hello, World!"
}

struct ParentView: View {
    @StateObject private var viewModel = MyViewModel()

    var body: some View {
        ChildView(viewModel: viewModel)
    }
}

struct ChildView: View {
    @ObservedObject var viewModel: MyViewModel

    var body: some View {
        VStack {
            Text(viewModel.someData)
            Button(action: {
                viewModel.someData = "Data Changed!"
            }) {
                Text("Change Data")
            }
        }
    }
}
```

## **@EnvironmentObject**

앱 전체에서 공유되는 상태를 관리

앱의 생명주기와 일치

여러 뷰에서 동일한 상태를 공유하고자 할 때 사용

.environmentObject(settings)로 전달하면 그 뷰를 포함한 하위뷰 전부에서 접근 가능

```swift
class AppSettings: ObservableObject {
    @Published var username: String = "User"
}

struct ContentView: View {
    @EnvironmentObject var settings: AppSettings

    var body: some View {
        Text(settings.username)
    }
}

@main
struct MyApp: App {
    var settings = AppSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}
```

## NavigationStack

루트 뷰를 표시하고 루트 뷰 위에 추가 뷰를 표시할 수 있는 뷰

뷰의 스택을 루트 뷰 위에 표시하기 위해 사용.

NavigationLink를 클릭해서 스택에 뷰를 추가, 뒤로가기나 스와이프로 뷰를 제거

가장 최근에 추가된 뷰를 표시하며, 루트뷰는 제거할 수 없음

### NavigationLink 생성

```swift
NavigationStack {
    List(parks) { park in
        NavigationLink(park.name, value: park)
    }
    .navigationDestination(for: Park.self) { park in
        ParkDetails(park: park)
    }
}
```

`navigationDestination(for:destination:)` 모디파이어로 뷰를 데이터 타입과 연결후,

같은 타입의 데이터를 표시하는 `NavigationLink` 를 초기화 함

`NavigationStack`안에는 루트뷰 하나만 들어감(List)

### **네비게이션 상태 관리**

스택을 데이터컬렉션에 바인딩해서 초기화 할 수 있음

```swift
@State private var presentedParks: [Park] = []
NavigationStack(path: $presentedParks) {
    List(parks) { park in
        NavigationLink(park.name, value: park)
    }
    .navigationDestination(for: Park.self) { park in
        ParkDetails(park: park)
    }
}
```

`NavigationLink` 클릭 시 Park모델을 배열에 추가, ParkDetails뷰 표시

### 여러 뷰 한번에 푸시

```swift
func showParks() {
    presentedParks = [Park("Yosemite"), Park("Sequoia")]
}
```

딥 링크, 상태 복원 또는 프로그래밍 방식의 네비게이션 가능

```swift
struct OnboardingView: View {
    // StateObject로 PathModel과 OnboardingViewModel을 선언.
    @StateObject private var pathModel = PathModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()

    var body: some View {
        // NavigationStack을 사용하여 앱 내의 네비게이션 경로를 관리.
        // pathModel.paths는 현재 네비게이션 경로를 바인딩하는 데 사용됨.
        NavigationStack(path: $pathModel.paths) {
            // OnboardingContentView를 루트뷰로 설정
            OnboardingContentView(onboardingViewModel: onboardingViewModel)
                .navigationDestination(for: PathType.self) { pathType in
                    // pathType의 값에 따라 해당하는 뷰를 생성합니다.
                    switch pathType {
                    case .homeView:
                        HomeView()
                            .navigationBarBackButtonHidden()

                    case .todoView:
                        TodoView()
                            .navigationBarBackButtonHidden()

                    case .memoView:
                        MemoView()
                            .navigationBarBackButtonHidden()
                    }
                }
        }
        // environmentObject를 사용하여 pathModel을 하위 뷰에 주입.
        // 따라서 모든 하위 뷰에서 pathModel에 접근할 수 있음.
        .environmentObject(pathModel)
        .onAppear{
            pathModel.paths.append(.memoView)
        }
    }
}
```

뷰를 pop할 때 하위뷰에서 pathModel 접근이 필요 → environmentObject로 넘겨줌

# 컴포넌트

## TextField

```swift
struct ContentView: View {
    @State var text: String = ""

    var body: some View {
        VStack {
            Text(text)
            TextField(
	            "Input your text.", // 플레이스홀더
	            text: $text // 바인딩할 값
            )
        }
    }
}
```

## @FocusState

SwiftUI에서 텍스트 필드나 다른 포커스 가능한 뷰의 포커스를 관리하기 위해 사용되는 프로퍼티 래퍼

```swift
struct ContentView: View {
    @State var name: String = ""
    @State var password: String = ""
    @FocusState var focusField: Field?

    enum Field: Hashable {
        case name
        case password
    }

    var body: some View {
        Form {
            TextField("Name", text: $name)
                .focused($focusField, equals: .name)
                .onSubmit {
                    focusField = .password
                }

            TextField("Password", text: $password)
                .focused($focusField, equals: .password)
                .onSubmit {
                    checkTextField()
                }

            Button("Login") {
                checkTextField()
            }
        }
        .onAppear {
            focusField = .name
        }
    }

    func checkTextField() {
        if name.isEmpty {
	        focusField = .name
        } else if password.isEmpty {
	        focusField = .password
	      } else {
		      focusField = nil
		      // TODO: - 로그인 처리 로직
	      }
    }
}
```

`.**focused` 각 텍스트 필드를 특정 포커스 상태와 연결\*\*

**`.onSubmit` “Return” 키를 눌렀을 때의 동작을 정의**

## ZStack

하위뷰를 겹쳐서 표현 & 수직 수평으로 정렬

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue
                .frame(width: 200, height: 200)
                .zIndex(0)  // 배경 색에 zIndex 0을 설정
            Text("Hello, World!")
                .foregroundColor(.white)
                .zIndex(1)  // 텍스트에 zIndex 1을 설정
        }
    }
}
```

## .overlay()

뷰의 위에 다른 뷰를 겹칠 때 사용.

원래 뷰와 같은 크기를 가지며, 지정된 위치에 새로운 뷰를 겹치게 함

```swift
var body: some View {
    Color.blue
        .frame(width: 200, height: 200)
        .overlay(
            Text("Hello, World!")
                .foregroundColor(.white)
        )
}
```

## ScrollView

```swift
var body: some View {
    ScrollView {
        VStack(
	        .vertical,
	        showsIndicators: true
        ) {
            ForEach(0..<100) {
                Text("Row \($0)")
            }
        }
    }
}
```

### 스크롤 위치 제어

```swift
ScrollView([.horizontal, .vertical]) {
    // initially centered content
}
.defaultScrollAnchor(.center)
```

## .alert

```swift
struct ContentView: View {
    @State private var isDisplayAlert = false
    @State private var info: Info?

    var body: some View {
        Button("Save") {
            info = Info(name: "정보 1", error: "정보 저장 실패")
            isDisplayAlert = true
        }
        .alert("오류", isPresented: $isDisplayAlert, presenting: info) { info in
            Button(role: .destructive) {
                // Action for the button
            } label: {
                Text("Delete \(info.name)")
            }
        } message: { info in
            Text(info.error)
        }
    }
}

struct Info: Identifiable {
    let id = UUID()
    let name: String
    let error: String
}
```

## ForEach

주어진 데이터 컬렉션을 순회하며, 각 항목에 대해 뷰를 생성

```swift
struct Person: Identifiable {
    var id = UUID()
    var name: String
}

struct ContentView: View {
    let people = [Person(name: "Alice"), Person(name: "Bob")]

    var body: some View {
        List {
            ForEach(people) { person in
                Text(person.name)
            }
        }
    }
}
```

각 항목을 고유하게 식별하게 위해 `id` 파라미터를 사용.

데이터 모델이 `Identifiable` 프로토콜을 따르면 바로 사용가능.

각 항목 자체가 고유한 경우(`Hashable`)에는 `\.self` 로 사용 가능

### Key Path 사용

```swift
struct Person: Hashable {
    var name: String
}

struct ContentView: View {
    let people = [Person(name: "Alice"), Person(name: "Bob")]

    var body: some View {
        List {
            ForEach(people, id: \.self) { person in
                Text(person.name)
            }
        }
    }
}
```

### **Identifiable**

객체를 고유하게 식별가능 하게 함

프로퍼티로 id 구현 필수

### Hashable

객체를 해시 값으로 변환할 수 있게 함.

객체를 빠르게 비교 가능

Equatable를 준수함

Hashable를 준수하지 않는 타입이 있을 경우 hash(into:) 구현 필요
