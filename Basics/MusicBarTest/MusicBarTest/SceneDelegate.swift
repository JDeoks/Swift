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
        
        // 트랙 이름 라벨 추가
        let trackLabel = UILabel()
        trackLabel.text = "Sample Track"
        trackLabel.textColor = .white
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        musicBarView?.addSubview(trackLabel)
        
        // 재생/일시정지 버튼 추가
        let playPauseButton = UIButton(type: .system)
        playPauseButton.setTitle("Play", for: .normal)
        playPauseButton.setTitleColor(.white, for: .normal)
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        musicBarView?.addSubview(playPauseButton)
        
        // 음악 바 내부 오토레이아웃 설정
        NSLayoutConstraint.activate([
            trackLabel.leadingAnchor.constraint(equalTo: musicBarView!.leadingAnchor, constant: 16),
            trackLabel.centerYAnchor.constraint(equalTo: musicBarView!.centerYAnchor),
            
            playPauseButton.trailingAnchor.constraint(equalTo: musicBarView!.trailingAnchor, constant: -16),
            playPauseButton.centerYAnchor.constraint(equalTo: musicBarView!.centerYAnchor)
        ])
    }

    @objc func playPauseTapped(_ sender: UIButton) {
        if sender.title(for: .normal) == "Play" {
            sender.setTitle("Pause", for: .normal)
            print("Music Playing")
        } else {
            sender.setTitle("Play", for: .normal)
            print("Music Paused")
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
