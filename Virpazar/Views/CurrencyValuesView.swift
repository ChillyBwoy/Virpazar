//
//  CurrencyValuesView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 17.07.2022.
//

import SwiftUI

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
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                color
                    .frame(width: size, height: size)
                    .clipShape(Circle())

                Image(systemName: icon)
                    .frame(width: size, height: size)
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

struct CurrencyValuesView: View {
    let currency: Currency
    let color: Color
    @Binding var amount: Int
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(currency.values, id: \.id) { item in
                        VStack(alignment: .center, spacing: 0) {
                            CurrencyValueButtonView(icon: "plus", color: color, size: 40, action: {
                                self.amount += item.value
                            })

                            Text("\(currency.symbol()) \(item.value)")
                                .font(.body)
                                .frame(height: 28)

                            CurrencyValueButtonView(icon: "minus", color: color, size: 40, action: {
                                self.amount -= item.value
                            }).disabled(amount < item.value)

                        }.frame(width: proxy.size.width / 4)
                    }
                }
            }
        }
    }
}

struct CurrencyValuesView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyValuesView(currency: .RUB, color: .blue, amount: .constant(142))
    }
}
