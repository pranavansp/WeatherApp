//
//  WeatherAppRouter.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-08.
//

import Combine

typealias GeocodingUpdateHandler = (_ location: Geocoding) -> Void

class WeatherAppRouter {
    
    enum RoutingAction {
        case searchView(updateHandler: GeocodingUpdateHandler)
        case backToHome
    }
    
    // MARK: - Internal
    let routingActionSubject: PassthroughSubject<RoutingAction, Never> = PassthroughSubject()
    private var cancellable: Set<AnyCancellable> = []
    
    // MARK: - View model listeners
    let landingViewActionSubject : PassthroughSubject<DefaultLandingViewModel.LandingViewModelAction, Never> = PassthroughSubject()
    let searchViewActionSubject : PassthroughSubject<DefaultSearchViewModel.SearchViewModelAction, Never> = PassthroughSubject()
    
    init() {
        landingViewActionSubject
            .sink { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .onTapSearch(let updateHandler):
                    self.routingActionSubject.send(.searchView(updateHandler: updateHandler))
                }
            }
            .store(in: &cancellable)
        
        searchViewActionSubject
            .sink { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .didSelect:
                    self.routingActionSubject.send(.backToHome)
                }
            }
            .store(in: &cancellable)
    }
}
