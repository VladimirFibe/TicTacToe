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
        
    }
    
    @objc private func settingsTapped() {
        
    }
    
    @objc private func primaryButtonTapped() {
        
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
        primaryButton.setTitle("Let’s play", for: [])
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            primaryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: OnboardingViewController())
}
