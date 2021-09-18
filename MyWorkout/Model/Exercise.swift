//
//  Exercise.swift
//  MyWorkout
//
//  Created by Siriluk Rachaniyom on 12/9/2564 BE.
//

import Foundation

struct Exercise {
    let exerciseName: String
    let videoName: String
    
    enum ExerciseEnum: CustomStringConvertible {
        case squat
        case stepUp
        case burpee
        case sunSalute
        case floorBridge
        case VUp
        case superman
    

    var description: String {
        switch  self {
        case .squat:
            return NSLocalizedString("Squat", comment: "exercise")
        case .stepUp:
            return NSLocalizedString("Step Up", comment: "exercise")
        case .burpee:
            return NSLocalizedString("Burpee", comment: "exercise")
        case .sunSalute:
            return NSLocalizedString("Sun Salute", comment: "exercise")
        case .floorBridge:
            return NSLocalizedString("Floor Bridge", comment: "exercise")
        case .VUp:
            return NSLocalizedString("V-Up", comment: "exercise")
        case .superman:
            return NSLocalizedString("Superman", comment: "exercise")
        }
      }
    }
}

extension Exercise {
    static let exercises = [
        Exercise(exerciseName: String(describing: ExerciseEnum.squat), videoName: "squat"),
        Exercise(exerciseName: String(describing: ExerciseEnum.stepUp), videoName: "step-up"),
        Exercise(exerciseName: String(describing: ExerciseEnum.burpee), videoName: "burpee"),
        Exercise(exerciseName: String(describing: ExerciseEnum.sunSalute), videoName: "sun-salute"),
        Exercise(exerciseName: String(describing: ExerciseEnum.floorBridge), videoName: "floor-bridge"),
        Exercise(exerciseName: String(describing: ExerciseEnum.VUp), videoName: "v-up"),
        Exercise(exerciseName: String(describing: ExerciseEnum.superman), videoName: "superman")
    ]
}
