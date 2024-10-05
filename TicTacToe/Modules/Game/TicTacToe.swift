import UIKit

struct TicTacToe {
    var moves: [Move?] = Array(repeating: nil, count: 9)
    var isGameboardDisabled = false
    var gameRusult: GameResult?
    
    mutating func processPlayerMove(for index: Int) {
        if moves[index] == nil {
            moves[index] = Move(player: .human, index: index)
            isGameboardDisabled = true
            if checkWinCondition(for: .human, in: moves) {
                gameRusult = .win
            } else  if checkForDraw(in: moves) {
                gameRusult = .draw
            } else if let empty = emptyIndex() {
                moves[empty] = Move(player: .computer, index: empty)
                isGameboardDisabled = false
                if checkWinCondition(for: .computer, in: moves) {
                    gameRusult = .lose
                } else if checkForDraw(in: moves) {
                    gameRusult = .draw
                }
            }
        }
    }
    
    func emptyIndex() -> Int? {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                                          [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let computersMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computersPositions = Set(computersMoves.map { $0.index })
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computersPositions)
            if winPositions.count == 1,
               let index = winPositions.first,
               moves[index] == nil { return index }
        }
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let playerPositions = Set(playerMoves.map { $0.index })
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(playerPositions)
            if winPositions.count == 1,
               let index = winPositions.first,
               moves[index] == nil { return index }
        }
        if moves[4] == nil { return 4 }
        
        var results: [Int] = []
        for i in 0..<9 {
            if moves[i] == nil {
                results.append(i)
            }
        }
        return results.randomElement()
    }

    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                                          [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.index })
        for pattern in winPatterns where pattern.isSubset(of: playerPositions){
            return true
        }
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        moves.compactMap {$0}.count == 9
    }
    
    mutating func resetGame() {
        moves = Array(repeating: nil, count: 9)
        isGameboardDisabled = false
        gameRusult = nil
    }

}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let index: Int
    var indicator: UIImage {
        switch player {
        case .human: return .leaderboard
        case .computer: return .multiPlayer
        }
    }
}

enum GameResult {
    case win, lose, draw
    
    var title: String {
        switch self {
        case .win: return "You win!"
        case .lose: return "You lose!"
        case .draw: return "Draw!"
        }
    }
    
    var image: UIImage {
        switch self {
        case .win: return .win
        case .lose: return .lose
        case .draw: return .draw
        }
    }
}
