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
    @State private var selectedDate = Date()
    @Query private var items: [Item]
    @State private var showingDiaryEntrySheet = false // To show modal sheet for diary entry
    @State private var diaryText = "" // To capture user's diary text input
    
    var body: some View {
        NavigationSplitView {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .onChange(of: selectedDate) { _ in
                        // Handle change in date selection
                    }
                
                List(filteredItems(for: selectedDate)) { item in
                    VStack{
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        Text(item.diaryText)
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: { showingDiaryEntrySheet.toggle() }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingDiaryEntrySheet) {
                // 日記の文章を記録するためのView：あとで定義します
                DiaryEntryView(diaryText: $diaryText) {
                    addItem()
                    showingDiaryEntrySheet.toggle()
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: selectedDate, diaryText: diaryText)
            modelContext.insert(newItem)
            diaryText = "" // Reset the diary text for next entry
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


struct DiaryEntryView: View {
    @Binding var diaryText: String
    var onSave: () -> Void

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $diaryText)
                    .padding()
            }
            .navigationTitle("Diary Entry")
            .navigationBarItems(trailing: Button("Save") {
                onSave()
            })
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
