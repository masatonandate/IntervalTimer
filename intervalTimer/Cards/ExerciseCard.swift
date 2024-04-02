//
//  ExerciseCard.swift
//  intervalTimer
//
//  Created by Masato Nandate on 5/25/23.
//

import Foundation
import SwiftUI

struct ExerciseCardView: View{
    let exercise: Exercise
    var body: some View{
        HStack(spacing: 0){
            Text(exercise.name)
                .padding(20)
            Spacer()
            Image(systemName: "clock")
                .padding(10)
            Text(String(exercise.lengthInSeconds) + "sec")
                .padding(20)
        }
        .background(exercise.backColor.mainColor)
    }
    
}

struct ExerciseCardView_Previews: PreviewProvider{
    //first exercise is the plank
    static var exercise = Exercise.sampleDataOne[2]
    //previewing teh card view
    static var previews: some View{
        ExerciseCardView(exercise: exercise)
            .previewLayout(.fixed(width: 400, height: 60))
    }
    
}
