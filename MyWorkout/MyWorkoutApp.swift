//
//  MyWorkoutApp.swift
//  MyWorkout
//
//  Created by Siriluk Rachaniyom on 11/9/2564 BE.
//

import SwiftUI

@main
struct MyWorkoutApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear{
                    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))//จะprint url directoryของไฟล์เราขณะรันแอป
                }
                .environmentObject(HistoryStore())
        }
    }
}
