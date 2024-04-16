//
//  OnboardingView.swift
//  voiceMemo
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        // TODO: - 화면 전환 주석 필요
        Text("Onboarding")
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
    fileprivate  var body: some View {
        Button(
            action: {
            
        }, 
            label: {
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
        OnboardingContentView(onboardingViewModel: OnboardingViewModel())
    }
}
