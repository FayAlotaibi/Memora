//
//  JourneyPath.swift
//  QVoyage
//

import SwiftUI

struct JourneyPath: Shape {

    let journeyCount: Int
    let rowHeight: CGFloat

    func path(in rect: CGRect) -> Path {

        var path = Path()

        guard journeyCount > 0 else { return path }

        let leftX = rect.width * 0.28
        let rightX = rect.width * 0.72

        let startY: CGFloat = 55

        path.move(to: CGPoint(x: leftX, y: startY))

        for index in 1..<journeyCount {

            let previousLeft = (index - 1).isMultiple(of: 2)

            let start = CGPoint(
                x: previousLeft ? leftX : rightX,
                y: startY + CGFloat(index - 1) * rowHeight
            )

            let end = CGPoint(
                x: previousLeft ? rightX : leftX,
                y: startY + CGFloat(index) * rowHeight
            )

            let midY = (start.y + end.y) / 2

            path.addCurve(
                to: end,
                control1: CGPoint(
                    x: start.x,
                    y: midY - 60
                ),
                control2: CGPoint(
                    x: end.x,
                    y: midY + 60
                )
            )
        }

        return path
    }
}
