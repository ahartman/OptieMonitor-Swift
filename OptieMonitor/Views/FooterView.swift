//
//  FooterView.swift
//  OptieMonitor
//
//  Created by André Hartman on 04/06/2021.
//
import SwiftUI

struct FooterView: View {
    // footerLine is passed as argument as it can be intraFooter or interfooter
    var footerLines: [FooterLine]

    var body: some View {
        VStack {
            FooterRowView(footerLine: footerLines[0])
            if !Ipad && footerLines.count > 1 {
                Divider()
                FooterRowView(footerLine: footerLines[1])
            }
        }
    }
}

struct FooterRowView: View {
    @Environment(ViewModel.self) private var viewModel
    var footerLine: FooterLine

    var body: some View {
        HStack {
            Text(footerLine.label).modifier(TextModifier())
            Text("\(footerLine.callPercent)").modifier(TextModifier())
            if viewModel.currentOrientation == .landscape {
                Text("").modifier(TextModifier())
            }
            Text("\(footerLine.putPercent)").modifier(TextModifier())
            if viewModel.currentOrientation == .landscape {
                Text("").modifier(TextModifier())
            }
            Text("\(footerLine.orderPercent)").modifier(TextModifier())
            Text("\(footerLine.index)").modifier(TextModifier())
        }
    }
}
