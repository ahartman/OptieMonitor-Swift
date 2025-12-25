//
//  iPadView.swift
//  OptieMonitor
//
//  Created by André Hartman on 18/08/2024.
//

import SwiftUI

struct IPadView: View {
    @Bindable var viewModel: ViewModel

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    Task {
                        await viewModel.getJsonData(action: "cleanOrder")
                    }
                }) { Image(systemName: "arrow.clockwise") }
                .frame(alignment: .leading)
                .padding(.leading)
                .foregroundColor(.black)

                Text("\(captions.caption)")
                    .modifier(StaleModifier(dataStale: viewModel.dataStale))
                    .frame(alignment: .center)

                if test {
                    Button(action: {
                        Task {
                            await viewModel.getJsonTest(
                                action: "strategies"
                            )
                        }
                    }) { Image(systemName: "arrow.clockwise") }
                    .frame(alignment: .trailing)
                    .padding(.trailing)
                    .foregroundColor(.black)

                    Button(action: {
                        Task {
                            await viewModel.getJsonTest(action: "expiries")
                        }
                    }) { Image(systemName: "arrow.clockwise") }
                    .frame(alignment: .trailing)
                    .padding(.trailing)
                    .foregroundColor(.black)
                }
            }
            .padding(.top, 10)
            Divider()
            HStack {
                List {
                    Section(
                        header: HeaderView(
                            dataStale: viewModel.dataStale
                        ),
                        footer: FooterView(
                            footerLines: viewModel.intraday.footer
                        )
                    ) {
                        ForEach(viewModel.intraday.list, id: \.id) {
                            line in RowView(line: line)
                        }
                    }
                }
                Divider()
                List {
                    Section(
                        header: HeaderView(
                            dataStale: viewModel.dataStale
                        ),
                        footer: FooterView(
                            footerLines: viewModel.interday.footer
                        )
                    ) {
                        ForEach(viewModel.interday.list, id: \.id) { line in
                            RowView(line: line)
                        }
                    }
                }
            }.environment(\.defaultMinListRowHeight, rowHeight)
            Divider()
            HStack {
                IntraChartView()
                    .cornerRadius(10.0)
                Divider()
                if viewModel.currentOrientation == .landscape {
                    IndexChartView()
                        .cornerRadius(10.0)
                    Divider()
                }
                InterChartView()
                    .cornerRadius(10.0)
            }
            .padding(16)
            .background(Color(.systemGroupedBackground))
        }
    }
}
