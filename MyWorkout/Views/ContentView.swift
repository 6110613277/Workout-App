//
//  ContentView.swift
//  MyWorkout
//
//  Created by Siriluk Rachaniyom on 11/9/2564 BE.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedTab") private var selectedTab = 9 //เก็บtabที่เราเปิดอยู่ หน้า 9 เรากำหนดให้เป็น welcomeView และSceneStorageไว้เก็บหน้าที่เปิดค้างไว้ แต่ละอุปกรณ์
    
    var body: some View {
        TabView(selection: $selectedTab) { //ไว้แบ่งแต่ละฟิลออกเป็นหน้า
            WelcomeView(selectedTab : $selectedTab)
                .tag(9)
            ForEach(0 ..< Exercise.exercises.count) { index in
                ExerciseView(selectedTab : $selectedTab, index: index)
                    .tag(index)//indexจะเรียงตั้งแต่ 0,1,2,.. โดยเราจะให้หน้าพวกนี้เป็นหน้าexercise
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) //เพื่อทำให้สามารถเลื่อนเปลี่ยนหน้าซ้าย-ขวาได้ โดยindexDisplayMode: .never คือการที่เราเลือกไม่ให้แสดงจุดไข่ปลาหรือจำนวนหน้า
        //.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))//ทำเพื่อให้รู้ว่ามีกี่หน้า โดยจะแสดงเป็นจุดๆไข่ปลา
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HistoryStore()) //ใช้environmentObjectเพื่อที่จะได้สร้างobjectและส่งออกไปให้classต่างๆผ่านenvironment
    }
}
