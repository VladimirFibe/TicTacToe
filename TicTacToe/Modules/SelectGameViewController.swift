import UIKit

final class SelectGameViewController: UIViewController {
    private let buttonsView = UIStackView()
    private let labelSelectGame = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .basicBackground
        setupNavBar()
        setupBackgroundView()
        setLabelSelectGame()
        setButtonsView()
    }

    @objc private func playTapped() {
        self.navigationController?.pushViewController(SelectGameViewController(), animated: true)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func settingsButtonTapped() {
//        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    

    @objc private func startGame(_ sender: UIButton) {
//        self.navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
    @objc private func pushLeaderboard() {
//        self.navigationController?.pushViewController(LeaderboardViewController(), animated: true)
    }
}

private extension SelectGameViewController {
    func setupNavBar() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .setting,
            style: .plain,
            target: self,
            action: #selector(settingsButtonTapped)
        )
    }
    
    func setLabelSelectGame () {
        labelSelectGame.text = "Select Game"
        labelSelectGame.textColor = .black
        labelSelectGame.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        labelSelectGame.textAlignment = .center
    }
    
    func setupBackgroundView() {
        let backgroundView = UIView()
        view.addSubview(backgroundView)
        backgroundView.addSubview(labelSelectGame)
        backgroundView.addSubview(buttonsView)
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        labelSelectGame.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = 30
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 0.150
        backgroundView.layer.shadowOffset = CGSize(width: 4, height: 4)
        backgroundView.layer.shadowRadius = 10
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 51),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -51),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelSelectGame.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            labelSelectGame.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            labelSelectGame.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            buttonsView.topAnchor.constraint(equalTo: labelSelectGame.bottomAnchor, constant: 20),
            buttonsView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            buttonsView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            buttonsView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20)
        ])
    }
    func setButtonsView() {
        buttonsView.axis = .vertical
        buttonsView.distribution = .fillEqually
        buttonsView.alignment = .fill
        buttonsView.spacing = 20
        SelectGameButtons.allCases.forEach { item in
            let button = UIButton(type: .system)
            var config = UIButton.Configuration.filled()
            config.title = item.title
            config.baseBackgroundColor = item.color
            config.baseForegroundColor = .black
            config.cornerStyle = .capsule
            config.image = item.image
            config.imagePadding = 9
            config.titleTextAttributesTransformer =
              UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                  outgoing.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
                return outgoing
              }
            button.configuration = config
            button.addAction(
              UIAction {[weak self] _ in
                  switch item {
                  case .singlePlayer: print(item.title)
                  case .multiPlayer: print(item.title)
                  case .leaderboard:
                      self?.navigationController?.pushViewController(
                        RulesViewController(),
                        animated: true
                      )
                  }
              },
              for: .primaryActionTriggered
            )
            button.heightAnchor.constraint(equalToConstant: 64).isActive = true
            buttonsView.addArrangedSubview(button)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: SelectGameViewController())
}

enum SelectGameButtons: CaseIterable {
    case singlePlayer
    case multiPlayer
    case leaderboard
    
    var title: String {
        switch self {
        case .singlePlayer: return "Single Player"
        case .multiPlayer: return "Two Players"
        case .leaderboard: return "Leaderboard"
        }
    }
    
    var color: UIColor {
        switch self {
        case .leaderboard: return .secondaryPurple
        default: return .basicLightBlue
        }
    }
    
    var image: UIImage {
        switch self {
        case .singlePlayer: return .singlePlayer
        case .multiPlayer: return .multiPlayer
        case .leaderboard: return .leaderboard
        }
    }
}
