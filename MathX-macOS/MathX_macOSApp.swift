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
    
    @State var currentTab: String = "person"

    var body: some Scene {
        WindowGroup {
            ContentView()
                .focusable(false)
                .background(Color("BG").ignoresSafeArea())
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Text("")
                    }
                }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) {
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let menus = ["View"]

        menus.forEach { menu in
            NSApp.mainMenu?.item(withTitle: menu).map {
                NSApp.mainMenu?.removeItem($0)
            }
        }
    }
}
