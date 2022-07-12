//
//  RecordFormView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 12.07.2022.
//

import SwiftUI
import MapKit

fileprivate func currencyFormat(_ amount: Int, currency: Currency) -> String {
    let num = NSNumber(value: amount)

    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = currency.rawValue
    formatter.maximumFractionDigits = 0
    return formatter.string(from: num)!

}

fileprivate struct CurrencyValueButtonDisabled: ViewModifier {
    let value: Bool

    func body(content: Content) -> some View {
        content
            .disabled(value)
    }
}

fileprivate struct CurrencyValueButtonView: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .frame(height: 20)
        }
            .buttonStyle(.bordered)
            .controlSize(.large)
    }
}

extension CurrencyValueButtonView {
    func disabled(_ val: Bool) -> some View {
        modifier(CurrencyValueButtonDisabled(value: val))
    }
}


fileprivate struct CurrencyValuesView: View {
    let currency: Currency
    @Binding var amount: Int
    @State private var step: Int = 1
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Picker("Amount", selection: $step) {
                ForEach(currency.values, id: \.id) { item in
                    Text("\(currencyFormat(item.value, currency: currency))").tag(item.value)
                }
            }.pickerStyle(.wheel)
                .frame(maxWidth: 250, maxHeight: 120)
                .labelsHidden()
                .clipped()
            
//            let columns: [GridItem] = [
//                GridItem(.flexible()),
//                GridItem(.flexible()),
//            ]
//
//            LazyVGrid(columns: columns) {
//                ForEach(currency.values, id: \.id) { item in
//                    Button(action: {
//                        self.step = item.value
//                    }) {
//                        Text("\(currencyFormat(item.value, currency: currency))")
//                            .frame(maxWidth: .infinity)
//                    }
//                    .buttonStyle(.bordered)
//                }
//            }
//            .frame(maxWidth: .infinity)
            
            Spacer()
            VStack(spacing: 10) {
                CurrencyValueButtonView(icon: "plus", action: {
                    self.amount = self.amount + step
                })
                CurrencyValueButtonView(icon: "minus", action: {
                    self.amount = self.amount - step
                })
                .disabled(amount < step)
            }
        }
    }
}

struct RecordFormView: View {
    private let entity: EntityRecord

    @FetchRequest(fetchRequest: Category.fetchAll()) private var categories: FetchedResults<Category>
    @StateObject private var location: LocationObject
    @State private var amount: Int = 1

    init(entity: EntityRecord) {
        self.entity = entity
        let location = LocationObject(coordinate: CLLocationCoordinate2D(latitude: entity.latitude, longitude: entity.longitude))

        _location = StateObject(wrappedValue: location)
        _amount = State(wrappedValue: Int(entity.amount))
        location.requestLocation()
    }

    var body: some View {
        VStack(spacing: 0) {
            Map(coordinateRegion: $location.region, showsUserLocation: true)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                TextField("Amount", value: $amount, format: .currency(code: entity.currency.rawValue))
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()

                CurrencyValuesView(currency: entity.currency, amount: $amount)
                    .padding()
                
                Button(action: {}) {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .tint(.primary)
                .buttonStyle(.bordered)
                .padding()
            }
        }
    }
}

struct RecordFormView_Previews: PreviewProvider {
    static var previews: some View {
        PersistencePreview{ provider in
            RecordFormView(
                entity: EntityRecord(
                    context: provider.context,
                    type: .spend,
                    date: Date.now,
                    category: Category(
                        context: provider.context,
                        name: "Grocery",
                        color: .teal
                    ),
                    currency: .RUB,
                    latitude: 35.68173905166872,
                    longitude: 139.76542760754913
                )
            )
        }
    }
}
