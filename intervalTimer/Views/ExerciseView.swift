//
//  allExerciseView.swift
//  intervalTimer
//
//  Created by Masato Nandate on 5/30/23.
//

import Foundation
import SwiftUI

struct exerciseView: View {
    //isPresentingPlusView is used for popup of adding new
    @State private var isPresentingPlusView = false
    //presentEditView is used for popup of edit view
    @State private var isPresentingEditView = false
    //empty exercise is placeholder for a new exercise
    @State private var emptyExercise = Exercise.emptyExercise
    //exercise array is a binding as it needs to be updated
    @Binding var exerciseArray: [Exercise]
    @Binding var exerciseName: String
    @State private var intervalCount = 1
    
    
    var body: some View{
        VStack{
            NavigationStack{
                //displays the cards
                List{
                    ForEach(self.$exerciseArray.indices, id: \.self){ index in
                        ExerciseCardView(exercise: self.exerciseArray[index])
                            .listRowBackground(self.exerciseArray[index].backColor.mainColor)
                            .swipeActions(edge: .trailing){
                                Button(role: .destructive){
                                    print("Delete")
                                    exerciseArray.remove(at: index)
                                } label : {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .onLongPressGesture {
                                isPresentingEditView = true
                                print(isPresentingEditView)
                            }.sheet(isPresented: $isPresentingEditView){
                                editExerciseView(exercise: $exerciseArray[index])
                            }
                        }
                    }
                    NavigationLink(destination: exerciseTimerView(exerciseArray: $exerciseArray,exerciseTimer: exerciseArray.first?.lengthInSeconds ?? 10, intervals: intervalCount, circleIntervals: intervalCount)){
                        Text("Start Workout")
                    }
                    .navigationTitle(exerciseName)
                    .toolbar{
                        Button(action: {isPresentingPlusView = true}){
                            Image(systemName: "plus")
                            
                        }
                    }
                    
                    //logic to deal with adding a new workout
                    .sheet(isPresented: $isPresentingPlusView){
                        NavigationStack{
                            editExerciseView(exercise: $emptyExercise)
                                .navigationTitle("Add New Exercise")
                                .toolbar{
                                    ToolbarItem(placement: .cancellationAction){
                                        Button("Cancel"){
                                            isPresentingPlusView = false
                                        }
                                    }
                                    ToolbarItem(placement: .confirmationAction){
                                        Button("Done"){
                                            isPresentingPlusView = false
                                            exerciseArray.append(emptyExercise)
                                            emptyExercise = Exercise.emptyExercise
                                            
                                        }
                                    }
                                }
                            
                        }
                    }
                }
            }
        }
}
    


struct ExerciseView_Previews: PreviewProvider {
    static var exerciseArray =  Exercise.sampleDataOne
    static var previews: some View {
        exerciseView(exerciseArray: .constant(exerciseArray), exerciseName: .constant("Example-Workout"))
    }
}

