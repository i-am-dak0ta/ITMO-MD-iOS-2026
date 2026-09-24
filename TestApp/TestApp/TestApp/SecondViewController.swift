import UIKit

class SecondViewController: UIViewController {

    private let number: Int

    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(number: Int) {
        self.number = number
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Второй экран"

        label.text = "Если забыл, то твое число: \(number)"

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            label.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            label.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 30
            ),
            label.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -30
            )
        ])
    }
}
