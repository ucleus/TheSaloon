//
//  The_SaloonApp.swift
//  The Saloon
//
//  Created by SEAN BLAKE on 7/9/22.
//

import SwiftUI
import Firebase

@main
struct The_SaloonApp: App {
    // This loads first and configures Firebase BundleID & other firebase features
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
