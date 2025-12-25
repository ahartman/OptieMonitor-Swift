//
//  InterIndexView.swift
//  OptieMonitor
//
//  Created by André Hartman on 20/12/2024.
//

import Charts
import SwiftUI

struct IndexGraphView: View {
    @Environment(ViewModel.self) private var viewModel

    var body: some View {
        NavigationView {
            IndexChartView()
                .padding(20.0)
                .navigationBarTitle("Interday index ", displayMode: .inline)
        }
    }
}

struct IndexChartView: View {
    @Environment(ViewModel.self) private var viewModel

    var body: some View {
        let grafiekWaarden = viewModel.interday.grafiekWaarden.filter {
            $0.type == "Index"
        }
        let lijnen = yLijnen(grafiekWaarden: grafiekWaarden)

        Chart {
            ForEach(grafiekWaarden, id: \.self) { element in
                LineMark(
                    x: .value("", element.datumTijd, unit: .day),
                    y: .value("", element.waarde)
                )
                .foregroundStyle(by: .value("Type Color", element.type))
            }
            ForEach(lijnen, id: \.self) { lijn in
                RuleMark(y: .value("rulers", lijn))
                    .foregroundStyle(.red)
                    .lineStyle(StrokeStyle(lineWidth: 1.0))
                    .annotation(
                        position: .topTrailing,
                        overflowResolution: .init(x: .fit, y: .disabled)
                    ) {
                        ZStack {
                            Text(
                                "\(lijn.formatted(.number.precision(.fractionLength(0))))"
                            )
                            .font(.footnote)
                            .foregroundStyle(.red)
                        }
                    }
             }
        }
        .padding(20)
        .background(.white)

        .chartXAxis {
            AxisMarks(values: grafiekWaarden.map { $0.datumTijd }) { _ in
                AxisGridLine()
                AxisValueLabel(
                    format: .dateTime.day().month(.twoDigits).locale(
                        Locale(identifier: "nl-BE")), centered: false,
                    collisionResolution: .greedy)
            }
        }
        .chartXAxisLabel("Datum", position: .bottom)

        .chartYAxis {
            AxisMarks(
                preset: .aligned, position: .leading,
                values: viewModel.interday.grafiekAssen["Index"] ?? [0.0]
            ) { _ in
                AxisGridLine()
                AxisValueLabel()
            }
        }
        .chartYAxisLabel("Index", position: .leading)
        .chartYScale(domain: .automatic(includesZero: false))
    }

    func yLijnen(grafiekWaarden: [GraphLine]) -> [Double] {
        return [grafiekWaarden[0].waarde, captions.strike1, captions.strike2]
    }
}
