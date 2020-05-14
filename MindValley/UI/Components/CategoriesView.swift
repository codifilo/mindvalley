//
//  CategoriesView.swift
//  MindValley
//
//  Copyright © 2020 Agustín Prats.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import SwiftUI

struct CategoriesView: View {
    
    let categoriesData: Loadable<CategoriesData>
    let refreshHandler: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Browse by categories".localized)
                    .headline
                    .padding(.horizontal)
                Spacer()
            }
            categories
            Spacer()
        }
    }
    
    private var categories: some View {
        switch categoriesData {
        case .notRequested:
            return AnyView(notRequestedView)
        case .isLoading(last: let last, cancelBag: _):
            return AnyView(isLoadingView(last))
        case .loaded(let categories):
            return AnyView(loadedView(categories))
        case .failed(let error):
            return AnyView(failedView(error))
        }
    }
    
    private var notRequestedView: some View {
        EmptyView()
    }
    
    private func isLoadingView(_ last: CategoriesData?) -> some View {
        ZStack {
            last.map { AnyView(self.loadedView($0)) } ?? AnyView(EmptyView())
            ActivityIndicatorView()
        }
    }
    
    private func loadedView(_ categories: CategoriesData) -> some View {
        List(cellsData(from: categories.data.categories)) { cellData in
            HStack {
                self.categoryView(for: cellData.first)
                    .padding(.trailing, 5)
                cellData.second.map {
                    self.categoryView(for: $0)
                        .padding(.leading, 5) }
            }
        }
        .onAppear() {
            UITableView.appearance().backgroundColor = .clear
            UITableView.appearance().separatorStyle = .none
            UITableViewCell.appearance().backgroundColor = .clear
            UITableViewCell.appearance().selectionStyle = .none
        }
    }
    
    private func categoryView(for category: Category) -> some View {
        Button(
            action: { Log.d("Did tap category=\(category.name)") },
            label: { Text(category.name)
                .category
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .frame(height: 60)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.horizontal)
                .background(Color.lightBackground)
                .cornerRadius(35) })
    }
    
    private func failedView(_ error: Error) -> some View {
        Text("Something went wrong. Tap this to refresh.".localized)
            .onTapGesture { self.refreshHandler() }
    }
}

private extension CategoriesView {
    struct CategoriesCellData: Identifiable {
        let first: Category
        let second: Category?
        
        var id: Int {
            var hasher = Hasher()
            hasher.combine(first.name)
            if let second = second {
                hasher.combine(second.name)
            }
            return hasher.finalize()
        }
    }
    
    private func cellsData(from cats: [Category]) -> [CategoriesCellData] {
        stride(from: 0, to: cats.endIndex, by: 2)
            .map {
                (cats[$0], $0 < cats.index(before: cats.endIndex)
                    ? cats[$0.advanced(by: 1)]
                    : nil)
            }.map { CategoriesCellData(first: $0, second: $1) }
        }
    }

extension Category: Identifiable {
    var id: Int {
        name.hashValue
    }
}

#if DEBUG
struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(
            categoriesData: .loaded(CategoriesData.mockedData),
            refreshHandler: { })
    }
}
#endif
