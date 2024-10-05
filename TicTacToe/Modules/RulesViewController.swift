import UIKit

class RulesViewController: UIViewController {
    
    let rules: [String] = ["Draw a grid with three rows and three columns, creating nine squares in total.", "Players take turns placing their marker (X or O) in an empty square.\nTo make a move, a player selects a number corresponding to the square where they want to place their marker.", "Player X starts by choosing a square (e.g., square 5).\nPlayer O follows by choosing an empty square (e.g., square 1).\nContinue alternating turns until the game ends.", "The first player to align three of their markers horizontally, vertically, or diagonally wins.\nExamples of Winning Combinations:\nHorizontal: Squares 1, 2, 3 or 4, 5, 6 or 7, 8, 9\nVertical: Squares 1, 4, 7 or 2, 5, 8 or 3, 6, 9\nDiagonal: Squares 1, 5, 9 or 3, 5, 7"]
        
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "How to Play"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .backButtonIcon,
            style: .plain,
            target: self,
            action: #selector(back)
        )
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.register(RulesCell.self, forCellReuseIdentifier: RulesCell.identifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
}

extension RulesViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        rules.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RulesCell.identifier,
            for: indexPath
        ) as? RulesCell else {
            fatalError()
        }
        cell.configure(with: rules[indexPath.row], index: "\(indexPath.row + 1)")
        return cell
    }
}
