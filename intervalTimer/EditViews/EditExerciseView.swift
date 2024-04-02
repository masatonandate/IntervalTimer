//
//  editExerciseView.swift
//  intervalTimer
//
//  Created by Masato Nandate on 6/2/23.
//

import Foundation
import SwiftUI

struct editExerciseView: View{
    
//    The state of the empty exercise changes with the $ sign syntax
    @Binding var exercise: Exercise
    var body: some View{
        Form{
            Section(header: Text("Add Exercise")){
                TextField("Exercise Name", text: $exercise.name)
                
            }
            HStack{
                Slider(value: $exercise.lengthInSecondsAsDouble, in: 0...120, step: 10)
                    .accessibilityValue("\(exercise.lengthInSeconds) seconds")
                Spacer()
                Text("\(exercise.lengthInSeconds) seconds")
                    .accessibilityHidden(true)
            }
            themePickerView(selection: $exercise.backColor)
        }
        
    }
}


struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        editExerciseView(exercise: .constant(Exercise.emptyExercise))
    }
}
