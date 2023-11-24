//
//  ContentView.swift
//  CalendarApp
//
//  Created by 高橋直希 on 2023/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedDate = Date() // カレンダーで選択している日付を保持する変数
    @Query private var items: [Item]
    
    var body: some View {
        NavigationSplitView {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .onChange(of: selectedDate) { _ in
                        // Handle change in date selection
                    }
                
                List(filteredItems(for: selectedDate)) { item in
                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: selectedDate)
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    private func filteredItems(for date: Date) -> [Item] {
        // Filter the `items` array to return only those items that match the selected date
        return items.filter { Calendar.current.isDate($0.timestamp, inSameDayAs: date) }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
