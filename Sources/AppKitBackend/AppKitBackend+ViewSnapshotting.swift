import Foundation
import AppKit

// This is not a standard backend feature yet; we only use it internally
// within the backend to generate drag and drop previews.
extension AppKitBackend {
    static func snapshotView(_ view: NSView) throws -> NSImage {
        guard let bitmap = view.bitmapImageRepForCachingDisplay(in: view.bounds) else {
            throw SnapshottingError(message: "Failed to create bitmap backing")
        }

        view.cacheDisplay(in: view.bounds, to: bitmap)

        guard let cgImage = bitmap.cgImage else {
            throw SnapshottingError(message: "Failed to convert snapshot to CGImage")
        }

        return NSImage(cgImage: cgImage, size: bitmap.size)
    }

    struct SnapshottingError: LocalizedError {
        var message: String
        var errorDescription: String? { message }
    }
}
