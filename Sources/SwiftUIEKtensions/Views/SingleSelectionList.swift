//
//  SingleSelectionList.swift
//  
//
//  Created by Enes Karaosman on 9.07.2020.
//

import SwiftUI

public struct SingleSelectionList<Item: Identifiable, Content: View>: View {
    
    var items: [Item]
    @Binding var selectedItem: Item?
    var rowContent: (Item) -> Content
    
    public init(items: [Item], selectedItem: Binding<Item?>, rowContent: @escaping (Item) -> Content) {
        self.items = items
        self._selectedItem = selectedItem
        self.rowContent = rowContent
    }
    
    public var body: some View {
        List(items) { item in
            rowContent(item)
                .modifier(CheckmarkModifier(checked: item.id == self.selectedItem?.id))
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedItem = item
                }
        }
    }
}
