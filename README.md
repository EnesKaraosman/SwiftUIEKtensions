# SwiftUIEKtensions

Table of Contents

* [Extensions](#extensions)
* [Views](#views)
    - [Single Selection List](#single-selection-list)
* [View Modifiers](#view-modifiers)

# Extensions

# Views
## Single Selection List

Selects 1 item at a time & binds it to selectedItem variable.
```swift
SingleSelectionList<Item: Identifiable, Content: View, Modifier: ViewModifier>(
    
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

# View Modifiers
