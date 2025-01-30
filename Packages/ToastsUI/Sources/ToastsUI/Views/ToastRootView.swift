import SwiftUI

internal struct ToastRootView: View {
    // MARK: - Dependencies
    @ObservedObject var manager: ToastManager

    // MARK: - Private Properties
    private var models: IdentifiedArrayOf<ToastValue> {
        let models = isTop ? IdentifiedArrayOf(uniqueElements: manager.models.reversed()) : manager.models
        return manager.isAppeared ? models : []
    }

    private var isTop: Bool { manager.position == .top }

    // MARK: - Layout
    var body: some View {
        main
            .onAppear(perform: manager.onAppear)
    }

    @ViewBuilder
    private var main: some View {
        VStack {
            if !isTop { Spacer() }
            ZStack {
                ForEach(Array(models.reversed().enumerated()), id: \.element) { index, model in
                    ToastInteractingView(model: model, manager: manager)
                        .transition(
                            .modifier(
                                active: TransformModifier(
                                    yOffset: isTop ? -96 : 96,
                                    scale: 0.5,
                                    opacity: 0.0
                                ),
                                identity: TransformModifier(
                                    yOffset: 0,
                                    scale: 1.0,
                                    opacity: 1.0
                                )
                            )
                        )
                        .padding(
                            [isTop ? .top : .bottom],
                            // Place front element with bottom offset -32.
                            // Other elements stay on the same place
                            index != (models.indices.last ?? .zero) ? -(CGFloat(index) + 32) : .zero
                        )
                        .scaleEffect(index != (models.indices.last ?? .zero) ? CGSize(width: 0.8, height: 0.8) : CGSize(width: 1, height: 1))
                }
            }
            if isTop { Spacer() }
        }
        .animation(
            .spring(duration: removalAnimationDuration),
            value: Tuple(count: manager.models.count, isAppeared: manager.isAppeared)
        )
    }
}

private struct Tuple: Equatable {
    var count: Int
    var isAppeared: Bool
}
