//
//  bookview.swift
//  Memora
//
//  Created by Fay on 26/02/1448 AH.
//
import SwiftUI

enum BookSide: String, Identifiable {
    
    case right
    case left
    
    var id: String {
        rawValue
    }
    
    var imageName: String {
        switch self {
        case .right:
            return "bookright"
            
        case .left:
            return "Bookleft"
        }
    }
}

struct BookSideView: View {
    
    let side: BookSide
    
    var body: some View {
        
        Image(side.imageName)
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    VStack {
        
        BookSideView(side: .right)
            .frame(width:400)
        
        BookSideView(side: .left)
            .frame(width: 400)
    }
}
