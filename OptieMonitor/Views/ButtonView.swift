//
//  ButtonView.swift
//  OptieMonitor
//
//  Created by André Hartman on 07/01/2026.
//

import SwiftUI

struct ButtonView: View {
    @Binding var showGraphSheet: Bool
    @Namespace var glassNamespace

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color
                .clear
            GlassEffectContainer {
                ZStack {
                    Button {
                        withAnimation {
                            showGraphSheet.toggle()
                        }
                    } label: {
                        Label("Home", systemImage: "list.bullet")
                            .labelStyle(.iconOnly)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                    }
                    .glassEffect(
                        .regular.tint(.blue.opacity(0.8)).interactive()
                    )
                    .glassEffectID("menu", in: glassNamespace)
                }
            }.padding(32)
        }
    }
}
