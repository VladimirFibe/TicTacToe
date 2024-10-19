import UIKit

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
