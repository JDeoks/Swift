# Swift

## Basics

### StoryboardTest

로그인 화면 UI  
레이아웃 마진  
AutoShrink

### Scene-Transition

present, dismiss

### SubmitValue

다음 화면으로 데이터 전달

### SubmitValue-Back

커스텀 네비게이션바  
이전화면에 데이터 직접 전달, 저장소 이용 전달  
[UserDefaults](https://zeddios.tistory.com/107)

### Delegate-TextField

텍스트필드 속성  
First Responder  
텍스트필드 델리게이트

### UIImagePickerController

UIImagePickerController  
이미지피커 델리게이트  
익스텐션 구분  
// MARK:- 주석

### MyMovieChart

UITableViewController  
UITableViewDataSource  
Value Object  
dequeueReusableCell

### HW7.4

[nib 커스텀 테이블 셀](https://shark-sea.kr/entry/iOS-TableView-xib%EB%A1%9C-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0)  
[텍스트필드 테두리 곡률 설정](https://stackoverflow.com/questions/34007920/specify-border-radius-of-uitextfield-in-swift)  
[문자열 검색](https://beepeach.tistory.com/189)  
테이블 뷰 리로드

#### [키보드에 가려지는 텍스트 필드 이동](https://github.com/jrasmusson/ios-professional-course/blob/main/Password-Reset/7-Dealing-Keyboards/README.md) + 애니메이션

- SnapKit
- [keyboardAnimationCurveUserInfoKey](https://developer.apple.com/documentation/uikit/uiresponder/1621613-keyboardanimationcurveuserinfoke)
- UIView.animate(withDuration:delay:options:animations:completion:)
- [RxKeyboard 사용](https://velog.io/@dlskawns96/RxSwift-%ED%82%A4%EB%B3%B4%EB%93%9C%EA%B0%80-%EB%8B%A4%EB%A5%B8-View%EB%A5%BC-%EA%B0%80%EB%A6%AC%EB%8A%94-%EB%AC%B8%EC%A0%9C-%ED%95%B4%EA%B2%B0)

## Concurrency

[iOS Concurrency(동시성) 프로그래밍](https://www.inflearn.com/course/iOS-Concurrency-GCD-Operation/dashboard)
강의 정리
