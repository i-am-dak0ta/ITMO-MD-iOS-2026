import Foundation

final class MainViewModel {

    var onUiStateChange: ((MainUiState) -> Void)?
    var onRoute: ((MainRoute) -> Void)?

    private(set) var uiState: MainUiState

    private var dataState: MainDataState {
        didSet {
            uiState = mapper.map(dataState)
            onUiStateChange?(uiState)
        }
    }

    private let mapper: MainUiStateMapper

    init(mapper: MainUiStateMapper = MainUiStateMapper()) {
        let initialDataState = MainDataState(number: 0)

        self.mapper = mapper
        self.dataState = initialDataState
        self.uiState = mapper.map(initialDataState)
    }

    func handle(_ event: MainUiEvent) {
        switch event {
        case .generateButtonTapped:
            dataState.number = Int.random(in: 1...100)
        case .nextButtonTapped:
            onRoute?(.secondScreen(number: dataState.number))
        }
    }
}
