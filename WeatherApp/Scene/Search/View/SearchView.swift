//
//  SearchView.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-07.
//

import SwiftUI

struct SearchView<ViewModel:SearchViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.resultArray) { value in
                Text(value.getLabel())
                    .fontWeight(.semibold)
            }
        }
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        .searchable(text: $viewModel.searchKeyword)
    }
}

#Preview {
    NavigationStack {
        SearchView(viewModel: MockSearchViewModel())
    }
}
