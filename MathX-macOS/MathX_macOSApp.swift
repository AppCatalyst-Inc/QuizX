//
//  MathX_macOSApp.swift
//  MathX-macOS
//
//  Created by Tristan on 27/02/2023.
//

import SwiftUI

@main
struct MathX_macOSApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @FocusState var textfieldFocus
    
    @State var currentTab: String = "square.split.bottomrightquarter"
    
    var body: some Scene {
        WindowGroup {
            ContentView(currentTab: currentTab, textfieldFocus: $textfieldFocus)
                .focusable(false) // disables tab button from selecting items
                .background(Color("BG").ignoresSafeArea()) // sets bg colour to cover title bar / toolbar too
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) { // removes option to add new windows with command N or through menu bar
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let _ = NSApplication.shared.windows.map { $0.tabbingMode = .disallowed }
    }
}
