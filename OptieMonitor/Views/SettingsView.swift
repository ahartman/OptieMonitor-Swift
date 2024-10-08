//
//  SettingsView.swift
//  OMSwiftUI
//
//  Created by André Hartman on 09/09/2020.
//  Copyright © 2020 André Hartman. All rights reserved.
//
import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel: ViewModel
    let severityData = ["Alle mutaties", "Onveranderd en negatief", "Laatste mutatie negatief", "Vandaag negatief", "Order negatief", "Geen meldingen"]
    let frequencyData = ["Elk kwartier", "Elk half uur", "Elk uur", "Geen"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $viewModel.notificationSet.severity, label: Text("Welke mutaties")) {
                        ForEach(0 ..< 6) {
                            Text(severityData[$0])
                        }
                    }
                }
                Section {
                   Picker(selection: $viewModel.notificationSet.frequency, label: Text("Hoe vaak")) {
                        ForEach(0 ..< 4) {
                            Text(frequencyData[$0])
                        }
                    }
                }
                Section {
                    Toggle("Met geluid", isOn: $viewModel.notificationSet.sound)
                }
            }
            .navigationBarTitle("Notificaties", displayMode: .inline)
        }
        .onDisappear {
            if notificationSetStale {
                Task {
                    await ViewModel().postJSONData(viewModel.notificationSet, action: "notificationSettings")
                    notificationSetStale = false
                }
            }
        }
    }
}
