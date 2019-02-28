//
//  URLSession+Util.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension URLSession: NetworkSession {
    
    func loadData(from url: URL, completionHandler: @escaping NetworkCallback) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        makeAPICall(using: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
    }
    
    func fetchGooglePlaceData(using placeId: String, completion: @escaping GooglePlacesAPICallback) {
        let googleAPIKey = "AIzaSyDT5-YFEEvBvTuxqByV1fLEjscYWhcUMJw"
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?fields=opening_hours,types,place_id,formatted_address,formatted_phone_number,name,rating,opening_hours,geometry&placeid=\(placeId)&key=\(googleAPIKey)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        makeAPICall(using: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let googlePlace = try decoder.decode(GooglePlacesResponse.self, from: data)
                    completion(googlePlace)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchPrayerTimes(using date: String, _ lat: String, _ lon: String, completion: @escaping PrayerTimesAPICallback) {
        //let urlString = "https://api.aladhan.com/v1/calendarByCity?city=Camberley&country=United Kingdom&method=2&month=02&year=2019&school=1"
        let urlString = "https://api.aladhan.com/v1/timings/\(date)?latitude=\(lat)&longitude=\(lon)&method=2"
        let modifiedUrlString = urlString.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: modifiedUrlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        makeAPICall(using: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let prayerTimesResponse = try decoder.decode(PrayerTimesResponse.self, from: data)
                    completion(prayerTimesResponse)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    private func makeAPICall(using request: URLRequest, completion: @escaping NetworkCallback) {
        dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            completion(data, response, error)
        }.resume()
    }
    
}
