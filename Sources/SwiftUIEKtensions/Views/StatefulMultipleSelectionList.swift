//
//  StatefulMultipleSelectionList.swift
//  
//
//  Created by Enes Karaosman on 10.07.2020.
//

import SwiftUI

/**
 Usage;
 
 StatefulMultipleSelectionList(
     items: $selectedItems, Changes isSelected state of selected item.
     modifier: { CheckmarkModifier() }
 ) { (item) in
     HStack {
         Text(item.name)
         Spacer()
     }
 }
 */
public struct StatefulMultipleSelectionList<Item: SelectableItem, Content: View, Modifier: ViewModifier>: View {
    
    @Binding var items: [Item]
    var modifier: () -> Modifier
    var rowContent: (Item) -> Content
    
    /// Makes multiple row selection available in a `List`
    /// - Parameters:
    ///   - items: Data source of `List`, `Item`s implements `SelectableItem` protocol.
    ///   - modifier: Modifier to apply when the related item is selected.
    ///   - rowContent: To represent how row is displayed.
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
                if let idx = self.items.firstIndex(where: { $0.id == item.id }) {
                    self.items[idx].isSelected.toggle()
                }
            }
        }
    }
}
