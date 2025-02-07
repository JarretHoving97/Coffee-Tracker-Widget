//
//  TrackMyCoffeeWidgetLiveActivity.swift
//  TrackMyCoffeeWidget
//
//  Created by Jarret on 06/02/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TrackMyCoffeeWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TrackMyCoffeeWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TrackMyCoffeeWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TrackMyCoffeeWidgetAttributes {
    fileprivate static var preview: TrackMyCoffeeWidgetAttributes {
        TrackMyCoffeeWidgetAttributes(name: "World")
    }
}

extension TrackMyCoffeeWidgetAttributes.ContentState {
    fileprivate static var smiley: TrackMyCoffeeWidgetAttributes.ContentState {
        TrackMyCoffeeWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TrackMyCoffeeWidgetAttributes.ContentState {
         TrackMyCoffeeWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TrackMyCoffeeWidgetAttributes.preview) {
   TrackMyCoffeeWidgetLiveActivity()
} contentStates: {
    TrackMyCoffeeWidgetAttributes.ContentState.smiley
    TrackMyCoffeeWidgetAttributes.ContentState.starEyes
}
