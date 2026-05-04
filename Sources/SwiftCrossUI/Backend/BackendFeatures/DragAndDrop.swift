extension BackendFeatures {
    /// Backend methods related to drag-and-drop functionality.
    @MainActor
    public protocol DragAndDrop: Core {
        func createDragSource(wrapping child: Widget) -> Widget

        func updateDragSource(
            _ dragSource: Widget,
            prepareData: @escaping () -> TransferrableData
        )

        func createDropDestination(wrapping child: Widget) -> Widget

        func updateDropDestination(
            _ dropDestination: Widget,
            isEnabled: Bool,
            action: @escaping ([TransferrableData]) -> Void
        )
    }
}
