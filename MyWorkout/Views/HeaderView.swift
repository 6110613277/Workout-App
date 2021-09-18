//
//  SwiftUIView.swift
//  MyWorkout
//
//  Created by Siriluk Rachaniyom on 11/9/2564 BE.
//

import SwiftUI

struct HeaderView: View {
    @Binding var selectedTab: Int
    
    let titleText: String
    
    var body: some View {
        VStack {
            Text(titleText)
                .font(.largeTitle)
            HStack{
                ForEach(0 ..< 7) { index in
                    let fill = index == selectedTab ? ".fill" : ""
                    Image(systemName: "\(index + 1).circle\(fill)") //ปุ่ม 1-4
                        .onTapGesture { //ทำให้เปลี่ยนหน้าได้จากtab header
                            selectedTab = index
                        }
                }
            }
            .font(.title2)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(selectedTab: .constant(0), titleText: "Squat")
                .previewLayout(.sizeThatFits)//จะทำให้แสดงเฉพาะส่วนของตัวview
            HeaderView(selectedTab: .constant(1), titleText: "Squat")
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .accessibilityLarge)
                .previewLayout(.sizeThatFits)
        }
    }
}
