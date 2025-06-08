//
//  ClockView.swift
//  ClockUI
//
//  https://github.com/RyoDeveloper/ClockUI
//  Copyright © 2025 RyoDeveloper. All rights reserved.
//

import SwiftUI

/// 時計表示のカスタマイズ可能なビュー
/// - Parameter datePosition: 日付の表示位置（デフォルト: .top）
public struct ClockView: View {
    /// 日付の表示位置を定義する列挙型
    public enum DatePosition: Int {
        case top
        case bottom
        case leading
        case trailing
    }
    
    private enum Constants {
        static let aspectRatio: CGFloat = 190/80
        static let spacing: CGFloat = 4
        static let minimumScaleFactor: CGFloat = 0.2
        
        // FormatStyleの定数
        static let dateFormat: Date.FormatStyle = Date.FormatStyle()
            .year()
            .month()
            .day()
            .weekday(.abbreviated)
        
        static let timeFormat: Date.FormatStyle = Date.FormatStyle()
            .hour()
            .minute()
            .second()
            
        static let monthDayFormat: Date.FormatStyle = Date.FormatStyle()
            .month(.twoDigits)
            .day(.twoDigits)
            
        static let weekdayFormat: Date.FormatStyle = Date.FormatStyle()
            .weekday(.wide)
            
        // Accessibility Labels
        static let accessibilityLabelDate: String = String(localized: "Date")
        static let accessibilityLabelTime: String = String(localized: "Time")
        static let accessibilityLabelMonthDay: String = String(localized: "Month and Day")
        static let accessibilityLabelWeekday: String = String(localized: "Weekday")
    }
    
    private let datePosition: DatePosition
    
    /// 時計ビューの初期化
    /// - Parameters:
    ///   - datePosition: 日付の表示位置（デフォルト: .top）
    public init(datePosition: DatePosition = .top) {
        self.datePosition = datePosition
    }
    
    @ViewBuilder
    public var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                content(date: context.date, width: width, height: height)
            }
        }
        .aspectRatio(Constants.aspectRatio, contentMode: .fit)
    }
    
    @ViewBuilder
    private func content(date: Date, width: CGFloat, height: CGFloat) -> some View {
        let dateFont = {
            switch datePosition {
                case .top, .bottom:
                    return Font.system(size: height / 2, weight: .medium, design: .monospaced)
                case .leading, .trailing:
                    return Font.system(size: height * 0.2, weight: .semibold, design: .monospaced)
            }
        }()
        let timeFont = Font.system(size: height, weight: .bold, design: .monospaced)
        
        switch datePosition {
        case .top:
            VStack(spacing: Constants.spacing) {
                Text(date, format: Constants.dateFormat)
                    .font(dateFont)
                    .accessibilityLabel(Constants.accessibilityLabelDate)
                    .lineLimit(1)
                    .minimumScaleFactor(Constants.minimumScaleFactor)
                Text(date, format: Constants.timeFormat)
                    .font(timeFont)
                    .accessibilityLabel(Constants.accessibilityLabelTime)
                    .lineLimit(1)
                    .minimumScaleFactor(Constants.minimumScaleFactor)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        case .bottom:
            VStack(spacing: Constants.spacing) {
                Text(date, format: Constants.timeFormat)
                    .font(timeFont)
                    .accessibilityLabel(Constants.accessibilityLabelTime)
                    .lineLimit(1)
                    .minimumScaleFactor(Constants.minimumScaleFactor)
                Text(date, format: Constants.dateFormat)
                    .font(dateFont)
                    .accessibilityLabel(Constants.accessibilityLabelDate)
                    .lineLimit(1)
                    .minimumScaleFactor(Constants.minimumScaleFactor)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        case .leading:
            HStack(spacing: Constants.spacing) {
                VStack(spacing: 0) {
                    Text(date, format: Constants.monthDayFormat)
                        .font(dateFont)
                        .accessibilityLabel(Constants.accessibilityLabelMonthDay)
                        .lineLimit(1)
                        .minimumScaleFactor(Constants.minimumScaleFactor)
                    Text(date, format: Constants.weekdayFormat)
                        .font(dateFont)
                        .accessibilityLabel(Constants.accessibilityLabelWeekday)
                        .lineLimit(1)
                        .minimumScaleFactor(Constants.minimumScaleFactor)
                }
                Text(date, format: Constants.timeFormat)
                    .font(timeFont)
                    .accessibilityLabel(Constants.accessibilityLabelTime)
                    .lineLimit(1)
                    .minimumScaleFactor(Constants.minimumScaleFactor)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        case .trailing:
            HStack(spacing: Constants.spacing) {
                Text(date, format: Constants.timeFormat)
                    .font(timeFont)
                    .accessibilityLabel(Constants.accessibilityLabelTime)
                    .lineLimit(1)
                    .minimumScaleFactor(Constants.minimumScaleFactor)
                VStack(spacing: 0) {
                    Text(date, format: Constants.monthDayFormat)
                        .font(dateFont)
                        .accessibilityLabel(Constants.accessibilityLabelMonthDay)
                        .lineLimit(1)
                        .minimumScaleFactor(Constants.minimumScaleFactor)
                    Text(date, format: Constants.weekdayFormat)
                        .font(dateFont)
                        .accessibilityLabel(Constants.accessibilityLabelWeekday)
                        .lineLimit(1)
                        .minimumScaleFactor(Constants.minimumScaleFactor)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

#Preview("英語表示") {
    ScrollView {
        VStack(spacing: 20) {
            Group {
                Text("FontStyle.large").font(.headline)
                ClockView(datePosition: .top)
                    .border(.black)
                ClockView(datePosition: .bottom)
                    .border(.black)
                ClockView(datePosition: .leading)
                    .border(.black)
                ClockView(datePosition: .trailing)
                    .border(.black)
            }
            Divider()
            Group {
                Text("FontStyle.medium").font(.headline)
                ClockView(datePosition: .top)
                    .frame(height: 100)
                    .border(.black)
                ClockView(datePosition: .bottom)
                    .frame(height: 100)
                    .border(.black)
                ClockView(datePosition: .leading)
                    .frame(height: 100)
                ClockView(datePosition: .trailing)
                    .frame(height: 100)
            }
            Divider()
            Group {
                Text("FontStyle.small").font(.headline)
                ClockView(datePosition: .top)
                    .frame(height: 50)
                    .border(.black)
                ClockView(datePosition: .bottom)
                    .frame(height: 50)
                    .border(.black)
                ClockView(datePosition: .leading)
                    .frame(height: 50)
                    .border(.black)
                ClockView(datePosition: .trailing)
                    .frame(height: 50)
                    .border(.black)
            }
        }
        .padding()
    }
}

#Preview("日本語表示") {
    VStack(spacing: 20) {
        ClockView(
            datePosition: .top
        )
        ClockView(
            datePosition: .bottom
        )
        ClockView(
            datePosition: .leading
        )
        ClockView(
            datePosition: .trailing
        )
    }
    .padding()
    .environment(\.locale, Locale(identifier: "ja_JP"))
}
