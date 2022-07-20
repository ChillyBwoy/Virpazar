//
//  SpendingItemFormView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 12.07.2022.
//

import SwiftUI
import MapKit
import Combine

fileprivate func currencyFormatter(_ currency: Currency) -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
//    formatter.currencySymbol = ""

    return formatter
}

fileprivate class SpendingItemFormData: ObservableObject {
    @Published var amount: Int
    @Published var selectedCurrency: Currency {
        didSet {
            amount = 0
        }
    }
    
    init(amount: Int, selectedCurrency: Currency) {
        self.amount = amount
        self.selectedCurrency = selectedCurrency
    }
}

struct SpendingItemFormView: View {
    @StateObject private var location: LocationObject
    @ObservedObject private var data = SpendingItemFormData(amount: 0, selectedCurrency: .USD)

    @State private var selectedCategory: SpendingCategory?
    @State private var date: Date

    @FetchRequest(fetchRequest: SpendingCategory.fetchAll())
    private var categories: FetchedResults<SpendingCategory>

    private var currentColor: Color {
        Color(selectedCategory?.color  ?? .gray)
    }

    init() {
        _date = State(wrappedValue: Date())

        let location = LocationObject(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        _location = StateObject(wrappedValue: location)
        location.requestLocation()
    }

    var body: some View {
        VStack {
            Map(coordinateRegion: $location.region, showsUserLocation: true)
                .ignoresSafeArea()

            VStack(alignment: .trailing) {
                DatePicker("Date", selection: $date, displayedComponents: [.date])
                    .padding()

                HStack(alignment: .center) {
                    TextField("Amount",
                              value: $data.amount,
                              format: .number
                        )
                        .font(.system(size: 42))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()

                    Menu {
                        Picker("Currency", selection: $data.selectedCurrency) {
                            ForEach(Currency.allCases, id:\.self) { curr in
                                Text(curr.rawValue).tag(curr)
                            }
                        }
                    } label: {
                        Text(data.selectedCurrency.symbol())
                            .font(.system(size: 42))
                            .frame(height: 40)
                            .foregroundColor(currentColor)
                    }
                }
                .padding()

                Menu {
                    Picker("Category", selection: $selectedCategory) {
                        Text("No category").tag(nil as SpendingCategory?)
                        ForEach(categories, id: \.self) { category in
                            Text(category.name).tag(category as SpendingCategory?)
                        }
                    }
                } label: {
                    if selectedCategory != nil {
                        CategoryBadgeView(category: selectedCategory!)
                    } else {
                        Text("No category")
                            .foregroundColor(currentColor)
                    }
                }
                .frame(height: 20)
                .padding()

                CurrencyValuesView(
                    currency: data.selectedCurrency,
                    color: currentColor,
                    amount: $data.amount
                )
                .frame(height: 110)
                
                Button(action: {}) {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .tint(currentColor)
                .buttonStyle(.bordered)
                .padding()
            }
        }
    }
}

struct SpendingItemFormView_Previews: PreviewProvider {
    static var previews: some View {
        PersistencePreview(dispatch: { provider in
            let stub = SpendingCategoryStub(provider.context)
            let _ = stub.createMany()

            provider.save()
        }) {
            SpendingItemFormView()
        }
    }
}
