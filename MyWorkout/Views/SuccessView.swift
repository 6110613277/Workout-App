//
//  SuccessView.swift
//  MyWorkout
//
//  Created by Siriluk Rachaniyom on 11/9/2564 BE.
//

import SwiftUI

struct SuccessView: View {
    @Environment(\.presentationMode) var presentationMode//@Environmentไว้ใช้สำหรับ ถ้ามีอะไรpopup ขึ้นมา ค่าpresentationModeจะถูกset
    @Binding var selectedTab : Int
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "hand.raised.fill")
                    .resizedToFill(width: 75, height: 75)
                    .foregroundColor(.purple)
                Text ("High Five!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text ("""
                    Good job completing all four exercise!
                    Remember tomorrow's another day.
                    So eat well and get some rest.
                    """)// """ คือการพิมพ์Textหลายบรรทัด
                    .multilineTextAlignment(.center)//ให้ตัวหนังสืออยู่กลางไม่ชิดไปด้านใดด้านหนึ่ง
                    .foregroundColor(.gray)
            }
            VStack {
                Spacer()
                
                Button("Continue") {
                    presentationMode.wrappedValue.dismiss() //เมื่อกดปุ่มpopupที่เด้งขึ้นมาจะปิดไป
                    selectedTab = 9 //setให้เมื่อปิดpopupจากคำสั่งด้านบนก็จะกลับไปหน้า WelcomeView
                }
            }
            .padding()
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(selectedTab: .constant(3))
    }
}
