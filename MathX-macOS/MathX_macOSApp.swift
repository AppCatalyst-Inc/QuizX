//
//  MathX_macOSApp.swift
//  MathX-macOS
//
//  Created by Tristan on 27/02/2023.
//

import SwiftUI

@main
struct MathX_macOSApp: App {
    
    @State var toggleSidebar = false
    
    var body: some Scene {
        WindowGroup("") {
            ContentView()
                .onAppear {
                    NSApplication.shared.windows.forEach({ $0.tabbingMode = .disallowed })
                }
        }
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) {
            }
        }
    }
}
