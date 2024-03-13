# Codable, CodingKey

**`Codable`**과 **`CodingKey`**는 데이터 직렬화와 역직렬화를 간소화하는 도구이다.

여기서 직렬화(Serialization)란, 객체의 상태나 데이터 구조를 저장, 전송 가능한 형식(예: JSON, XML)으로 변환하는 과정을 말하고,
역직렬화는 그 역을 말한다.

# **Codable**

**`Codable`**은 Swift의 표준 라이브러리에서 제공하는 프로토콜로, **`Encodable`**과 **`Decodable`** 를 모두 충족하는 타입을 말한다.

**`Encodable`**은 Swift 객체를 외부 표현(e.g. JSON)으로 변환할 수 있게 해주며, **`Decodable`**은 외부 표현을 Swift 객체로 변환할 수 있게 해준다. 

이들을 활용해서, 복잡한 데이터 변환 작업을 간단하게 처리할 수 있다.

### 인코딩 예시:

```swift
import Foundation

struct User: Codable {
    var name: String
    var age: Int
    var email: String
}

// JSON 인코딩
let user: User = User(name: "홍길동", age: 24, email: "hong@example.com")
let encoder: JSONEncoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

// User 구조체의 encode(to:)가 내부적으로 호출
guard let jsonData = try? encoder.encode(user) else {
    return
}
guard let jsonString = String(data: jsonData, encoding: .utf8) else {
    return
}
print(jsonString)
```

```
{
  "name" : "홍길동",
  "email" : "hong@example.com",
  "age" : 24
}
```

### 디코딩 예시:

```swift
let jsonString = """
{
    "name": "홍길동",
    "age": 24,
    "email": "hong@example.com"
}
"""
guard let jsonData: Data = jsonString.data(using: .utf8) else {
    return
}
// User 구조체의 init이 내부적으로 호출
guard let user: User = try? JSONDecoder().decode(User.self, from: jsonData) else {
    return
}
print("name: \(user.name), age: \(user.age), email: \(user.email)")
```

```
이름: 홍길동, 나이: 24, 이메일: hong@example.com
```

이 방법은 주의할 점이 있는데, 모델의 프로퍼티 이름과 JSON의 키 이름이 완전히 일치해야 한다는 점이 그것이다.

둘의 이름을 다르게 하고 싶은 경우 **`CodingKey`**를 사용하여 구현할 수 있다.

# CodingKey

CodingKey 프로토콜은 Swift의 Codable 프로토콜과 함께 사용되며, 데이터 모델의 프로퍼티와 외부 데이터 형식(예: JSON) 사이의 매핑을 정의한다.

이 열거형은 **`String`** 타입을 채택하고, **`CodingKey`** 프로토콜을 준수하는 **`enum`**으로 정의되며, 각 **`case`**는 데이터 모델의 특정 프로퍼티를 대표한다.

일반적인 경우에**`init(from:)`**함수는 따로 구현하지 않아도 되는데, 구현이 필요한 경우는 다음과 같다.

- **복잡한 조건 또는 변환이 필요할 때:**
JSON 데이터 구조가 모델의 프로퍼티와 직접적으로 일치하지 않거나, 특정 필드가 조건에 따라 다르게 디코딩되어야 하는 경우
e.g. JSON 내 날짜 형식이 표준 **`ISO8601`** 형식이 아닌 경우, 커스텀 이니셜라이저에서 **`DateFormatter`**를 사용하여 해당 문자열을 **`Date`** 객체로 변환할 수 있음
- **`enum`의 이름으로 `CodingKeys`를 사용하지 않을 때:**
기본적으로 **`enum`**의 이름은 **`CodingKeys`**로 사용해야한다. 
다른 이름을 사용할 때는**`init(from:)`**에서 디코더의 **`container(keyedBy:)`** 메소드에 전달할 키 열거형의 타입을 직접 지정해야 한다.
그렇지 않으면 **`enum`**이 적용되지 않아서 프로퍼티와 json키 이름이 다를 경우 에러가 발생한다.
공부할 때 구분하기 위해서 잠깐 쓰는 것 말고는 그냥 **`CodingKeys`**쓰면 될 것 같다.

