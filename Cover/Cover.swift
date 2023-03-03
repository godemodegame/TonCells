//
//  Cover.swift
//  Cover
//
//  Created by Кирилл Кириленко on 03.03.2023.
//

import Combine

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> CoverEntry {
        CoverEntry(image: nil, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (CoverEntry) -> ()) {
        Task {
            do {
                let (data, _) = try await URLSession
                    .shared
                    .data(from: URL(string: "https://app.toncells.org:9917/API/getMAPEDIT")!)
                
                completion(CoverEntry(
                    image: UIImage(data: data),
                    configuration: configuration
                ))
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            do {
                var urlRequest = URLRequest(url: URL(string: "https://app.toncells.org:9917/API/getArea")!)
                let jsonData = ["areaId": 7]
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: jsonData)
                urlRequest.httpMethod = "POST"
                urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
                let (data, _) = try await URLSession
                    .shared
                    .data(for: urlRequest)
                
                let timeline = Timeline(entries: [CoverEntry(
                    image: UIImage(data: data),
                    configuration: configuration
                )], policy: .atEnd)
                completion(timeline)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

struct CoverEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Image(uiImage: entry.image!)
            .resizable()
            .aspectRatio(contentMode: .fill)
//        if let image = entry.image {
//            VStack {
//                Text("Ты пидор")
//                Image(uiImage: image)
//            }
//        } else {
//            Text("Ты пидор")
//        }
    }
}

struct Cover: Widget {
    let kind: String = "Cover"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            CoverEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
