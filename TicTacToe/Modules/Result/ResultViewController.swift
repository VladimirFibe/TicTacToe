import UIKit

final class ResultViewController: UIViewController {
    private let result: GameResult
    private let resultImageView = UIImageView()
    private let playAgainButton = UIButton()
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    init(result: GameResult) {
        self.result = result
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.setHidesBackButton(true, animated: false)
        setupReslultImageView()
        setupTitleLabel()
        setupPlayAgainButton()
        setupBackButton()
    }
}

private extension ResultViewController {
    func setupReslultImageView() {
        view.addSubview(resultImageView)
        resultImageView.translatesAutoresizingMaskIntoConstraints = false
        resultImageView.image = result.image
        NSLayoutConstraint.activate([
            resultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = result.title
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: resultImageView.topAnchor, constant: -20)
        ])
    }
    
    func setupPlayAgainButton() {
        view.addSubview(playAgainButton)
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        playAgainButton.setTitle("Play again", for: .normal)
        playAgainButton.setTitleColor(.white, for: .normal)
        playAgainButton.backgroundColor = .basicBlue
        playAgainButton.layer.cornerRadius = 30
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        playAgainButton.addTarget(self, action: #selector (playAgainButtonTapped), for: .primaryActionTriggered)
        playAgainButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        NSLayoutConstraint.activate([
            playAgainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            playAgainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            playAgainButton.heightAnchor.constraint(equalToConstant: 72),
        ])
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.basicBlue, for: .normal)
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.basicBlue.cgColor
        backButton.layer.borderWidth = 2
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector (backButtonTapped), for: .primaryActionTriggered)
        backButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            backButton.heightAnchor.constraint(equalToConstant: 72),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            backButton.topAnchor.constraint(equalTo: playAgainButton.bottomAnchor, constant: 12)
        ])
    }
    
    @objc func playAgainButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ResultViewController(result: .draw))
}
