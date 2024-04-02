//
//  Theme.swift
//  intervalTimer
//
//  Created by Masato Nandate on 6/29/23.
//

import Foundation
import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case lime
    case mint
    case magenta
    case blue
    case darkBlue
    case hotPink
    case orange
    case pink
    case skyBlue
    case white
    
    var mainColor: Color{
        return Color(self.rawValue)
    }
    
    var name: String{
        return rawValue.capitalized
    }
    
    var id: String{
        return name
    }
}


