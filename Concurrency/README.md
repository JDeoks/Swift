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
GCD(DispatchQueue), Operation queue

GCD / Operation을 사용해 시스템에서 알아서 쓰레드 숫자를 관리함  
쓰레드보다 더 높은 레벨/차원에서 작업하는 것
오래걸리는 작업들이 다른 스레드에서 비동기적으로 동작 하도록 함

#### GCD:

간단한 작업에 사용  
함수를 사용하는 작업(클로저로 묶을 수 있는 간단한 작업)

#### Operation queue:

데이터나 기능을 캡슐화 한 객체
조금 더 복잡한 작업에 사용됨(취소, 순서 지정, 일시중지(상태추적))
클래스로 만들어진 객체로, 재사용하기 편함

### 큐로 작업 보내기

```swift
// 글로벌 큐에 비동기적으로 보냄
DispatchQueue.global().async {
    // 오퍼레이션, 작업의 한 단위
}
// 선언 후 사용
let queue = DispatchQueue.global()
queue.async {}
```

클로저 안의 코드들은 작업의 한 단위이기 때문에 순차적으로 실행됨

## 0-3강

Synchronous(동기) VS Asynchronous(비동기)

### 비동기

일을 시작시키고 작업이 끝날 때까지 기다리지 않음

```swift
DispatchQueue.global().async
```

원래의 작업이 진행되고 있던 곳(메인 스레드)에서  
디스패치 글로벌 큐로 보낸 작업을 기다리지 않음

### 동기

일을 시작시키고, 뿐만 아니라 작업이 끝날 때까지 기다림

```swift
DispatchQueue.global().sync
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
