//
//  Store.swift
//  intervalTimer
//
//  Created by Masato Nandate on 8/4/23.
//

//Reads JSON data from workout.data, decodes the data to array of workouts
import Foundation

@MainActor //Globally unique actor who performs tasks on the main thread
class WorkoutStore: ObservableObject {
    @Published var workouts: [Workout] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                in: .userDomainMask,
                                appropriateFor: nil,
                                create: false)
        .appendingPathComponent("workout.data")
        
        
    }
    
    //this function loads the data from a file, async to avoid slow times
    func load() async throws {
        let task = Task<[Workout], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let workouts = try JSONDecoder().decode([Workout].self, from: data)
            return workouts
        }
        
        let workouts = try await task.value
        self.workouts = workouts
    }
    
    //this function saves the data to a file
    func save(workouts: [Workout]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(workouts)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
        
    }
    
    
}
