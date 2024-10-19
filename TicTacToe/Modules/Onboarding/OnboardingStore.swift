import Combine
import FirebaseAuth
import FirebaseFirestore

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
            try await createPerson(with: authResult.user.uid)
        } 
    }
    
    func createPerson(with uid: String) async throws {
        let person = Person(id: uid, name: "Player \(Int.random(in: 0..<1000))")
        try Firestore.firestore().collection("persons").document(uid).setData(from: person)
    }
}
