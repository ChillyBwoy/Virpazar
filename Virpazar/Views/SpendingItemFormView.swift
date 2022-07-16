//
//  SpendingItemFormView.swift
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
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                color
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())

                Image(systemName: icon)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(.plain)
    }
}

extension CurrencyValueButtonView {
    func disabled(_ val: Bool) -> some View {
        modifier(CurrencyValueButtonDisabled(value: val))
    }
}


fileprivate struct CurrencyValuesView: View {
    let currency: Currency
    let color: Color
    @Binding var amount: Int
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(currency.values, id: \.id) { item in
                        VStack(alignment: .center, spacing: 0) {
                            CurrencyValueButtonView(icon: "plus", color: color, action: {
                                self.amount += item.value
                            })

                            Text("\(currencyFormat(item.value, currency: currency))")
                                .font(.title2)
                                .frame(height: 40)

                            CurrencyValueButtonView(icon: "minus", color: color, action: {
                                self.amount -= item.value
                            }).disabled(amount < item.value)

                        }.frame(width: proxy.size.width / 4)
                    }
                }
            }
            .frame(height: 160)
        }.frame(height: 160)
    }
}

struct SpendingItemFormView: View {
    let category: SpendingCategory

    @StateObject private var location: LocationObject
    @State private var amount: Int = 0
    
    @FetchRequest(fetchRequest: SpendingCategory.fetchAll())
    private var categories: FetchedResults<SpendingCategory>
    
    private func handleSubmit() {
        
    }

    init(category: SpendingCategory) {
        let location = LocationObject(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        self.category = category

        _location = StateObject(wrappedValue: location)
        location.requestLocation()
    }

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Map(coordinateRegion: $location.region, showsUserLocation: true)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    TextField("Amount", value: $amount, format: .currency(code: "JPY"))
                        .font(.system(size: 48))
                        .multilineTextAlignment(.center)
                        .padding()

                    CurrencyValuesView(currency: .JPY, color: Color(category.color), amount: $amount)
                        .padding()
                    
                    Button(action: handleSubmit) {
                        Text("Add")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .tint(Color(category.color))
                    .buttonStyle(.bordered)
                    .padding()
                }
                .frame(height: proxy.size.height / 2)
            }
        }
    }
}

struct SpendingItemView_Previews: PreviewProvider {
    static var previews: some View {
        PersistencePreview { provider in
            SpendingItemFormView(category: SpendingCategory(context: provider.context, name: "Food"))
        }
    }
}
