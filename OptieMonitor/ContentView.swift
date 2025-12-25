//
//  ContentView.swift
//  OptieMonitor
//
//  Created by André Hartman on 24/12/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewModel.self) private var viewModel

    var body: some View {
        if viewModel.intraday.list.isEmpty {
            ContentUnavailableView(
                "Nog geen gegevens beschikbaar",
                systemImage: "icloud.and.arrow.down"
            )
        } else {
            if Ipad {
                IPadView(viewModel: viewModel)
                    .environment(viewModel)
            } else {
                TabView {
                    IntradayView(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "calendar.circle")
                            Text("Intraday")
                        }
                    InterdayView()
                        .tabItem {
                            Image(systemName: "calendar.circle.fill")
                            Text("Interday")
                        }
                    SettingsView(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Notificaties")
                        }
                    NewOrderView(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "plus.circle")
                            Text("Nieuw")
                        }
                }
                .environment(viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
