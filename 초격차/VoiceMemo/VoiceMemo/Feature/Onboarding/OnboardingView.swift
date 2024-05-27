//
//  OnboardingView.swift
//  voiceMemo
//

import SwiftUI

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

// MARK: - 온보딩 컨텐츠 뷰
private struct OnboardingContentView: View {
    
    @ObservedObject private var onboardingViewModel = OnboardingViewModel()

    init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    fileprivate var body: some View {
        VStack{
            OnboardingCellListView(onboardingViewModel: onboardingViewModel)
            Spacer()
            StartButtonView()
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
}

fileprivate struct OnboardingCellListView: View {
    
    @ObservedObject private var onboardingViewModel = OnboardingViewModel()
    @State private var selectedIndex: Int
    
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = 0
    }
    
    var body: some View {
        // TODO: - 화면 전환 주석 필요
        TabView(selection: $selectedIndex) {
            ForEach(Array(onboardingViewModel.onboardingContents.enumerated()), id: \.element) { index, content in
                OnboardingCellView(onboardingContent: content)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        .background(
            selectedIndex % 2 == 0 ? Color.customSky : Color.customBackgroundGreen
        )
        .clipped()
    }
}

private struct OnboardingCellView: View {
    
    private var onboardingContent: OnboardingContent
    
    fileprivate init(onboardingContent: OnboardingContent) {
        self.onboardingContent = onboardingContent
    }
    
    fileprivate var body: some View {
        VStack{
            Image(onboardingContent.imageFileName)
                .resizable()
                .scaledToFit()
            HStack{
                Spacer()
                VStack{
                    Spacer()
                        .frame(height: 46)
                    Text(onboardingContent.title)
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                        .frame(height: 5)
                    Text(onboardingContent.subTitle)
                        .font(.system(size: 16))
                }
                .border(Color.black, width: 1)
                Spacer()
            }
            .background(Color.customWhite)
//            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        }
        .shadow(radius: 10)
    }
}

fileprivate struct StartButtonView:  View {
    // EnvironmentObject를 쓸 때는 변수 이름은 달라도 됨. 타입으로 environment objects타입을 찾아서 프로퍼티에 첨부
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate  var body: some View {
        Button( action: {
            pathModel.paths.append(.homeView)
        }, label: {
            HStack{
                Text("시작하기")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.customGreen)
                Image("startHome")
                    .renderingMode(.template)
                    .foregroundStyle(Color.customGreen)
            }
        })
        .padding(.bottom, 50)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        //      OnboardingCellView(onboardingContent: .init(imageFileName: "onboarding_1", title: "제목", subTitle: "부제목"))
//        OnboardingContentView(onboardingViewModel: OnboardingViewModel())
//        OnboardingContentView(onboardingViewModel: OnboardingViewModel())
        OnboardingView()
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
