//  ContentView.swift
//  OptieMonitor
//
//  Created by André Hartman on 24/12/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.horizontalSizeClass) private var horizontalSize

    var body: some View {
        if viewModel.intraday.list.isEmpty {
            ContentUnavailableView(
                "Nog geen gegevens beschikbaar ...",
                systemImage: "icloud.slash"
            )
        } else {
            TabView {
                let _ = print(
                    "TabView: \(viewModel.intraday.list.isEmpty ? "empty" : "not empty")"
                )
                if horizontalSize == .regular {
                    Tab("Overzicht", systemImage: "house") {
                        IPadView(viewModel: viewModel)
                            .environment(viewModel)
                    }
                    .customizationID("com.om.main")
                } else {
                    TabSection("iPhone") {
                        Tab("Intraday", systemImage: "calendar.circle") {
                            IntradayView(viewModel: viewModel)
                        }
                        .customizationID("com.om.intraday")

                        Tab("Interday", systemImage: "calendar.circle.fill") {
                            InterdayView()
                        }
                        .customizationID("com.om.interday")
                    }
                }
                TabSection {
                    Tab(
                        "Nieuwe Order",
                        systemImage: "text.pad.header.badge.plus"
                    ) {
                        NewOrderView(viewModel: viewModel)
                    }
                    .customizationID("com.om.newOrder")
                    Tab("Instellingen", systemImage: "gear") {
                        SettingsView(viewModel: viewModel)
                    }
                    .customizationID("com.om.settings")
                } header: {
                    Label("Extra", systemImage: "folder")
                }
                .defaultVisibility(.hidden, for: .tabBar)
            }
            .tabViewStyle(.sidebarAdaptable)
            .tabBarMinimizeBehavior(.onScrollDown)
            .tabViewSidebarHeader {
                Text("OptieMonitor \(version)")
            }
        }
    }
}
