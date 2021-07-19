//
//  WeatherAlert.swift
//  Spigot-WeatherAlerts
//
//  Created by Birch, Nathan J on 7/15/21.
//


import UIKit

struct WeatherAlert: Decodable {
    let id: String
    let areaDescription: String
    let dateEffective: Date
    let dateExpires: Date
    let severity: String
    let certainty: String
    let urgency: String
    let senderName: String
    let description: String
    let instruction: String
    let event: String
    let affectedZoneIDs: [AffectedZone]
}

struct WeatherResponse: Decodable {
    let alerts: [WeatherAlert]
}

struct AffectedZone: Decodable {
    let id: String
}
