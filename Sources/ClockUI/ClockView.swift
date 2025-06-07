//
//  ClockView.swift
//  ClockUI
//
//  https://github.com/RyoDeveloper/ClockUI
//  Copyright © 2025 RyoDeveloper. All rights reserved.
//

import SwiftUI

public struct ClockView: View {
    private let dateFormat: Date.FormatStyle
    private let timeFormat: Date.FormatStyle
    private let font: Font
    
    public init(
        dateFormat: Date.FormatStyle = Date.FormatStyle()
            .year()
            .month()
            .day()
            .weekday(.abbreviated),
        timeFormat: Date.FormatStyle = Date.FormatStyle()
            .hour()
            .minute()
            .second(),
        font: Font = .title
    ) {
        self.dateFormat = dateFormat
        self.timeFormat = timeFormat
        self.font = font
    }

    public var body: some View {
        VStack {
            TimelineView(.periodic(from: Date(), by: 1)) { timeline in
                Group {
                    Text(timeline.date, format: dateFormat)
                        .accessibilityLabel("日付")
                    
                    Text(timeline.date, format: timeFormat)
                        .accessibilityLabel("時刻")
                }
                .font(font)
                .monospacedDigit()
            }
        }
        .padding()
    }
}

#Preview {
    ClockView()
}
