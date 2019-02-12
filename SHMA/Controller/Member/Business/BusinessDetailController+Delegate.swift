//
//  BusinessDetailController+Delegate.swift
//  SHMA
//
//  Created by Umar Yaqub on 11/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import MapKit

extension BusinessDetailController: BusinessDetailViewDelegate {
    
    func didTapGetDirections() {
        guard let business = businessViewModel?.business else { return }
        let name = business.information.result.name
        let lat = business.information.result.geometry.location.latitude
        let lon = business.information.result.geometry.location.longitude
        let cordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let placemark = MKPlacemark(coordinate: cordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    
}
