//
//  DefaultSearchViewModel.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-07.
//

import Combine
import Foundation

final class DefaultSearchViewModel: SearchViewModel {
    
    // MARK: - Actions
    enum SearchViewModelAction {
        case didSelect
    }
    
    // MARK: - Internal
    @Published var searchKeyword: String = ""
    @Published var resultArray: [Geocoding] = []
    
    @MainActor @Published var isLoading: Bool = true
    @Published var error: NetworkError? = nil
    @Published var showErrorAlert: Bool = false
    
    // MARK: - Private
    private let dataSource: SearchDataSourceProtocol
    private var geocodingUpdateHandler: GeocodingUpdateHandler
    private var cancellable: Set<AnyCancellable> = []
    
    // MARK: - Init
    init(dataSource: SearchDataSourceProtocol, updateHandler: @escaping GeocodingUpdateHandler) {
        self.dataSource = dataSource
        self.geocodingUpdateHandler = updateHandler
        self.bind()
    }
    
    //MARK: Private (set)
    private (set) var actionPublisher: PassthroughSubject<SearchViewModelAction, Never> = PassthroughSubject()
    
    // MARK: - Bind
    private func bind() {
        $searchKeyword
            .removeDuplicates()
            .throttle(for: .seconds(0.8), scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] keyword in
                guard let self = self else { return }
                self.startFetch(for: keyword)
            }
            .store(in: &cancellable)
    }
    
    // MARK: - Internal
    
    func selectLocation(location: Geocoding) {
        self.geocodingUpdateHandler(location)
        self.actionPublisher.send(.didSelect)
    }
    
    // To prevent memory leaks, add the Task outside the sink.
    // Using a separate method for starting the fetch helps avoid memory leaks.
    private func startFetch(for keyword: String) {
        Task { [weak self] in
            guard let self = self else { return }
            await self.fetchLocation(by: keyword)
        }
    }

    // MARK: - fetch locations
    private func fetchLocation(by keyword: String) async {
        /// Clear result array if keyword is empty
        guard !keyword.isEmpty else {
            await MainActor.run {
                self.resultArray.removeAll()
            }
            return
        }
        /// Start network fetch
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
                    self.showErrorAlert = true
                }
            }
        }
    }
}
