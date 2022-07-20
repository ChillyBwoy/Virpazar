//
//  LocationManager.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 11.07.2022.
//

import CoreLocation
import MapKit

class LocationObject: NSObject, ObservableObject {
    private let manager = CLLocationManager()

    @Published var coordinate: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion()

    override init() {
        super.init()
        manager.delegate = self
    }
    
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init()
        self.coordinate = coordinate
        updateRegion(coordinate: coordinate)
    }
    
    private func updateRegion(coordinate: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension LocationObject: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.first else {
            return
        }

        coordinate = lastLocation.coordinate
        
        updateRegion(coordinate: lastLocation.coordinate)
    }
}
