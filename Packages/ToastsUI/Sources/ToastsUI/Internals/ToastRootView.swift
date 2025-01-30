import SwiftUI

internal struct ToastRootView: View {
    // MARK: - Dependencies
    @ObservedObject var manager: ToastManager

    // MARK: - Private Properties
    private var models: [ToastModel] {
        let models = isTop ? manager.models.reversed() : manager.models
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
        VStack(spacing: 8) {
            if !isTop { Spacer() }
            ForEach(models) { model in
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
