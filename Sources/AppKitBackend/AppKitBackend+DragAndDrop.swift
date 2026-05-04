import AppKit
import Foundation
import SwiftCrossUI

extension AppKitBackend {
    public func createDragSource(wrapping child: Widget) -> Widget {
        let container = NSDraggableContainer()
        container.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        child.leadingAnchor.constraint(equalTo: container.leadingAnchor)
            .isActive = true
        child.topAnchor.constraint(equalTo: container.topAnchor)
            .isActive = true

        return container
    }

    public func updateDragSource(
        _ dragSource: Widget,
        prepareData: @escaping () -> TransferrableData
    ) {
        let container = dragSource as! NSDraggableContainer
        container.prepareData = prepareData
    }

    public func createDropDestination(wrapping child: Widget) -> Widget {
        let container = NSDropDestinationContainer()
        container.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        child.leadingAnchor.constraint(equalTo: container.leadingAnchor)
            .isActive = true
        child.topAnchor.constraint(equalTo: container.topAnchor)
            .isActive = true

        container.registerForDraggedTypes([.fileURL])
        return container
    }

    public func updateDropDestination(
        _ dropDestination: Widget,
        isEnabled: Bool,
        action: @escaping ([TransferrableData]) -> Void
    ) {
        let container = dropDestination as! NSDropDestinationContainer
        container.isEnabled = isEnabled
        container.action = action
    }
}

class NSDropDestinationContainer: NSView {
    var isEnabled = false
    var action: (([TransferrableData]) -> Void)?

    override func wantsPeriodicDraggingUpdates() -> Bool {
        false
    }

    override func draggingEntered(_ sender: any NSDraggingInfo) -> NSDragOperation {
        return .copy
    }

    override func prepareForDragOperation(_ sender: any NSDraggingInfo) -> Bool {
        isEnabled && action != nil
    }

    override func performDragOperation(_ sender: any NSDraggingInfo) -> Bool {
        guard let action else {
            logger.warning("Received drop without handler")
            return false
        }

        let pasteboard = sender.draggingPasteboard
        var urls: [URL] = []
        for item in pasteboard.pasteboardItems ?? [] {
            guard let urlData = item.data(forType: .fileURL) else {
                logger.warning("Skipping non-file URL drop")
                continue
            }

            guard
                let urlString = String(data: urlData, encoding: .utf8),
                let url = URL(string: urlString)
            else {
                logger.warning("Invalid file URL")
                continue
            }

            urls.append(url)
        }

        action(urls.map(TransferrableData.init(url:)))
        return true
    }
}

class NSDraggableContainer: NSView, NSPasteboardItemDataProvider, NSDraggingSource {
    var prepareData: (() -> TransferrableData)?
    var data: TransferrableData?

    override func mouseDown(with event: NSEvent) {
        let pasteboardItem = NSPasteboardItem()

        guard let prepareData else {
            logger.debug("No payload present when drag began")
            return
        }

        let data = prepareData()
        self.data = data
        let type = Self.pasteboardType(for: data)
        pasteboardItem.setDataProvider(
            self,
            forTypes: [type]
        )

        let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
        do {
            let preview = try AppKitBackend.snapshotView(self)
            draggingItem.setDraggingFrame(self.bounds, contents: preview)
        } catch {
            logger.warning(
                "Failed to render drag and drop preview: \(error.localizedDescription)"
            )
        }

        beginDraggingSession(with: [draggingItem], event: event, source: self)
    }

    nonisolated func draggingSession(
        _ session: NSDraggingSession,
        sourceOperationMaskFor context: NSDraggingContext
    ) -> NSDragOperation {
        [.copy]
    }

    nonisolated func pasteboard(
        _ pasteboard: NSPasteboard?,
        item: NSPasteboardItem,
        provideDataForType type: NSPasteboard.PasteboardType
    ) {
        guard let data else {
            return
        }

        let type = Self.pasteboardType(for: data)
        item.setData(
            data.data,
            forType: type
        )
    }

    static func pasteboardType(
        for data: TransferrableData
    ) -> NSPasteboard.PasteboardType {
        let identifier = data.contentType.utType
        // let identifier = UTTypeCreatePreferredIdentifierForTag(
        //     kUTTagClassMIMEType,
        //     contentType as CFString,
        //     nil
        // )?.takeRetainedValue() as String?

        return NSPasteboard.PasteboardType(identifier)
    }
}
