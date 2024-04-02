//
//  WorkoutCard.swift
//  intervalTimer
//
//  Created by Masato Nandate on 5/26/23.
//

import Foundation
import SwiftUI

struct WorkoutCardView: View{
    
    let workout: Workout
    var body: some View{
        HStack(){
            Text(workout.title)
                .multilineTextAlignment(.center)
                .padding(20)
        }
        .frame(width: 380)
        .background(workout.backColor.mainColor)

        
    }
    
}

struct WorkoutCardView_Preview: PreviewProvider{
    //get the workout example
    static var workout = Workout.sampleData[0]
    //do a preview
    static var previews: some View{
        WorkoutCardView(workout: workout)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
