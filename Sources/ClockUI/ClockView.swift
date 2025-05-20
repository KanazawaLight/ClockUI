//
//  ClockView.swift
//  ClockUI
//  
//  https://github.com/RyoDeveloper/ClockUI
//  Copyright © 2025 RyoDeveloper. All rights reserved.
//

import SwiftUI

public struct ClockView: View {
    public var body: some View {
        VStack {
            TimelineView(.periodic(from: Date(), by: 1)) { timeline in
                Group {
                    Text(
                        timeline.date,
                        format: Date.FormatStyle()
                            .year()
                            .month()
                            .day()
                            .weekday(.abbreviated)
                    )

                    Text(
                        timeline.date,
                        format: Date.FormatStyle()
                            .hour()
                            .minute()
                            .second()
                    )
                }
                .font(.title)
                .monospacedDigit()
            }
        }
        .padding()
    }
}

#Preview {
    ClockView()
}
