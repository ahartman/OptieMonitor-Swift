//
//  InterdayRowView.swift
//  OMSwiftUI
//
//  Created by André Hartman on 06/07/2020.
//  Copyright © 2020 André Hartman. All rights reserved.
//
import SwiftUI

struct RowView: View {
    @Environment(ViewModel.self) private var viewModel
    var line: TableLine

    var body: some View {
        HStack(spacing: 0) {
            Text(line.datetimeText)
                .modifier(TextModifier())
                .foregroundColor(Color(line.warningColor))
            Text(line.callPriceText)
                .modifier(TextModifier())
                .foregroundColor(Color(line.warningColor))
            if viewModel.currentOrientation == .landscape  {
                Text(line.callDeltaText)
                    .modifier(TextModifier())
                    .foregroundColor(Color(line.callDeltaColor))
            }
            Text(line.putPriceText)
                .modifier(TextModifier())
                .foregroundColor(Color(line.warningColor))
            if viewModel.currentOrientation == .landscape  {
                Text(line.putDeltaText)
                    .modifier(TextModifier())
                    .foregroundColor(Color(line.putDeltaColor))
            }
            Text(line.orderValueText)
                .modifier(TextModifier())
                .foregroundColor(Color(line.orderValueColor))
            Text(line.indexText)
                .modifier(TextModifier())
                .foregroundColor(Color(line.warningColor))
        }.frame(height: rowHeight)
    }
}
