//
//  NewOrderView.swift
//  OptieMonitor
//
//  Created by André Hartman on 01/04/2025.
//
import SwiftUI

struct NewOrderView: View {
    @Bindable var viewModel: ViewModel

    var body: some View {
        //NavigationView {
            Form {
                Section {
                    Picker(
                        selection: $viewModel.expiry,
                        label: Text("Expiraties")
                    ) {
                        ForEach(0..<viewModel.expiries.count, id: \.self) {
                            let expiry = viewModel.expiries[$0]
                            //Text(expiry)
                            Text("aha")
                        }
                    }
                }
            }
            //.navigationBarTitle("Notificaties", displayMode: .inline)
        //}
        .onAppear {
             Task { await viewModel.getJsonTest(action: "expiries") }
        }
    }
}
