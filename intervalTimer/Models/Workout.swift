//
//  Workout.swift
//  intervalTimer
//
//  Created by Masato Nandate on 5/26/23.
//

import Foundation
import SwiftUI

//Identifiable is necessary for putting structs into a for loop, like React
//Else will get an error when we make the List object
struct Workout: Identifiable, Codable{
    let id: UUID
    var title: String
    var exercises: [Exercise]
    var repeats: Int
    var backColor: Theme
    
//need to add an initializer if we are going to have a UUID object
    init(id: UUID = UUID(), title: String, exercises: [Exercise], repeats: Int, backColor: Theme) {
        self.id = id
        self.title = title
        self.exercises = exercises
        self.repeats = repeats
        self.backColor = backColor
    }
    
}

extension Workout{
    static let sampleData: [Workout] =
    [
        Workout(title: "Upper-Ab Routine", exercises: Exercise.sampleDataOne, repeats: 2, backColor: .magenta),
        Workout(title: "Sprint Routine", exercises: Exercise.sampleDataTwo, repeats: 2, backColor: .mint)
        
    ]
    
    static var emptyWorkout: Workout {
        Workout(title: "", exercises: [], repeats: 0, backColor: .magenta)
    }
}
