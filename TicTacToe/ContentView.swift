import SwiftUI

struct ContentView: View {
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isGameboardDisabled = false
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
                                print("You win!!!")
                            }
                            if let empty = emptyIndex() {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    moves[empty] = Move(player: .computer, index: empty)
                                    isGameboardDisabled = false
                                    if checkWinCondition(for: .computer, in: moves) {
                                        print("You lose")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .disabled(isGameboardDisabled)
        .padding()
    }
    
    func emptyIndex() -> Int? {
        var results: [Int] = []
        for i in 0..<9 {
            if moves[i] == nil {
                results.append(i)
            }
        }
        return results.randomElement()
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.index })
        for pattern in winPatterns where pattern.isSubset(of: playerPositions){
            return true
        }
        return false
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
