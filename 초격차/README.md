## AVFoundation

시청각 에셋 작업, 카메라 제어, 오디오 처리, 시스템 오디오 상호작용을 구성하는 프레임워크

#### AVCaptureSession:

카메라를 사용하여 사진이나 비디오를 촬영하기 위한 기능을 제공.  
카메라의 입력을 관리하고, 미디어를 캡처할 수 있음

#### AVCaptureDevice:

카메라나 마이크와 같은 하드웨어나 가상 캡처 장치를 참조하는 데이터형
AVCaptureSession과 AVCaptureDevice를 사용하여 사진이나 비디오를 촬영가능

#### AVAudioEngine:

Audio Node의 그래프를 관리하고, 재생을 제어하고, 실시간 렌더링 제약 조건을 구성함  
다양한 종류의 오디오 노드를 제공 (ex. AVAudioPlayerNode, AVAudioUnitEffect)

#### Audio Node:

AVAudioEngine에서 오디오 처리 또는 재생을 담당하는 기본 단위

#### [AVAudioPlayerNode:](https://devddong.tistory.com/35)

오디오 파일을 재생 .wav, .mp3 등의 일반적인 오디오 파일 포맷을 지원
재생 제어, 볼륨 피치 조절, 반복재생 지원

#### AVAudioSession:

오디오 관련 설정과 제어를 담당하는 시스템 레벨의 인터페이스  
앱이 오디오를 사용하는 방법 정의, 다른 오디오 앱 또는 시스템과의 상호 작용 관리 가능

- 오디오 입력 및 출력 관리:
  마이크 또는 다른 오디오 입력 장치를 사용하여 오디오를 캡처 or 스피커 또는 다른 오디오 출력 장치를 사용하여 오디오를 재생하는 것을 관리
- 오디오 카테고리 설정:  
  앱이 어떤 상황에서 사용되는지 카테고리를 설정 가능  
  음악 재생: AVAudioSessionCategoryPlayback  
  전화 통화: AVAudioSessionCategorySoloAmbient
- 오디오 포커스 처리:  
  다른 앱이나 시스템에서 오디오 포커스를 가져갈 때, 어떻게 반응할 지 정의. 여러 앱이 동시에 오디오를 사용가능하게 함
- 오디오 세션 상태 모니터링:  
  현재 오디오 세션의 상태를 모니터링. 이를 통해 오디오 세션의 변경에 대응 가능

## AVKit

미디어 컨텐츠를 표시하고 제어하는 UI 컴포넌트를 제공한는 프레임워크
