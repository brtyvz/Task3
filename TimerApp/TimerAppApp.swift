//
//  TimerAppApp.swift
//  TimerApp
//
//  Created by Berat Yavuz on 2.09.2023.
//

import SwiftUI

@main
struct TimerAppApp: App {
    @StateObject var timerManager = TimerManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timerManager)
            
        }
    }
}
