//
//  LaunchRow.swift
//  T Minus
//
//  Created by Dylan Hawley on 8/27/24.
//

import SwiftUI


struct LaunchRow: View {
    var launch: Launch
    
    let backgroundTopStops: [Gradient.Stop] = [
        .init(color: .midnightStart, location: 0),
        .init(color: .midnightStart, location: 0.25),
        .init(color: .sunriseStart, location: 0.33),
        .init(color: .sunnyDayStart, location: 0.38),
        .init(color: .sunnyDayStart, location: 0.7),
        .init(color: .sunsetStart, location: 0.78),
        .init(color: .midnightStart, location: 0.82),
        .init(color: .midnightStart, location: 1)
    ]

    let backgroundBottomStops: [Gradient.Stop] = [
        .init(color: .midnightEnd, location: 0),
        .init(color: .midnightEnd, location: 0.25),
        .init(color: .sunriseEnd, location: 0.33),
        .init(color: .sunnyDayEnd, location: 0.38),
        .init(color: .sunnyDayEnd, location: 0.7),
        .init(color: .sunsetEnd, location: 0.78),
        .init(color: .midnightEnd, location: 0.82),
        .init(color: .midnightEnd, location: 1)
    ]
    
    let cloudTopStops: [Gradient.Stop] = [
        .init(color: .darkCloudStart, location: 0),
        .init(color: .darkCloudStart, location: 0.25),
        .init(color: .sunriseCloudStart, location: 0.33),
        .init(color: .lightCloudStart, location: 0.38),
        .init(color: .lightCloudStart, location: 0.7),
        .init(color: .sunsetCloudStart, location: 0.78),
        .init(color: .darkCloudStart, location: 0.82),
        .init(color: .darkCloudStart, location: 1)
    ]

    let cloudBottomStops: [Gradient.Stop] = [
        .init(color: .darkCloudEnd, location: 0),
        .init(color: .darkCloudEnd, location: 0.25),
        .init(color: .sunriseCloudEnd, location: 0.33),
        .init(color: .lightCloudEnd, location: 0.38),
        .init(color: .lightCloudEnd, location: 0.7),
        .init(color: .sunsetCloudEnd, location: 0.78),
        .init(color: .darkCloudEnd, location: 0.82),
        .init(color: .darkCloudEnd, location: 1)
    ]
    
    func timeIntervalFromDate(_ date: Date) -> Double {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let timeInterval = date.timeIntervalSince(startOfDay)
        return timeInterval / (24 * 60 * 60)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(launch.mission)
                .font(.headline)
            ScrollView(.horizontal) {
                HStack {
                    Text(launch.vehicle)
                        .padding(5)
                        .background(Color(.tertiarySystemFill))
                        .cornerRadius(5)
                    Text(launch.pad)
                        .padding(5)
                        .background(Color(.tertiarySystemFill))
                        .cornerRadius(5)
                }
                .font(.system(size: 16, weight: .light))
            }
            Text(launch.details)
                .font(.system(size: 16, weight: .light))
                .lineLimit(3)
            FormattedDateView(date: launch.net)
                .font(.system(size: 16, weight: .light))
                .opacity(0.8)
        }
        .foregroundStyle(.white)
        .padding()
        .background(
            ZStack {
                LinearGradient(colors: [
                    backgroundTopStops.interpolated(amount: timeIntervalFromDate(launch.net)),
                    backgroundBottomStops.interpolated(amount: timeIntervalFromDate(launch.net))
                ], startPoint: .top, endPoint: .bottom)
//                CloudsView(thickness: Cloud.Thickness.allCases.randomElement() ?? .regular,
//                           topTint: cloudTopStops.interpolated(amount: timeIntervalFromDate(launch.net)),
//                           bottomTint: cloudBottomStops.interpolated(amount: timeIntervalFromDate(launch.net)))
            }
        )
        .cornerRadius(15)
    }
}

struct FormattedDateView: View {
    let date: Date

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma z"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter
    }()

    var body: some View {
        HStack {
            Text(Self.dateFormatter.string(from: date))
            Spacer()
            Text(Self.timeFormatter.string(from: date))
        }
    }
}

#if DEBUG
#Preview {
    ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
        VStack {
            ForEach(Launch.sampleLaunches.prefix(1), id: \.code) { launch in
                LaunchRow(launch: launch)
            }
        }
        .padding()
        .frame(minWidth: 300, alignment: .leading)
    }
}
#endif
