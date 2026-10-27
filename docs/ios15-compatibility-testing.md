# Testing iOS 15 fallback behavior

In Xcode, choose Product → Scheme → Edit Scheme → Run → Arguments.
Check the existing `-ForceIOS15Compatibility` entry under Arguments Passed On Launch.
Use the Debug build configuration, stop the app, and run it again on any supported simulator or device.
The console prints `[Compatibility] iOS 15 fallback paths enabled; using a separate debug cart.`

This forces legacy navigation, sheet presentation, scroll/background behavior,
notification badge clearing, and the Codable cart backend. It does not change the
operating system or emulate iOS 15's SwiftUI implementation. Actual iOS 15 runtime
validation is still required.

Check navigation through several screens, Back and swipe-back, opening/dismissing
sheets, forms and keyboards, and adding/updating/removing cart items. Stop and run
again with the argument enabled to verify cart persistence.

The forced-mode cart is stored separately from the normal cart and persists between
forced-mode launches. Disabling the flag does not import its items into SwiftData.
This mode therefore does not test the real legacy-to-SwiftData migration.
Only cart storage is isolated; account actions and network requests still use the
app's configured services.

To return to normal behavior, uncheck the argument, stop, and rerun. Release builds
ignore the argument even when supplied.

Run `zsh Tests/run-cart-storage-tests.sh` for legacy cart persistence, update,
deletion, corrupt-data handling, and separate-storage regression checks.
