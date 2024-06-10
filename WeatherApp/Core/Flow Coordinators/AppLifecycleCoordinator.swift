//
//  AppLifecycleCoordinator.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-08.
//

import UIKit
import Combine
import SwiftUI

class AppLifecycleCoordinator: ObservableObject {
    
    // MARK: - Private
    private var cancellable: Set<AnyCancellable> = []
    private let window: UIWindow?
    private var navigationController: UINavigationController?
    private let actionRouter = WeatherAppRouter()
    
    init(window: UIWindow?) {
        self.window = window
        defer {
            self.startObservers()
        }
    }
    
    private func startObservers() {
        actionRouter
            .routingActionSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .searchView(let updateHandler):
                    self.navigateToSearch(updateHandler: updateHandler)
                case .backToHome:
                    self.pop(animated: true)
                }
            }
            .store(in: &cancellable)
    }
    
    func startLanding() {
        let dataSource = LandingDataSource()
        let viewModel = DefaultLandingViewModel(dataSource: dataSource)
        viewModel.actionPublisher
            .subscribe(actionRouter.landingViewActionSubject)
            .store(in: &cancellable)
        let landingView = LandingView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: landingView)
        self.navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = self.navigationController
    }
    
    private func navigateToSearch(updateHandler: @escaping GeocodingUpdateHandler) {
        let dataSource = SearchDataSource()
        let viewModel = DefaultSearchViewModel(dataSource: dataSource, updateHandler: updateHandler)
        viewModel.actionPublisher
            .subscribe(actionRouter.searchViewActionSubject)
            .store(in: &cancellable)
        let searchView = SearchView(viewModel: viewModel)
        show(searchView, animated: true)
    }
    
    private func show(_ view: some View, animated: Bool = true) {
        let viewController = UIHostingController(rootView: view)
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    private func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
}
