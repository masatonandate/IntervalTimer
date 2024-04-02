//
//  editWorkoutView.swift
//  intervalTimer
//
//  Created by Masato Nandate on 6/3/23.
//

import Foundation
import SwiftUI

struct editWorkoutView: View{
    @Binding var workout: Workout
    var body: some View{
        Form{
            Section(header: Text("Add Workout")){
                TextField("Workout Name", text: $workout.title)
            }
            themePickerView(selection: $workout.backColor)
        }
    }
}

struct editWorkoutView_Provider: PreviewProvider {
    static var previews: some View {
        editWorkoutView(workout: .constant(Workout.emptyWorkout))
    }
}
