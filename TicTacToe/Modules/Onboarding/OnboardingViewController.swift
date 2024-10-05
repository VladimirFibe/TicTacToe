import UIKit

class OnboardingViewController: UIViewController {
    private let onboardingImageView = UIImageView()
    private let primaryButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavBar()
        setupOnboardingImageView()
        setupPrimaryButton()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .rules,
            style: .plain,
            target: self,
            action: #selector(rulesTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .setting,
            style: .plain,
            target: self,
            action: #selector(rulesTapped)
        )
    }
    
    @objc private func rulesTapped() {
        let controller = RulesViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func settingsTapped() {
        
    }
    
    @objc private func primaryButtonTapped() {
        navigationController?.pushViewController(SelectGameViewController(), animated: true)
    }
}

private extension OnboardingViewController {
    func setupOnboardingImageView() {
        view.addSubview(onboardingImageView)
        onboardingImageView.image = .onboarding
        onboardingImageView.contentMode = .scaleAspectFit
        onboardingImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupPrimaryButton() {
        view.addSubview(primaryButton)
        var config = UIButton.Configuration.filled()
        config.title = "Let’s play"
        config.baseBackgroundColor = .basicBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
              outgoing.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            return outgoing
          }
        primaryButton.configuration = config
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            primaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            primaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            primaryButton.heightAnchor.constraint(equalToConstant: 72),
            primaryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: OnboardingViewController())
}
