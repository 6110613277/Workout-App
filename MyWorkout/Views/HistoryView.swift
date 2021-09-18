//
//  HistoryView.swift
//  MyWorkout
//
//  Created by Siriluk Rachaniyom on 11/9/2564 BE.
//

import SwiftUI

struct HistoryView: View {
    @Binding var showHistory : Bool
    
    @EnvironmentObject var history : HistoryStore //linkผ่านEnvironmentObjectในContentView
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            VStack {
                Form{
                    ForEach(history.exerciseDays) { day in
                        Section(header: Text(day.date.formatted(as: "MMM d"))) {
                            ForEach(day.exercises, id: \.self) { exercise in
                                Text(exercise)
                            }
                        }
                    }
                }
            }
            
            Button(action: { showHistory.toggle() }) {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .padding(.trailing) //เป็นการขยับปุ่มกากบาทไม่ใช้ชิดขอบขวา
            }
            
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(showHistory: .constant(true))
            .environmentObject(HistoryStore())
    }
}
