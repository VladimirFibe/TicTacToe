import Combine
import FirebaseFirestore
import FirebaseAuth

enum GameEvent {
    case done
}

enum GameAction {
    case fetch
}

final class GameStore: Store<GameEvent, GameAction> {
    override func handleActions(action: GameAction) {
        switch action {
        case .fetch:
            statefulCall {
                try await self.fetch()
            }
        }
    }
    
    private func fetch() async throws {
        guard let id = Auth.auth().currentUser?.uid else { return }
        let query = try await Firestore.firestore().collection("players")
            .whereField("id", isNotEqualTo: id)
            .limit(to: 50).getDocuments()
        let persons = query.documents.compactMap { try? $0.data(as: Person.self)}
        if persons.isEmpty {
            try await addPlayer(with: id)
        }
    }
    
    private func addPlayer(with uid: String) async throws {
        let querySnapshot = try await Firestore.firestore().collection("persons").document(uid).getDocument()
        if let person = try? querySnapshot.data(as: Person.self) {
            try Firestore.firestore().collection("players").document(uid).setData(from: person)
        }
    }
}
