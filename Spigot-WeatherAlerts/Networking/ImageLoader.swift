//
//  ImageLoader.swift
//  Spigot-WeatherAlerts
//
//  Created by Birch, Nathan J on 7/18/21.
//

import Foundation

class ImageLoader {
  private var loadedImages = [URL: UIImag]()
  private var runningRequests = [UUID: URLSessionDataTask]()
}
