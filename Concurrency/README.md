# Concurrency

[iOS Concurrency(동시성) 프로그래밍](https://www.inflearn.com/course/iOS-Concurrency-GCD-Operation/dashboard)  
위 강의를 듣고 정리함

## 0-1강

동시성 프로그래밍이 필요한 이유

### 코어와 스레드

#### 코어:

CPU, 한번에 하나의 작업만 수행 가능, 여러개의 프로그램을 동시에 실행하는것은 시분할

#### 하드웨어 스레드:

운영체제의 최소 작업 단위  
동시에 실행 가능한 소프트웨어 스레드 개수와 같음

한 개의 스레드에만 일 시키면 버벅임 -> 어떻게 다른 스레드가 동시에 일하게 할 것인가?  
iOS에서는 직접적으로 스레드를 관리하지 않음(ex. 스레드 2번 생성).  
대신, Task를 대기행렬(queue, fifo)에 보내면 OS가 알아서 스레드를 찾아 분산시킴  
메인 스레드에서 하고 있던 일을 큐로 보내면 됨

## 0-2강

### GCD(Grand Central Dispatch), Operation

대기 큐에는 두가지가 있음  
GCD(Dispatch Queue), Operation queue

GCD / Operation을 사용해 시스템에서 알아서 쓰레드 숫자를 관리함  
쓰레드보다 더 높은 레벨/차원에서 작업하는 것
오래걸리는 작업들이 다른 스레드에서 비동기적으로 동작 하도록 함

#### GCD:

간단한 작업에 사용  
함수를 사용하는 작업(클로저로 묶을 수 있는 간단한 작업)

#### Operation queue:

데이터나 기능을 캡슐화 한 객체
조금 더 복잡한 작업에 사용됨(취소, 순서 지정, 일시중지, 상태추적)
클래스로 만들어진 객체로, 재사용하기 편함

### 큐로 작업 보내기

```swift
// 글로벌 큐에 비동기적으로 보냄
DispatchQueue.global().async {
    // 오퍼레이션, 작업의 한 단위
}
// 선언 후 사용
let queue = DispatchQueue.global()
queue.async { }
```

클로저 안의 코드들은 작업의 한 단위이기 때문에 순차적으로 실행됨

## 0-3강

Synchronous(동기) VS Asynchronous(비동기)

### 비동기

일을 시작시키고 작업이 끝날 때까지 기다리지 않음

```swift
DispatchQueue.global().async { }
```

원래의 작업이 진행되고 있던 곳(메인 스레드)에서  
디스패치 글로벌 큐로 보낸 작업을 기다리지 않음

### 동기

일을 시작시키고, 뿐만 아니라 작업이 끝날 때까지 기다림

```swift
DispatchQueue.global().sync { }
```

동기적으로 큐에 보내는 코드를 짜도 실질적으로는 메인스레드에서 일함

비동기 개념이 필요한 이유는 대부분 네트워크 작업 때문  
네트워크와 관련된 작업들은 내부적으로 비동기적으로 구현됨

```swift
URLSession(configuration: .ephemeral).dataTask(with: url) {
    data, response, error in self.image = UIImage(data: data!)
}
```

URLSession도 내부적으로 알아서 비동기 작업 수행

## 0-4강

Serial(직렬) VS Concurrent(동시)

### Serial Queue

(보통 메인에서) 분산처리 시킨 작업을 단 하나의 다른 스레드에서 처리하는 큐  
하나의 스레드로만 보내기 때문에 순서가 중요한 작업을 처리할 때 사용

### Concurrent Queue

(보통 메인에서) 분산처리 시킨 작업을 다른 여러 개의 스레드에서 처리하는 큐

몇개의 스레드로 분산할지는 시스템이 결정  
각자 독립적이지만 유사한 여러개의 작업을 처리할 때 사용  
ex. 테이블 뷰 셀에 이미지를 불러오기

## 2-1강

GCD(Dispatch Queue)의 종류와 특성

### Dispatch Queue

메인, 글로벌, 프라이빗(커스텀) 세 가지의 큐로 나뉨

### 메인 큐:

```swift
DispatchQueue.main.sync { }
```

메인 스레드 == 메인 큐  
유일함, 직렬 큐

```swift
//  2초 뒤에 메인스레드로 작업을 비동기적으로 보냄
DispatchQueue.main.asyncAfter( .now( ) + 2 ) { }
```

### 글로벌 큐:

```swift
DispatchQueue.global().async { }
```

기본 설정은 Concurrent  
Qos에 따라 6가지 종류로 나뉨

### Qos(Quality of Service)

작업의 우선 순위를 나타내는 시스템

실행되는 작업이 어떤 종류인지에 따라 시스템이 어떻게 리소스를 할당할지를 결정  
iOS가 우선 순위 인지해 우선도가 높은 작업에 더 많은 스레드를 배치,  
배터리를 집중적으로 사용함

아래는 글로벌 큐의 종류

#### global(qos: .userInteractive):

소요 시간: 거의 즉시  
유저와 직접적 인터렉티브: UI업데이트, 애니메이션, UI반응관련 어떤 것이든 (사용자와 상호 작용)

#### global(qos: .userInitiated):

소요 시간: 몇 초  
유저가 즉시 필요하긴 하지만, 비동기적으로 처리된 작업 (ex. 앱내에서 pdf파일을 여는 것과 같은)

#### global():

일반적인 작업

#### global(qos: .utility):

소요 시간: 몇 초에서 몇 분  
보통 Progress Indicator와 함께 길게 실행되는 작업, 계산, IO, Networking, 지속적인 데이터 feeds

#### global(qos: .background):

소요 시간: 몇 분 이상  
속도보다 에너지 효율 중시  
유저가 직접적으로 인지하지 않고(시간이 안 중요한) 작업, 데이터 미리가져오기, 데이터베이스 유지

#### global(qos: .unspecified):

legacy API

### 프라이빗(커스텀) 큐

기본은 serial queue (concurrnet 설정 가능)
qos OS가 추론(설정도 가능

```swift
// label에 String 저장해서 사용
// 프라이빗 글로벌 큐
let queue = DispatchQueue(label:"serial")
let queue2 = DispatchQueue(label:"concurrent", attributes: .concurrent)
queue.async { }
```

## 3-1강

디스패치 큐 사용시 주의사항

### UI 관련작업은 메인 큐에서만 처리

오래 걸리는 작업이어서 비동기로 처리하고 싶을 때,  
작업 안에 UI작업이 있을 경우는 다시 메인큐로 보내서 처리함

```swift
DispatchQueue.global().async {
    // 네트워크 작업
    DispatchQueue.main.async {
        // UI 변경 작업
    }
}
```

### 메인 큐에서 다른 큐로 보낼 때, sync 메서드 사용 금지

메인 큐에서는 항상 비동기적으로 보내야함  
동기적으로 시킬 경우, UI 작업이 멈추기 때문

```swift
// 현재 메인 큐에서 작업 중일 경우 sync 금지
DispatchQueue.global().sync { }
```

### 현재의 큐에서 현재의 큐로 동기적으로 보낼 수 없음

```swift
// 글로벌 큐에서 글로벌 큐로 동기적으로 보낼 경우,
// 블락시킨 스레드로 작업이 할당되어 교착상태가 발생 할 수 있음
// (직렬 큐일 경우에는 무조건 교착상태 발생)
DispatchQueue.global( ).async {
    DispatchQueue.global( ).sync {
    }
}
```

### weak, strong 캡쳐 주의 필요

약한 참조로 클로저 실행 시 뷰컨 사라지면 큐로 보낸 클로저 중단됨  
[강한 참조](https://beenii.tistory.com/115)클로저 실행 시 큐로 보낸 클로저 여전히 동작(사이클은 일어나지 않음)

### 비동기 작업에서 CompletionHandler의 존재 이유

작업이 아직 종료하지 않았는데 해당 값에 접근하면, 잘못된 값을 사용할 수 있음  
해당 비동기 작업이 끝났다는 것을 정확히 알려주는 시점이 컴플리션핸들러

### 동기함수를 비동기 함수로 만드는 방법

동기적 함수를 비동기적 함수로 바꿔서 지속적으로 사용할 수 있도록 만들기

1. 메인 작업을 실행할 큐
2. 후처리 작업을 실행할 큐
3. 컴플리션핸들러 필요
4. 에러처리에 대한 내용

```swift
func asyncTiltShift(_ inputImage: UIImage?, runQueue: DispatchQueue, completionQueue: DispatchQueue, completion: @escaping (UIImage?, Error?) -> ()) {
    // 메인 작업 실행할 큐
    runQueue.async {
        var error: Error?
        error = .none

        let outputImage = tiltShift(image: inputImage)
        // 후처리할 큐
        completionQueue.async {
            completion(outputImage, error)
        }
    }
}

// 메인 작업큐, 후처리 큐 정의
let workingQueue = DispatchQueue.main()
let resultQueue = DispatchQueue.global()

print("==== 비동기함수의 작업 시작 ====")
asyncTiltShift(image, runQueue: workingQueue, completionQueue: resultQueue) { image, error in
    image
    // completion핸들러에 들어갈 코드
    print("★★★비동기작업의 실제 종료시점★★★")
}
print("==== 비동기함수의 작업 끝 ====")
```
