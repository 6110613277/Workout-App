//
//  HistoryStoreDevData.swift
//  MyWorkout
//
//  Created by Siriluk Rachaniyom on 12/9/2564 BE.
//

import Foundation

extension HistoryStore {
    func createDevData() { //เราต้องการเปลี่ยนตัวแปร exerciseDays ซึ่งเป็นstruct เราจึงต้องใช้ mutating แต่เนื่องจากเปลี่ยนเป็นclassในไฟล์Historyจังไม่ต้องใช้mutating
        exerciseDays = [
            ExerciseDay(date: Date().addingTimeInterval(-86400), exercises: [
                Exercise.exercises[0].exerciseName,
                Exercise.exercises[1].exerciseName,
                Exercise.exercises[2].exerciseName
            ]),
            
            ExerciseDay(date: Date().addingTimeInterval(-86400*2), exercises: [
                Exercise.exercises[0].exerciseName,
                Exercise.exercises[1].exerciseName
            ])
        ]
    }
}
