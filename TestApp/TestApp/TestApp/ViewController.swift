import UIKit

class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let generateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сгенерировать число", for: .normal)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Второй экран", for: .normal)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Первый экран"

        setupViews()
        setupConstraints()
        bindViewModel()

        generateButton.addTarget(
            self,
            action: #selector(generateButtonTapped),
            for: .touchUpInside
        )

        nextButton.addTarget(
            self,
            action: #selector(nextButtonTapped),
            for: .touchUpInside
        )
    }

    private func setupViews() {
        view.addSubview(imageView)
        view.addSubview(numberLabel)
        view.addSubview(generateButton)
        view.addSubview(nextButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            // Картинка
            imageView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            imageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 40
            ),
            imageView.widthAnchor.constraint(
                equalToConstant: 200
            ),
            imageView.heightAnchor.constraint(
                equalToConstant: 200
            ),

            // Число
            numberLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            numberLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: 30
            ),

            // Первая кнопка
            generateButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            generateButton.topAnchor.constraint(
                equalTo: numberLabel.bottomAnchor,
                constant: 30
            ),

            // Вторая кнопка
            nextButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            nextButton.topAnchor.constraint(
                equalTo: generateButton.bottomAnchor,
                constant: 20
            )
        ])
    }

    private func bindViewModel() {
        viewModel.onUiStateChange = { [weak self] state in
            self?.render(state)
        }

        viewModel.onRoute = { [weak self] route in
            self?.navigate(to: route)
        }

        render(viewModel.uiState)
    }

    private func render(_ state: MainUiState) {
        numberLabel.text = state.numberText
    }

    private func navigate(to route: MainRoute) {
        switch route {
        case .secondScreen(let number):
            let secondViewController = SecondViewController(
                number: number
            )

            navigationController?.pushViewController(
                secondViewController,
                animated: true
            )
        }
    }

    @objc private func generateButtonTapped() {
        viewModel.handle(.generateButtonTapped)
    }

    @objc private func nextButtonTapped() {
        viewModel.handle(.nextButtonTapped)
    }
}
