//
//  DefaultSearchViewModel.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-07.
//

import Combine
import Foundation

class DefaultSearchViewModel: SearchViewModel {
    
    // MARK: - Internal
    @Published var searchKeyword: String = ""
    @Published var resultArray: [Geocoding] = []
    
    @MainActor @Published var isLoading: Bool = true
    @Published var error: NetworkError? = nil
    
    // MARK: - Private
    private var cancellable: Set<AnyCancellable> = []
    private let dataSource: SearchDataSourceProtocol
    
    // MARK: - Init
    init(dataSource: SearchDataSourceProtocol = SearchDataSource()) {
        self.dataSource = dataSource
        self.bind()
    }
    
    // MARK: - Bind
    private func bind(dueTime: TimeInterval = 0.8) {
        $searchKeyword
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .throttle(for: .seconds(dueTime), scheduler: DispatchQueue.main, latest: true)
            .sink { keyword in
                Task { [weak self] in
                    await self?.fetchLocation(by: keyword)
                }
            }
            .store(in: &cancellable)
    }
    
    // MARK: - fetch locations
    func fetchLocation(by keyword: String) async {
        Task { [weak self] in
            guard let self = self else { return }
            await MainActor.run {
                self.isLoading = true
            }
            do {
                let dataSourceFetch =  try await dataSource.getLocation(by: keyword)
                await MainActor.run {
                    self.resultArray = dataSourceFetch
                    self.isLoading = false
                }
            } catch {
                NSLog("Error: %@", error.localizedDescription)
                await MainActor.run {
                    self.isLoading = false
                    self.error = .network(error: error)
                }
            }
        }
    }
}
