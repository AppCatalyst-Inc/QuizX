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
    @AppStorage("pinSidebar", store: .standard) var pinSidebar = true
    
    @State var showSidebar = false
    

    var body: some Scene {
        WindowGroup {
            ContentView(pinSidebar: $pinSidebar, showSidebar: $showSidebar)
                .focusable(false)
                .background(Color("BG").ignoresSafeArea())
                .onChange(of: pinSidebar) { _ in
                    withAnimation {
                        if pinSidebar {
                            showSidebar = true
                        } else {
                            showSidebar = false
                        }
                    }
                }
                .onAppear {
                    withAnimation {
                        if pinSidebar {
                            showSidebar = true
                        } else {
                            showSidebar = false
                        }
                    }
                }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) {
            }
            
            CommandGroup(before: .sidebar) {
                Button(pinSidebar ? "Unpin Sidebar" : "Pin Sidebar") {
                    withAnimation {
                        pinSidebar.toggle()
                    }
                }
                .keyboardShortcut("S", modifiers: [.command, .shift])
                
                Button(showSidebar ? "Hide Sidebar" : "Show Sidebar") {
                    withAnimation {
                        showSidebar.toggle()
                    }
                }
                .keyboardShortcut("S", modifiers: .command)
                .disabled(pinSidebar)
                
                Divider()
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
