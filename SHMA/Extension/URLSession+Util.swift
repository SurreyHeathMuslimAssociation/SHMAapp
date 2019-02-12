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
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?fields=opening_hours,types,place_id,formatted_address,name,rating,opening_hours,geometry&placeid=\(placeId)&key=\(googleAPIKey)") else { return }
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
