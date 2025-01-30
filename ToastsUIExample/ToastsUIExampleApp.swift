//
//  ToastsUIExampleApp.swift
//  ToastsUIExample
//
//  Created by Vyacheslav Razumeenko on 30.01.2025.
//

import SwiftUI
import ToastsUI

@main
struct ToastsUIExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .installToast(position: .top)
        }
    }
}
