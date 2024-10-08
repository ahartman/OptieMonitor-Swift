//
//  QuotesView.swift
//  OMSwiftUI
//
//  Created by André Hartman on 01/07/2020.
//  Copyright © 2020 André Hartman. All rights reserved.
//
import SwiftUI

struct IntradayView: View {
    @Bindable var viewModel: ViewModel
    @State private var showGraphSheet = false

    var body: some View {
        GeometryReader { geo in
            NavigationView {
                List {
                    Section(
                        header: HeaderView(geo: geo.size, dataStale: viewModel.dataStale),
                        footer: FooterView(geo: geo.size, footerLines: viewModel.intraday.footer)
                    ) { ForEach(viewModel.intraday.list) {
                        line in
                        RowView(geo: geo.size, line: line)
                    }
                    }
                }
                .listStyle(GroupedListStyle())
                .environment(\.defaultMinListRowHeight, 10)
                .navigationBarTitle("Intraday (\(UIApplication.appVersion!))", displayMode: .inline)
                .navigationBarItems(
                    leading:
                        Button(action: { showGraphSheet.toggle() })
                    { Image(systemName: "chart.bar") },
                    trailing:
                        Button(action: { Task {
                            await viewModel.getJsonData(action: "cleanOrder")
                        }})
                    { Image(systemName: "arrow.clockwise") }
                )
                .refreshable {
                    await viewModel.getJsonData(action: "currentOrder")
                }
            }
            .alert(isPresented: $viewModel.isMessage) {
                Alert(title: Text("AEX"),
                      message: Text(viewModel.message ?? ""),
                      dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showGraphSheet) {
                IntraGraphView()
            }
        }
    }
}
