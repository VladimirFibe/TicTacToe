import SwiftUI

struct ContentView: View {
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
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
                            if let empty = emptyIndex() {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    moves[empty] = Move(player: .computer, index: empty)
                                }
                            }
                        }
                    }
                }
            }
        }
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
