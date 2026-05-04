extension View {
    public func dropDestination(
        for type: ContentType,
        isEnabled: Bool = true,
        action: @escaping ([TransferrableData], DropSession) -> Void
    ) -> some View {
        DropDestinationModifier(
            body: TupleView1(self),
            isEnabled: isEnabled,
            action: action
        )
    }
}

struct DropDestinationModifier<Content: View>: TypeSafeView {
    typealias Children = TupleView1<Content>.Children

    var body: TupleView1<Content>
    var isEnabled: Bool
    var action: ([TransferrableData], DropSession) -> Void

    func children<Backend: BaseAppBackend>(
        backend: Backend,
        snapshots: [ViewGraphSnapshotter.NodeSnapshot]?,
        environment: EnvironmentValues
    ) -> Children {
        body.children(
            backend: backend,
            snapshots: snapshots,
            environment: environment
        )
    }

    @CastBackend<BackendFeatures.DragAndDrop>(returnsWidget: true)
    func asWidget<Backend: BaseAppBackend>(
        _ children: Children,
        backend: Backend
    ) -> Backend.Widget {
        backend.createDropDestination(wrapping: children.child0.widget.into())
    }

    func computeLayout<Backend: BaseAppBackend>(
        _ widget: Backend.Widget,
        children: Children,
        proposedSize: ProposedViewSize,
        environment: EnvironmentValues,
        backend: Backend
    ) -> ViewLayoutResult {
        children.child0.computeLayout(
            with: body.view0,
            proposedSize: proposedSize,
            environment: environment
        )
    }

    @CastBackend<BackendFeatures.DragAndDrop>
    func commit<Backend: BaseAppBackend>(
        _ widget: Backend.Widget,
        children: TupleView1<Content>.Children,
        layout: ViewLayoutResult,
        environment: EnvironmentValues,
        backend: Backend
    ) {
        let size = children.child0.commit().size
        backend.setSize(of: widget, to: size.vector)
        backend.updateDropDestination(
            widget,
            isEnabled: isEnabled,
            action: { items in
                action(items, DropSession())
            }
        )
    }
}
