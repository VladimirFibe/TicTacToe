import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            LazyVGrid(columns: viewModel.columns) {
                ForEach(0..<9) { index in
                    GameCellView(move: viewModel.moves[index])
                    .onTapGesture {
                        viewModel.processPlayerMove(for: index)
                    }
                }
            }
        }
        .disabled(viewModel.isGameboardDisabled)
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.buttonTitle,
                                          action: viewModel.resetGame))
        })
        .padding()
    }
}

struct GameCellView: View {
    let move: Move?
    var body: some View {
        ZStack {
            Circle()
                .fill(.red)
            if let move {
                Image(systemName: move.indicator)
                    .resizable()
                    .fontWeight(.bold)
                    .padding(35)
                    .foregroundStyle(.white)
            }
        }
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
        GameView()
    }
}
