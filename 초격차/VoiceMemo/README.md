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

`@Published` 로 선언된 프로퍼티의 값이 변경될 때마다 `objectWillChange` 를 통해 방출됨

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

뷰를 pop할 때 하위뷰에서 pathModel 접근이 필요함.

따라서 environmentObject로 넘겨줌