정리하자면 다음과 같다

|  | JSON, 프로퍼티 이름 같음 | JSON, 프로퍼티 이름 다름 |
| --- | --- | --- |
| 복잡한 자료형 X |  코딩키 X, init 명시 X |  코딩키 O, init 명시 X |
| 복잡한 자료형 O |  코딩키 X, init 명시 O |  코딩키 O, init 명시 O |

```swift
private enum UserKeys: String, CodingKey {
    case name, age, joinDate = "join_date"
}

init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self) // 커스텀 키 사용
// ...
```

### CodingKey 사용 예시:

**커스텀키 사용(init,** encode 메소드 구현**):**

```swift
struct User: Codable {

    var name: String
    var age: Int
    var emailAddress: String

    private enum JSONKeys: String, CodingKey {
        case name
        case age
        case emailAddress = "email" // JSON에서는 "email", 모델에서는 "emailAddress"로 사용
    }
    
    init(from decoder: Decoder) throws {
            // JSONKeys를 키로 사용하는 컨테이너 생성
        let container = try decoder.container(keyedBy: JSONKeys.self)
        
        // 각 프로퍼티를 디코딩
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        emailAddress = try container.decode(String.self, forKey: .emailAddress)
    }
    
    init(name: String, age: Int, emailAddress: String) {
        self.name = name
        self.age = age
        self.emailAddress = emailAddress
    }
    
    // 커스텀 인코딩 구현
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: JSONKeys.self)
        
        // 기본 프로퍼티 인코딩
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        
        // emailAddress를 "email" 키로 인코딩
        try container.encode(emailAddress, forKey: .emailAddress)
    }
    
}

// JSON 인코딩
let user = User(name: "홍길동", age: 24, emailAddress: "hong@example.com")
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

// User 구조체의 encode(to:)가 내부적으로 호출
guard let jsonData = try? encoder.encode(user) else {
    return
}
guard let jsonString = String(data: jsonData, encoding: .utf8) else {
    return
}
print(jsonString)

// JSON 디코딩
guard let jsonData = jsonString.data(using: .utf8) else {
    return
}
// User 구조체의 init이 내부적으로 호출
guard let user = try? JSONDecoder().decode(User.self, from: jsonData) else {
    return
}
print("name: \(user.name), age: \(user.age), emailAddress: \(user.emailAddress)")
```

```
{
  "name" : "홍길동",
  "email" : "hong@example.com",
  "age" : 24
}
name: 홍길동, age: 24, emailAddress: hong@example.com
```

**enum 이름으로** CodingKeys **사용:**

```swift
struct User: Codable {

    var name: String
    var age: Int
    var emailAddress: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case age
        case emailAddress = "email" // JSON에서는 "email", 모델에서는 "emailAddress"로 사용
    }
    
}

var jsonString = ""
// JSON 인코딩
let user = User(name: "홍길동", age: 24, emailAddress: "hong@example.com")
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

do {
    let jsonData = try encoder.encode(user)
    if let jsonStr = String(data: jsonData, encoding: .utf8) {
        print(jsonStr) // 인코딩된 JSON 문자열 출력
        jsonString = jsonStr
    }
} catch {
    print("인코딩 중 오류 발생: \(error)")
}

// JSON 디코딩
guard let jsonData = jsonString.data(using: .utf8) else {
    return
}
guard let user = try? JSONDecoder().decode(User.self, from: jsonData) else {
    return
}
print("name: \(user.name), age: \(user.age), emailAddress: \(user.emailAddress)")
```

```
{
  "email" : "hong@example.com",
  "age" : 24,
  "name" : "홍길동"
}
name: 홍길동, age: 24, emailAddress: hong@example.com
```

[복잡한 JSON decode하기](https://www.notion.so/JSON-decode-87e4b970dac74e989d811dbbf6c5d798?pvs=21)