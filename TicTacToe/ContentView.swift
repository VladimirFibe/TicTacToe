import SwiftUI

struct ContentView: View {
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isGameboardDisabled = false
    @State private var alertItem: AlertItem?
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(0..<9) { index in
                    ZStack {
                        Circle()
                            .fill(.red)
                        if let move = moves[index] {
                            Image(systemName: move.indicator)
                                .resizable()
                                .fontWeight(.bold)
                                .padding(35)
                                .foregroundStyle(.white)
                        }
                    }
                    .onTapGesture {
                        if moves[index] == nil {
                            moves[index] = Move(player: .human, index: index)
                            isGameboardDisabled = true
                            if checkWinCondition(for: .human, in: moves) {
                                alertItem = AlertContext.humanWin
                            }
                            
                            if checkForDraw(in: moves) {
                                alertItem = AlertContext.draw
                            }
                            if let empty = emptyIndex() {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    moves[empty] = Move(player: .computer, index: empty)
                                    isGameboardDisabled = false
                                    if checkWinCondition(for: .computer, in: moves) {
                                        alertItem = AlertContext.computerWin
                                    }
                                    if checkForDraw(in: moves) {
                                        alertItem = AlertContext.draw
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .disabled(isGameboardDisabled)
        .alert(item: $alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.buttonTitle, action: resetGame))
        })
        .padding()
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
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        isGameboardDisabled = false
    }
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let index: Int
    var indicator: String {
        switch player {
        case .human: return "xmark"
        case .computer: return "circle"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
