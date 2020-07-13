//
//  SingleSelectionList.swift
//  
//
//  Created by Enes Karaosman on 9.07.2020.
//

import SwiftUI

/**
 Usage;
 
 StatelessSingleSelectionList(
     items: mock,
     selectedItem: $selectedItem,
     modifier: { CheckmarkModifier() }
 ) { (item) in
     HStack {
         Text(item.name)
         Spacer()
     }
 }
 */
public struct StatelessSingleSelectionList<Item: Identifiable, Content: View, Modifier: ViewModifier>: View {
    
    var items: [Item]
    @Binding var selectedItem: Item?
    var modifier: () -> Modifier
    var rowContent: (Item) -> Content
    
    /// Makes single row selection available at a time in a `List` & binds it to `selectedItem` variable.
    /// - Parameters:
    ///   - items: Data source of `List`, `Item`s implements `Identifiable` protocol to be followed.
    ///   - selectedItem: Selected `Item`s is binded to this variable.
    ///   - modifier: Modifier to apply when the related item is selected.
    ///   - rowContent: To represent how row is displayed.
    public init(
        items: [Item],
        selectedItem: Binding<Item?>,
        modifier: @escaping () -> Modifier,
        rowContent: @escaping (Item) -> Content
    ) {
        self.items = items
        self._selectedItem = selectedItem
        self.modifier = modifier
        self.rowContent = rowContent
    }
    
    public var body: some View {
        List(items) { item in
            self.rowContent(item)
            .applyModifierOnConditionOrReturnSelf(on: item.id == self.selectedItem?.id, trueCase: self.modifier())
            .contentShape(Rectangle())
            .onTapGesture {
                self.selectedItem = item
            }
        }
    }
}
