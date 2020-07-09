//
//  SingleSelectionList.swift
//  
//
//  Created by Enes Karaosman on 9.07.2020.
//

import SwiftUI

/**
 Usage;
 
 SingleSelectionList(
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
public struct SingleSelectionList<Item: Identifiable, Content: View, Modifier: ViewModifier>: View {
    
    var items: [Item]
    @Binding var selectedItem: Item?
    var modifier: () -> Modifier
    var rowContent: (Item) -> Content
    
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
