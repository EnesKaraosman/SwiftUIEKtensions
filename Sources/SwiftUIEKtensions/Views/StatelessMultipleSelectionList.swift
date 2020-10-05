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
    
    
    /// Makes multiple row selection available in a `List` & binds it to `selectedItems` variable.
    /// - Parameters:
    ///   - items: Data source of `List`, `Item`s implements `Identifiable` protocol to be followed.
    ///   - selectedItems: Selected `Item`s is binded to this variable.
    ///   - modifier: Modifier to apply when the related item is selected.
    ///   - rowContent: To represent how row is displayed.
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
            rowContent(item)
            .applyModifierOnConditionOrReturnSelf(
                on: selectedItems.contains(where: { $0.id == item.id }),
                trueCase: modifier()
            )
            .contentShape(Rectangle())
            .onTapGesture {
                if let idx = selectedItems.firstIndex(where: { $0.id == item.id }) {
                    // Already selected, so remove
                    selectedItems.remove(at: idx)
                } else {
                    selectedItems.append(item)
                }
            }
        }
    }
}
