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
                Button(action: {
                    self.viewModel.selectLocation(location: value)
                }, label: {
                    Text(value.getLabel())
                        .fontWeight(.semibold)
                })
            }
        }
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        .searchable(text: $viewModel.searchKeyword)
        .autocorrectionDisabled(true)
        .keyboardType(.alphabet)
        .alert(isPresented: $viewModel.showErrorAlert, error: viewModel.error) {
            Button(Localization.App.ok) {
                viewModel.showErrorAlert.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView(viewModel: MockSearchViewModel())
    }
}
