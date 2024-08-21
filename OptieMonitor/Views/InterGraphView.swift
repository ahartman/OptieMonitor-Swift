//
//  InterGraph.swift
//  OMSwiftUI
//
//  Created by André Hartman on 14/10/2020.
//  Copyright © 2020 André Hartman. All rights reserved.
//
import Charts
import SwiftUI

struct InterGraphView: View {
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            InterChartView()
                .padding(20.0)
                .navigationBarTitle("Interday waarde ", displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: { dismiss() })
                        { Image(systemName: "table") }
                )
        }
    }
}

struct InterChartView: View {
    @Environment(ViewModel.self) private var viewModel

    var body: some View {
        Chart {
            ForEach(viewModel.interday.grafiekWaarden.filter { $0.type != "Index" }, id: \.self) { element in
                BarMark(
                    x: .value("Datum", element.datumTijd),
                    y: .value("Waarde in €", element.waarde)
                )
                .foregroundStyle(by: .value("Type Color", element.type))
            }
            /*
            ForEach(viewModel.interday.grafiekWaarden.filter { $0.type == "Index" }, id: \.self) { element in
                LineMark(
                    x: .value("Uur", element.datumTijd),
                    y: .value("Index", element.waarde)
                )
                .foregroundStyle(by: .value("Type Color", element.type))
            }
             */
        }
        .padding(20)
        .background(.white)
        .chartXAxis {
            AxisMarks(values: xValues()) { _ in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.day().month(.twoDigits).locale(Locale(identifier: "nl-BE")), centered: false, collisionResolution: .greedy)
            }
        }
        .chartXAxisLabel("Datum", position: .bottom)

        .chartYAxis {
            AxisMarks(preset: .aligned, position: .leading, values: viewModel.interday.grafiekAssen["Euro"] ?? [0.0]) { _ in
                AxisGridLine()
                AxisValueLabel(format: .currency(code: "EUR").precision(.fractionLength(0)))
            }
            /*
            AxisMarks(preset: .aligned, position: .trailing, values: viewModel.interday.grafiekAssen["Index"] ?? [0.0]) { _ in
                AxisGridLine()
                AxisValueLabel()
            }
             */
        }
        .chartYAxisLabel("Waarde in €", position: .leading)

        .chartForegroundStyleScale(
            ["Call": .green, "Put": .purple /*, "Index": .black */]
        )
    }

    @MainActor
    func xValues() -> [Date] {
        return viewModel.interday.grafiekWaarden
            .filter { $0.type == "Index" }
            .map { $0.datumTijd }
    }

    func xValue(value: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "nl")
        formatter.setLocalizedDateFormatFromTemplate("d-M")
        // let d1 = model.interday.grafiekWaarden.filter({$0.type == "Index"}).map({$0.datumTijd})
        // let d2 = d1.map({formatter.string(from: $0.datumTijd)})
        let d2 = formatter.string(from: value)
        return d2
    }
}
