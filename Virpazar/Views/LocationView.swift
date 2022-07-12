//
//  LocationView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 11.07.2022.
//

import SwiftUI
import CoreLocationUI

struct LocationView: View {
    @StateObject var location = LocationObject()

    var body: some View {
        VStack {
            if let location = location.coordinate {
                Text("Your location: \(location.latitude), \(location.longitude)")
            }

            LocationButton(.currentLocation) {
                location.requestLocation()
            }
            .frame(height: 44)
            .padding()
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
