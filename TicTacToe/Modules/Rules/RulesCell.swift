import UIKit

final class RulesCell: UITableViewCell {
    static let identifier = "RulesCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupIndexBackGround()
        setupLabelBackGround()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let indexBackGround = UIView()
    private let labelBackGround = UIView()
    private let label = UILabel()
    private let indexLabel = UILabel()
    public func configure(with text: String, index: String) {
        label.text = text
        indexLabel.text = index
    }
}

private extension RulesCell {
    func setupIndexBackGround() {
        contentView.addSubview(indexBackGround)
        indexBackGround.addSubview(indexLabel)
        indexBackGround.layer.cornerRadius = 22.5
        indexBackGround.backgroundColor = .basicLightBlue
        indexBackGround.translatesAutoresizingMaskIntoConstraints = false
        indexLabel.translatesAutoresizingMaskIntoConstraints = false
        indexLabel.font = .systemFont(ofSize: 20, weight: .regular)
        NSLayoutConstraint.activate([
            indexBackGround.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            indexBackGround.topAnchor.constraint(equalTo: contentView.topAnchor),
            indexBackGround.heightAnchor.constraint(equalToConstant: 45),
            indexBackGround.widthAnchor.constraint(equalTo: indexBackGround.heightAnchor),
            indexLabel.centerXAnchor.constraint(equalTo: indexBackGround.centerXAnchor),
            indexLabel.centerYAnchor.constraint(equalTo: indexBackGround.centerYAnchor)
        ])
    }
    func setupLabelBackGround() {
        contentView.addSubview(labelBackGround)
        labelBackGround.layer.cornerRadius = 30
        labelBackGround.addSubview(label)
        labelBackGround.backgroundColor = .basicLightBlue
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        labelBackGround.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelBackGround.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelBackGround.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            labelBackGround.leadingAnchor.constraint(equalTo: indexBackGround.trailingAnchor, constant: 20),
            labelBackGround.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: labelBackGround.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: labelBackGround.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: labelBackGround.trailingAnchor, constant: -24),
            label.bottomAnchor.constraint(equalTo: labelBackGround.bottomAnchor, constant: -12)
        ])
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: RulesViewController())
}
