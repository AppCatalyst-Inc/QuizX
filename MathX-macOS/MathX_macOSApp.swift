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
    
    @State var isSidebarVisible = true
    
    var body: some Scene {
        WindowGroup {
            ContentView(isSidebarVisible: $isSidebarVisible)
                .focusable(false)
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button {
                            withAnimation {
                                isSidebarVisible.toggle()
                            }
                        } label: {
                            Image(systemName: "sidebar.left")
                        }
                    }
                }
                .onAppear {
                    NSApplication.shared.windows.forEach({ $0.tabbingMode = .disallowed })
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) {
            }
            
            CommandMenu("Sidebar") {
                Button {
                    withAnimation {
                        isSidebarVisible.toggle()
                    }
                } label: {
                    if isSidebarVisible == false {
                        Text("Show Sidebar")
                    } else {
                        Text("Hide Sidebar")
                    }
                }
                .keyboardShortcut("S")
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
