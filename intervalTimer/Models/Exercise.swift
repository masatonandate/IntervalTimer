//
//  Exercise.swift
//  intervalTimer
//
//  Created by Masato Nandate on 5/25/23.
//

import Foundation
import SwiftUI
struct Exercise: Identifiable, Codable{
    let id: UUID
    var name: String
    var lengthInSeconds: Int
    var lengthInSecondsAsDouble: Double{
        get{
            Double(lengthInSeconds)
        }
        set{
            lengthInSeconds = Int(newValue)
        }
        
    }
    var backColor: Theme
    var isCompleted: Bool
    
    init(id: UUID = UUID(), name: String, lengthInSeconds: Int, backColor: Theme) {
        self.id = id
        self.name = name
        self.lengthInSeconds = lengthInSeconds
        self.backColor = backColor
        self.isCompleted = false
    }
}

extension Exercise{
    static let sampleDataOne: [Exercise] =
    [
        Exercise(name: "Plank", lengthInSeconds: 5, backColor: .lime),
        Exercise(name: "Side-Plank", lengthInSeconds: 5, backColor: .mint),
        Exercise(name: "Mountain-Climbers", lengthInSeconds: 5, backColor: .blue),
        Exercise(name: "V-Sit", lengthInSeconds: 5, backColor: .darkBlue)
    ]
    static let sampleDataTwo: [Exercise] =
    [
        Exercise(name: "sprint1", lengthInSeconds: 10, backColor: .lime),
        Exercise(name: "sprint2", lengthInSeconds: 20, backColor: .mint),
        Exercise(name: "sprint3", lengthInSeconds: 30, backColor: .blue),
        Exercise(name: "sprint4", lengthInSeconds: 40, backColor: .darkBlue)
    ]
    
    static var emptyExercise: Exercise{
        Exercise(name: "", lengthInSeconds: 0, backColor: .lime)
    }
    
}
