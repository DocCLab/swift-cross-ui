extension View {
    public func draggable(
        _ payload: @autoclosure @escaping () -> TransferrableData
    ) -> some View {
        DraggableModifier(body: TupleView1(self), payload: payload)
    }
}

struct DraggableModifier<Content: View>: TypeSafeView {
    typealias Children = TupleView1<Content>.Children

    var body: TupleView1<Content>
    var payload: () -> TransferrableData

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
        backend.createDragSource(wrapping: children.child0.widget.into())
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
        backend.updateDragSource(
            widget,
            prepareData: payload
        )
    }
}
