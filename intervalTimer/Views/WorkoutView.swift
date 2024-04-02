//
//  allWorkoutView.swift
//  intervalTimer
//
//  Created by Masato Nandate on 5/25/23.
//

import SwiftUI


struct workoutView: View {
    @Binding var stateWorkout: [Workout]
    @State private var emptyWorkout = Workout.emptyWorkout
    @State private var isAddView = false
    @State private var isEditView = false
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    var body: some View{
        NavigationStack{
            List {
                ForEach(self.$stateWorkout.indices, id: \.self) { index in
                    NavigationLink(destination: exerciseView(exerciseArray: self.$stateWorkout[index].exercises, exerciseName: self.$stateWorkout[index].title)){
                        WorkoutCardView(workout: stateWorkout[index])
                    }
                    .listRowBackground(stateWorkout[index].backColor.mainColor)
                    .padding(10)
                    .swipeActions(edge: .trailing){
                        Button(role: .destructive){
                            stateWorkout.remove(at: index)
                        } label : {
                            Label("Delete", systemImage: "trash")
                        }
                    }
//                    .onLongPressGesture {
//                        isEditView = true
//                        print(isEditView)
//                    }.sheet(isPresented: $isEditView){
//                        editWorkoutView(workout: $stateWorkout[index])
//                    }
                }
            }
//            need to give the title to the list, not the NavStack
            .navigationTitle("All Workouts")
            //how to define buttons
            .toolbar{
                Button(action: {isAddView = true}){
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isAddView){
                NavigationStack{
                    editWorkoutView(workout: $emptyWorkout)
                        .navigationTitle("Add New Workout")
                        .toolbar{
                            ToolbarItem(placement: .cancellationAction){
                                Button("Cancel"){
                                    isAddView = false
                                }
                                
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button("Done"){
                                    isAddView = false
                                    stateWorkout.append(emptyWorkout)
                                    emptyWorkout = Workout.emptyWorkout
                                    
                                }
                                
                            }
                        }
                }
            }
            .accessibilityLabel("Adding Workouts")
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: scenePhase) { phase in
                //saves the workout data if the phase is "inactive"
                if phase == .inactive { saveAction() }
            }
    }
}


//struct WorkingView_Previews: PreviewProvider {
//    static var workout =  Workout.sampleData
//    static var previews: some View {
//        WorkoutView(stateWorkout: .constant(workout))
//    }
//}
