# SwiftUIEKtensions

Table of Contents

- [Single Selection List](#single-selection-list)

## Single Selection List

Selects 1 item at a time & binds it to selectedItem variable.
```swift
SingleSelectionList<Item: Identifiable, Content: View>(
    items: [Item], 
    selectedItem: Binding<Item?>, 
    rowContent: (Item) -> Content 
)
```
