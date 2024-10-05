import UIKit

final class GameViewContoller: UIViewController {
    private var game = TicTacToe() { didSet { updateUI() }}
    private let singlePlayerGame: Bool
    private var buttons = [UIButton]()
    private let buttonsView = UIStackView()
    init(singlePlayerGame: Bool) {
        self.singlePlayerGame = singlePlayerGame
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = .basicBackground
        setupBackgroundView()
        setButtonsView()
    }
    
    private func setupNavBar() {
        navigationItem.title = singlePlayerGame ? "Single Player" : "Multiplayer"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .backButtonIcon,
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

private extension GameViewContoller {
    func setupBackgroundView() {
        let backgroundView = UIView()
        view.addSubview(backgroundView)
        backgroundView.addSubview(buttonsView)
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = 30
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 0.150
        backgroundView.layer.shadowOffset = CGSize(width: 4, height: 4)
        backgroundView.layer.shadowRadius = 10
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 51),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -51),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: backgroundView.widthAnchor),
            buttonsView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
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
        for i in 0..<3 {
            let stackView = UIStackView()
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            stackView.spacing = 20
            for j in 0..<3 {
                let button = UIButton(type: .system)
                button.tag = i * 3 + j
                button.backgroundColor = .basicLightBlue
                button.layer.cornerRadius = 20
                button.layer.masksToBounds = true
                button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
                buttons.append(button)
                stackView.addArrangedSubview(button)
            }
            buttonsView.addArrangedSubview(stackView)
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        game.processPlayerMove(for: sender.tag)
        if let result = game.gameRusult {
            game.resetGame()
            let controller = ResultViewController(result: result)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func updateUI() {
        buttons.forEach {
            $0.setBackgroundImage(game.moves[$0.tag]?.indicator, for: .normal)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: GameViewContoller(singlePlayerGame: false))
}
