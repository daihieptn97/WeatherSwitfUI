//
//  Extensions.swift
//  WetherDemo
//
//  Created by Hiệp Trần on 18/4/24.
//

import Foundation



import SwiftUI

// Extension for rounded Double to 0 decimals
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }   
    func convertTimeStamps() -> String {
        
        let date = NSDate(timeIntervalSince1970: self)

        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "HH:mm"

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        return dateString
    }
}

extension String {
    func caplockTheFirstText() -> String {
        return self.prefix(1).uppercased() + self.dropFirst();
    }
}


// Extension for adding rounded corners to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

// Custom RoundedCorner shape used for cornerRadius extension above
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
