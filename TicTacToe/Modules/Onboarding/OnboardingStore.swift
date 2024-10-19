import Combine
import FirebaseAuth

enum OnboardingEvent {
    case done
}

enum OnboardingAction {
    case login
}

final class OnboardingStore: Store<OnboardingEvent, OnboardingAction> {
    override func handleActions(action: OnboardingAction) {
        switch action {
        case .login:
            statefulCall {
                try await self.login()
            }
        }
    }
    
    private func login() async throws {
        if Auth.auth().currentUser == nil {
            let authResult = try await Auth.auth().signInAnonymously()
        }
    }
}
