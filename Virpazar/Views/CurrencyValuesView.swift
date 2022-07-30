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
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Color.accentColor
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
    @Binding var amount: Int

    @State private var contentSize: CGSize = .zero
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 0) {
                ForEach(currency.values, id: \.id) { item in
                    VStack(alignment: .center, spacing: 0) {
                        CurrencyValueButtonView(icon: "plus", size: 40, action: {
                            self.amount += item.value
                        })

                        Text("\(currency.symbol()) \(item.value)")
                            .font(.body)
                            .frame(height: 28)

                        CurrencyValueButtonView(icon: "minus", size: 40, action: {
                            self.amount -= item.value
                        }).disabled(amount < item.value)
                    }
                    .frame(width: contentSize.width / 4)
                }
            }
        }
        .overlay {
            GeometryReader { geo in
                Color.clear.onAppear {
                    contentSize = geo.size
                }
            }
        }
    }
}

struct CurrencyValuesView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyValuesView(currency: .RUB, amount: .constant(142))
    }
}
