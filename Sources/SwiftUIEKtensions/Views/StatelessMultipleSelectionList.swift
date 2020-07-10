//
//  StatelessMultipleSelectionList.swift
//  
//
//  Created by Enes Karaosman on 10.07.2020.
//

import SwiftUI

/**
 Usage;
 
 StatelessMultipleSelectionList(
     items: mock,
     selectedItems: $selectedItems,
     modifier: { CheckmarkModifier() }
 ) { (item) in
     HStack {
         Text(item.name)
         Spacer()
     }
 }
 */
public struct StatelessMultipleSelectionList<Item: Identifiable, Content: View, Modifier: ViewModifier>: View {
    
    var items: [Item]
    @Binding var selectedItems: [Item]
    var modifier: () -> Modifier
    var rowContent: (Item) -> Content
    
    public init(
        items: [Item],
        selectedItems: Binding<[Item]>,
        modifier: @escaping () -> Modifier,
        rowContent: @escaping (Item) -> Content
    ) {
        self.items = items
        self._selectedItems = selectedItems
        self.modifier = modifier
        self.rowContent = rowContent
    }
    
    public var body: some View {
        List(items) { item in
            self.rowContent(item)
            .applyModifierOnConditionOrReturnSelf(
                on: self.selectedItems.contains(where: { $0.id == item.id }),
                trueCase: self.modifier()
            )
            .contentShape(Rectangle())
            .onTapGesture {
                if let idx = self.selectedItems.firstIndex(where: { $0.id == item.id }) {
                    // Already selected, so remove
                    self.selectedItems.remove(at: idx)
                } else {
                    self.selectedItems.append(item)
                }
            }
        }
    }
}
