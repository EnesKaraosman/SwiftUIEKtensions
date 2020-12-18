# SwiftUIEKtensions

Table of Contents

* [Extensions](#extensions)
* [Views](#views)
    - [Image Picker](#image-picker)
    - [Mail Composer](#mail)
    - [Lazy View](#lazy-view)
    - [Stateless Single Selection List](#stateless-single-selection-list)
    - [Stateful Single Selection List](#stateful-single-selection-list)
    - [Stateless Multiple Selection List](#stateless-multiple-selection-list)
    - [Stateful Multiple Selection List](#stateful-multiple-selection-list)
    - [Device Orientation Based View](#device-orientation-based-view)
* [View Modifiers](#view-modifiers)

# Extensions

# Views

## Image Picker

Do not forget to add required privacy permissions.

```swift
struct ImagePickerExampleView: View {

    @State var showImagePicker: Bool = false
    @State var image: UIImage?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Button("Pick image") {
                self.showImagePicker.toggle()
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(sourceType: .photoLibrary) { image in
                self.image = image
            }
        }
    }
}
```

## Mail

```swift
import MessagesUI
import SwiftUI

@State private var result: Result<MFMailComposeResult, Error>? = nil
@State private var isShowingMailView = false

var body: some View {
    Form {
        Button(action: {
            if MFMailComposeViewController.canSendMail() {
                self.isShowingMailView.toggle()
            } else {
                print("Can't send emails from this device")
            }
            if result != nil {
                print("Result: \(String(describing: result))")
            }
        }) {
            HStack {
                Image(systemName: "envelope")
                Text("Contact Us")
            }
        }
        // .disabled(!MFMailComposeViewController.canSendMail())
    }
    .sheet(isPresented: $isShowingMailView) {
        MailView(result: $result) { composer in
            composer.setSubject("Secret")
            composer.setToRecipients(["eneskaraosman53@gmail.com"])
        }
    }
}
```

## Lazy View

```swift
NavigationView {
    NavigationLink(destination: LazyView(Text("My details page")) {
        Text("Go to details")
    }
}
```

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

## Device Orientation Based View

[DeviceOrientationBasedView](https://github.com/EnesKaraosman/SwiftUIEKtensions/blob/master/Sources/SwiftUIEKtensions/Views/DeviceOrientationBasedView.swift)

Make sure to pass `DeviceOrientationInfo` object as `EnvironmentObject` then you can use; <br>
```swift
DeviceOrientationBasedView(
    portrait: {
        // some `View`
    },
    landscape: {
        // some `View`
    }
)
```

# View Modifiers
