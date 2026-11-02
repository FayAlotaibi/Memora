//
//  TravelChallenge.swift
//  Memora
//
//  Created by Lujain on 28/02/1448 AH.
//

import Foundation
import FoundationModels

@Generable
struct TravelChallenge {

    @Guide(
        description: "Short creative title for the photography challenge"
    )
    let title: String

    @Guide(
        description: "One short sentence explaining exactly what photo the traveler should take"
    )
    let description: String

    @Guide(
        description: "Difficulty level: Easy, Medium or Explorer"
    )
    let difficulty: String
}
