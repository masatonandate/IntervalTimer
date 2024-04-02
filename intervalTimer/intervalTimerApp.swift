//
//  intervalTimerApp.swift
//  intervalTimer
//
//  Created by Masato Nandate on 5/25/23.
//

import SwiftUI

@main
struct intervalTimerApp: App {
    let persistenceController = PersistenceController.shared
    var workout =  Workout.sampleData
    @StateObject private var store = WorkoutStore()

    var body: some Scene {
        WindowGroup {
            workoutView(stateWorkout: $store.workouts) {
                Task {
                    do {
                        try await store.save(workouts: store.workouts)
                    }
                    catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .task{
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
