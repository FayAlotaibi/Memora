//
//  Jorney.swift
//  QVoyage
//
//  Created by وتين الرميح on 21/02/1448 AH.
//

import SwiftUI
import Foundation

struct Journey: Identifiable {

    let id = UUID()

    let country: String
    let city: String
    let date: String
    let image: String
}
