import Foundation

struct MainUiStateMapper {

    func map(_ dataState: MainDataState) -> MainUiState {
        MainUiState(
            numberText: "\(dataState.number)"
        )
    }
}
