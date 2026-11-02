//
//  TripDay.swift
//  QVoyage
//
//  Created by وتين الرميح on 23/02/1448 AH.
//

import Foundation

struct TripDay: Identifiable {

    let id = UUID()

    let day: Int
    let challenge: String

    var image: String?
}
