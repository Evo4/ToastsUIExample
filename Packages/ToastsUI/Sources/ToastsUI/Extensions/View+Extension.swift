import SwiftUI

extension View {
    @ViewBuilder
    internal func _onChange<V: Equatable>(
        of value: V,
        initial: Bool = false,
        _ action: @escaping (_ oldValue: V, _ newValue: V) -> Void
    ) -> some View {
        if #available(iOS 17.0, *) {
            self.onChange(of: value, initial: initial, action)
        } else {
            self
                .onAppear {
                    if initial { action(value, value) }
                }
                .onChange(of: value) { [oldValue = value] newValue in
                    action(oldValue, newValue)
                }
        }
    }
}
