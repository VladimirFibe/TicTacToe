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
    var person: Person?
    var player: Person?
    
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
        let querySnapshot = try await Firestore.firestore().collection("persons").document(id).getDocument()
        person = try? querySnapshot.data(as: Person.self)
        let query = try await Firestore.firestore().collection("players")
            .whereField("id", isNotEqualTo: id)
            .limit(to: 50).getDocuments()
        let persons = query.documents.compactMap { try? $0.data(as: Person.self)}
        if persons.isEmpty {
            guard let person else { return }
            try Firestore.firestore().collection("players").document(id).setData(from: person)
        } else {
            player = persons.first
            guard let uid = player?.id else { return }
            try await Firestore.firestore().collection("players").document(uid).delete()
            print("person: ", person?.id ?? "empty")
            print("player: ", player?.id ?? "empty")
        }
    }
}
