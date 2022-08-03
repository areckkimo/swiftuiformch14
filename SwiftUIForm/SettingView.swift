//
//  SettingView.swift
//  SwiftUIForm
//
//  Created by Eric Chen on 2022/7/25.
//

import SwiftUI

struct SettingView: View {
    @State private var selectedOrder = DisplayOrderType.alphabetical
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5
    @State private var showSettings = false
    var settingStore: SettingStore
    @Environment(\.presentationMode) var presentationModel
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedOrder) {
                        ForEach(DisplayOrderType.allCases, id: \.self) { orderType in
                            Text(orderType.text)
                        }
                    } label: {
                        Text("Display order")
                    }

                } header: {
                    Text("SORT PREFERENCE")
                }
                Section {
                    Toggle(isOn: $showCheckInOnly) {
                        Text("Show Check-In Only")
                    }
                    Stepper {
                        Text("Show \(String(repeating: "$", count: maxPriceLevel)) below")
                    } onIncrement: {
                        self.maxPriceLevel += 1
                        if self.maxPriceLevel > 5 {
                            self.maxPriceLevel = 5
                        }
                    } onDecrement: {
                        self.maxPriceLevel -= 1
                        if self.maxPriceLevel < 1 {
                            self.maxPriceLevel = 1
                        }
                    }
                } header: {
                    Text("FILTER PREFERENCE")
                }
            }
            
            .navigationBarTitle("Settings")
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationModel.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.black)
            }), trailing:
                Button(action: {
                    self.settingStore.showCheckInOnly = self.showCheckInOnly
                    self.settingStore.displayOrder = self.selectedOrder
                    self.settingStore.maxPriceLevel = self.maxPriceLevel
                    self.presentationModel.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                        .foregroundColor(.black)
                })
            )
        }
        .onAppear(perform: {
            self.selectedOrder = self.settingStore.displayOrder
            self.showCheckInOnly = self.settingStore.showCheckInOnly
            self.maxPriceLevel = self.settingStore.maxPriceLevel
        })
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(settingStore: SettingStore())
    }
}
