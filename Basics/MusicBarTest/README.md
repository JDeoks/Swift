# 음악 재생바 UIScreen에 직접 추가

<img src="/Users/jeongdeok/git/Swift/Basics/MusicBarTest/스크린샷 2024-09-06 00.57.32.png">
```
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var musicBarView: UIView?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
        // 기본 앱 창 설정
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()

        // 음악 바 뷰 추가
        setupMusicBarView(tabBarController: vc)
    }

    // 음악 바 UIView 설정 (탭바 위에 붙이기)
    func setupMusicBarView(tabBarController: UITabBarController) {
        let musicBarHeight: CGFloat = 80

        // 탭바의 높이 계산
        let tabBarHeight = tabBarController.tabBar.frame.size.height

        // 음악 바 설정
        musicBarView = UIView()
        musicBarView?.backgroundColor = .red
        musicBarView?.translatesAutoresizingMaskIntoConstraints = false
        window?.addSubview(musicBarView!)

        // 음악 바 오토레이아웃 설정
        NSLayoutConstraint.activate([
            musicBarView!.leadingAnchor.constraint(equalTo: window!.leadingAnchor),
            musicBarView!.trailingAnchor.constraint(equalTo: window!.trailingAnchor),
            musicBarView!.bottomAnchor.constraint(equalTo: window!.bottomAnchor, constant: -tabBarHeight),
            musicBarView!.heightAnchor.constraint(equalToConstant: musicBarHeight)
        ])
    }

}

```
탭바 크기 계산해서 uiwindow에 바로 서브뷰로 추가
```
