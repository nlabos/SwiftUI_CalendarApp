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
    @State private var showingDiaryEntrySheet = false
    @State private var diaryText = ""
    @State private var editingItem: Item? // To track the item being edited

    var body: some View {
        NavigationSplitView {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .onChange(of: selectedDate) { _ in
                        // Handle change in date selection
                    }
                
                List {
                    ForEach(filteredItems(for: selectedDate)) { item in
                        VStack(alignment: .leading) {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                            Text(item.diaryText)
                        }
                        .onTapGesture {
                            diaryText = item.diaryText
                            editingItem = item
                            showingDiaryEntrySheet = true
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        diaryText = ""
                        editingItem = nil
                        showingDiaryEntrySheet = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingDiaryEntrySheet) {
                DiaryEntryView(diaryText: $diaryText, item: $editingItem) {
                    if let editingItem = editingItem {
                        updateItem(editingItem)
                    } else {
                        addItem()
                    }
                    showingDiaryEntrySheet = false
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
        }
    }
    
    private func updateItem(_ item: Item) {
        withAnimation {
            item.diaryText = diaryText
            try! modelContext.save()
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
        return items.filter { Calendar.current.isDate($0.timestamp, inSameDayAs: date) }
    }
}

struct DiaryEntryView: View {
    @Binding var diaryText: String
    @Binding var item: Item? // Optional Item for editing
    var onSave: () -> Void

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $diaryText)
                    .padding()
            }
            .navigationTitle(item == nil ? "New Diary Entry" : "Edit Diary Entry")
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
