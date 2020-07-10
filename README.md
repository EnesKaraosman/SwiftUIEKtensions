# SwiftUIEKtensions

Table of Contents

* [Extensions](#extensions)
* [Views](#views)
    - [Stateless Single Selection List](#stateless-single-selection-list)
    - [Stateful Single Selection List](#stateful-single-selection-list)
    - [Stateless Multiple Selection List](#stateless-multiple-selection-list)
    - [Stateful Multiple Selection List](#stateful-multiple-selection-list)
* [View Modifiers](#view-modifiers)

# Extensions

# Views

## Stateless Single Selection List

Selects 1 item at a time & binds it to selectedItem variable.
```swift
StatelessSingleSelectionList<Item: Identifiable, Content: View, Modifier: ViewModifier>(
    
    // Data source
    items: [Item],
    
    // To keep track of selected item
    selectedItem: Binding<Item?>,
    
    // Built in: CheckmarkModifier or create custom one
    modifier: @escaping () -> Modifier,
    
    // Your List row content
    rowContent: @escaping (Item) -> Content
)
```

Result is similar below;
```
=========================
= Item - 1              =
=========================
=========================
= Item - 2           ✅ =
=========================
=========================
= Item - 3              =
=========================
```

## Stateful Single Selection List

Selects 1 item at a time & mutates isSelected property of the  `SelectableItem`
```swift

protocol SelectableItem: Identifiable { 
    var isSelected: Bool { get set }
}

StatefulSingleSelectionList<Item: SelectableItem, Content: View, Modifier: ViewModifier>(
    
    // Data source
    items: [Item],
    
    // Built in: CheckmarkModifier or create custom one
    modifier: @escaping () -> Modifier,
    
    // Your List row content
    rowContent: @escaping (Item) -> Content
)
```

## Stateless Multiple Selection List

Allowed to select multiple items at a time & binds it to selectedItems variable.
```swift
StatelessMultipleSelectionList<Item: Identifiable, Content: View, Modifier: ViewModifier>(
    
    // Data source
    items: [Item],
    
    // To keep track of selected item
    selectedItems: Binding<[Item]>,
    
    // Built in: CheckmarkModifier or create custom one
    modifier: @escaping () -> Modifier,
    
    // Your List row content
    rowContent: @escaping (Item) -> Content
)
```

Result is similar below;
```
=========================
= Item - 1              =
=========================
=========================
= Item - 2           ✅ =
=========================
=========================
= Item - 3           ✅ =
=========================
```

## Stateful Multiple Selection List

Allowed to select multiple items & mutates isSelected property of the related  `SelectableItem`
```swift

protocol SelectableItem: Identifiable { 
    var isSelected: Bool { get set }
}

StatefulMultipleSelectionList<Item: SelectableItem, Content: View, Modifier: ViewModifier>(
    
    // Data source
    items: [Item],
    
    // Built in: CheckmarkModifier or create custom one
    modifier: @escaping () -> Modifier,
    
    // Your List row content
    rowContent: @escaping (Item) -> Content
)
```

# View Modifiers
