//
//  HomeController+Delegate.swift
//  SHMA
//
//  Created by Umar Yaqub on 18/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import CoreLocation

extension HomeController: CLLocationManagerDelegate {
    
    func saveCurrentLocation() {
        locationManager = CLLocationManager()
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("user agreed to access their location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        fetchPrayerTimes(String(location.coordinate.latitude), lon: String(location.coordinate.longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed getting location \(error.localizedDescription)")
    }
    
    func fetchPrayerTimes(_ lat: String, lon: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let todaysDate = dateFormatter.string(from: Date())
        networkManager.fetchPrayerTimes(using: todaysDate, lat, lon) { (response) in
            self.prayerTimesView.prayerTimes.append(response.data.timings.fajr)
            self.prayerTimesView.prayerTimes.append(response.data.timings.sunrise)
            self.prayerTimesView.prayerTimes.append(response.data.timings.dhuhr)
            self.prayerTimesView.prayerTimes.append(response.data.timings.asr)
            self.prayerTimesView.prayerTimes.append(response.data.timings.sunset)
            self.prayerTimesView.prayerTimes.append(response.data.timings.maghrib)
            self.prayerTimesView.prayerTimes.append(response.data.timings.isha)
            self.prayerTimesView.prayerTimes.append(response.data.timings.imsak)
            self.prayerTimesView.prayerTimes.append(response.data.timings.midnight)
            self.prayerTimesView.prayerTimes.append(response.data.date.hijri.date)
            DispatchQueue.main.async {
                self.prayerTimesView.reloadData()
            }
        }
    }
}
