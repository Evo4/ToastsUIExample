//
//  ContentView.swift
//  ToastsUIExample
//
//  Created by Vyacheslav Razumeenko on 30.01.2025.
//

import SwiftUI
import ToastsUI

struct ContentView: View {
    @Environment(\.presentToast) var presentToast

    var body: some View {
        VStack {
            Button("Show Toast") {
                let toast = ToastValue(
                    icon: Image(systemName: "bell"),
                    message: "You have a new notification.",
                    button: .init(title: "OK", color: .green, action: { })
                )
                presentToast(toast)
            }
            .buttonStyle(.borderedProminent)
            Button("Show Red Toast") {
                let toast = ToastValue(
                    icon: Image(systemName: "bell"),
                    message: "You have a new notification.",
                    button: .init(title: "OK", color: .red, action: { }),
                    duration: 999
                )
                presentToast(toast)
            }
            .buttonStyle(.borderedProminent)
            Button("Show Loader") {
                Task {
                    try await presentToast(message: "Loading") {
                        try await Task.sleep(for: .seconds(3))
                    } onSuccess: { _ in
                            .init(message: "Success")
                    } onFailure: { _ in
                            .init(message: "Error")
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
