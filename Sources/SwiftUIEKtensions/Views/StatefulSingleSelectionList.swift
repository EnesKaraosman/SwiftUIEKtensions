//
//  StatefulSingleSelectionList.swift
//  
//
//  Created by Enes Karaosman on 10.07.2020.
//

import SwiftUI

/**
 Usage;
 
 StatefulSingleSelectionList(
     items: $selectedItems, Changes isSelected state of selected item.
     modifier: { CheckmarkModifier() }
 ) { (item) in
     HStack {
         Text(item.name)
         Spacer()
     }
 }
 */
public struct StatefulSingleSelectionList<Item: SelectableItem, Content: View, Modifier: ViewModifier>: View {
    
    @Binding var items: [Item]
    var modifier: () -> Modifier
    var rowContent: (Item) -> Content
    
    public init(
        items: Binding<[Item]>,
        modifier: @escaping () -> Modifier,
        rowContent: @escaping (Item) -> Content
    ) {
        self._items = items
        self.modifier = modifier
        self.rowContent = rowContent
    }
    
    public var body: some View {
        List(items) { item in
            self.rowContent(item)
            .applyModifierOnConditionOrReturnSelf(
                on: item.isSelected,
                trueCase: self.modifier()
            )
            .contentShape(Rectangle())
            .onTapGesture {
                for (idx, element) in self.items.enumerated() {
                    self.items[idx].isSelected = false
                }
                if let idx = self.items.firstIndex(where: { $0.id == item.id }) {
                    self.items[idx].isSelected = true
                }
            }
        }
    }
}
