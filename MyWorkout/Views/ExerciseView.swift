//
//  ExerciseView.swift
//  MyWorkout
//
//  Created by Siriluk Rachaniyom on 11/9/2564 BE.
//

import SwiftUI
import AVKit //เกี่ยวกับ audio และ video

struct ExerciseView: View {
    @AppStorage("rating") private var rating = 0 //เก็บค่าในAppStorageแทน เวลาที่เรากำหนดratingในsimulator มันก็จะจดจำค่าไว้ ต่างจากStateที่จะเก็บในmemorทำให้พอปิดแอปมันก็หายไป
    
    @State private var showHistory = false
    @State private var showSuccess = false
    @State private var notDone = -1
    
    @Binding var selectedTab: Int
    
    let index: Int
    
    @State private var timerDone = false
    @State private var showTimer = false
    
    @EnvironmentObject var history: HistoryStore
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(selectedTab: $selectedTab, titleText: Exercise.exercises[index].exerciseName)
                
                if let url = Bundle.main.url(forResource: Exercise.exercises[index].videoName, withExtension: "mp4") { //เป็นการดึงvideoที่เราใส่แปลงมาเป็นurl
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: geometry.size.height * 0.45)//สเกลให้วิดีโอมีความสูง 45% ของหน้าจอ
                } else { //สำหรับกรณีที่unrapแล้วเป็นnil ก็จะเป็นfalseก็จะมาทำเงื่อนไขนี้
                    Text("Couldn't find \(Exercise.exercises[index].videoName).mp4")
                        .foregroundColor(.red)
                }
                
                HStack(spacing: 150) {
                    Button(NSLocalizedString("Start", comment: "begin exercise")) { showTimer.toggle() }
                    Button(NSLocalizedString("Done", comment: "finish exercise")) {
                        history.addDoneExercise(Exercise.exercises[index].exerciseName)
                        timerDone = false //เพื่อให้ restart ใหม่ได้
                        showTimer.toggle()
                        
                        if lastExercise {
                            showSuccess.toggle()
                        } else {
                            if notDone != -1 {
                                selectedTab = notDone
                            }else {
                                selectedTab += 1
                            }
                        }
                    }
                    .disabled(!timerDone) //ทำให้ปุ่ม Done กดไม่ได้ ถ้าเวลายังไม่หมด
                    .sheet(isPresented: $showSuccess) {
                        SuccessView(selectedTab: $selectedTab)
                    }
                }
                .font(.title3)
                .padding()
                
                if showTimer {
                    TimerView(timeDone: $timerDone)
                }
                
                Spacer()
                
                RatingView(exerciseIndex: index) //ส่งค่า rating ไปยังRatingVieที่สร้าง bind ไว้รอรับค่าอยู่
                    .padding()
                
                Button(NSLocalizedString("History", comment: "view user activity")) {showHistory.toggle() }
                    .padding(.bottom)
                    .sheet(isPresented: $showHistory) {
                        HistoryView(showHistory: $showHistory)
                    }
            }
        }
        
    }
    var lastExercise: Bool { //ไว้เช็คว่าตอนนี้เราอยู่หน้า exerciseสุดท้ายไหม เพื่อที่ถ้าอยู่เมื่อกดหน้าถัดไปจะไปหน้า success แทน
        //index + 1 == Exercise.exercises.count
        var countActivity = 0
        var find = true
        let allExercise = ["Squat", "Step Up", "Burpee", "Sun Salute", "Floor Bridge", "V-Up", "Superman"]
        for m in 0...allExercise.count - 1 {
            for n in 0...history.exerciseDays[0].exercises.count - 1 {
                if allExercise[m] != history.exerciseDays[0].exercises[n] {
                    countActivity += 1
                }
                
                if countActivity == history.exerciseDays[0].exercises.count {
                    find = false
                    notDone = m
                    countActivity = 0
                    return find

                }
            }
            countActivity = 0
        }
        return find
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(selectedTab: .constant(1), index: 1) //โดยปกติเราต้องใช้ค่าBind แต่ในที่นี้เราใช้ constantในการกำหนดค่า แล้วให้มันไปbindกับตัวแปลเอง
            .environmentObject(HistoryStore())
    }
}
