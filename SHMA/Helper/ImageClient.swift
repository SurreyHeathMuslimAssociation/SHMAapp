//
//  ImageClient.swift
//  SHMA
//
//  Created by Umar Yaqub on 11/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

var imageCache = [String : UIImage]()

class ImageClient: UIImageView {
    
    var lastUrlUsedToLoadImage: String?
    
    func getImageFromFirebase(using urlString: String, indicator: UIActivityIndicatorView) {
        // setup
        self.image = nil
        indicator.alpha = 1
        lastUrlUsedToLoadImage = urlString
        indicator.startAnimating()
        // if image is already in cache use that instead
        if let cachedImaged = imageCache[urlString] {
            self.image = cachedImaged
            indicator.stopAnimating()
            indicator.alpha = 0
            return
        }
        guard let url = URL(string: urlString) else { return }
        fetchImage(using: url, indicator: indicator)
    }
    
    private func fetchImage(using url: URL, indicator: UIActivityIndicatorView) {
        let networkManager = NetworkManager(session: URLSession.shared)
        networkManager.loadData(from: url) { (data, response, error) in
            if let err = error {
                print("failed to fetch post:", err)
                DispatchQueue.main.async {
                    indicator.stopAnimating()
                    indicator.alpha = 0
                }
                return
            }
            if let httpResp = response as? HTTPURLResponse {
                let statusCode = httpResp.statusCode
                if statusCode != 200 {
                    print("dataTaskWithRequest HTTP status code: ", statusCode)
                    return
                }
            }
            // avoids duplicating post images
            if url.absoluteString != self.lastUrlUsedToLoadImage {
                return
            }
            guard let imageData = data else { return }
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            DispatchQueue.main.async {
                self.image = photoImage
                indicator.stopAnimating()
                indicator.alpha = 0
            }
        }
    }
}

