//
//  History.swift
//  MyWorkout
//
//  Created by Siriluk Rachaniyom on 12/9/2564 BE.
//

import Foundation

struct ExerciseDay: Identifiable {
    let id = UUID()
    let date: Date
    var exercises: [String] = []
}

class HistoryStore : ObservableObject { //เพื่อที่ว่าถ้าข้อมูลในclassนี้ ที่เป็น@Publishedเปลี่ยน และมีviewตัวไหน subscribeมัน ก็จะไปทำการอัพเดตview
    @Published var exerciseDays: [ExerciseDay] = []
    
    init() {
        #if DEBUG
        createDevData()
        #endif
        
        load()
    }
    
    func addDoneExercise(_ exerciseName: String) {
        let today = Date()
        var checkSameActivity = false
        if let firstDate = exerciseDays.first?.date, today.isSameDay(as: firstDate) { //เช็คว่าวันที่บันทึกกการออกกำลังกายกับวันนี้เป็นวันเดียวกันไหม
            for n in 0...exerciseDays[0].exercises.count - 1 {
                if exerciseDays.first?.exercises[n] != exerciseName {
                    checkSameActivity = true
                }else {
                    checkSameActivity = false
                    break
                }
            }
            if checkSameActivity == true {
                exerciseDays[0].exercises.append(exerciseName) //เพิ่มexerciseที่ทำลงในhistory
            }
        }else{
            exerciseDays.insert( //เพิ่มวันใหม่ลงไปที่ตำแหน่ง 0 หรือคือตำแหน่งแรก
                ExerciseDay(date: today, exercises: [exerciseName]),
                at: 0
            )
        }
        save()
    }
    
    func load() {
        guard let dataURL = getURL() else{
            print("Cannot get file url.")
            return
        }
        do {
            let data = try Data(contentsOf: dataURL)
            let plistData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
            let convertedPlistData = plistData as? [[Any]] ?? []
            exerciseDays = convertedPlistData.map {
                ExerciseDay(date: $0[1] as? Date ?? Date(), exercises: $0[2] as? [String] ?? []) //$0[2] as? [String] ?? [] นี่คือ cast ค่า $0[2] ให้เป็น String ถ้าcastไม่ได้ให้เป็น []
            }
        }catch{
            print("Error loading file.")
        }
    }
    
    func save() {
        guard let dataURL = getURL() else{
            print("Cannot get file URL")
            return
        }
        let plistData = exerciseDays.map { [$0.id.uuidString, $0.date, $0.exercises] }
        
        do {
            let data = try PropertyListSerialization.data(fromPropertyList: plistData, format: .binary, options: .zero)
            try data.write(to: dataURL, options: .atomic)
        }catch {
            print("Cannot save file")
        }
    }
    
    func getURL() -> URL? {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask).first else { //guard คือมันจะไปเช็คว่าเป็นเท็จไหม ถ้าเป็นเท็จจะไปทำในส่วนelseแทน แต่ถ้าเป็นจรองจะreturn documentsURL.appendingPathComponent("history.plist")
                return nil
        }
        
        return documentsURL.appendingPathComponent("history.plist")
    }
}
