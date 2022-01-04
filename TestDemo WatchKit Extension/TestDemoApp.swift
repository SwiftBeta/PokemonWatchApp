//
//  TestDemoApp.swift
//  TestDemo WatchKit Extension
//
//  Created by Home on 4/1/22.
//

import SwiftUI

@main
struct TestDemoApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
