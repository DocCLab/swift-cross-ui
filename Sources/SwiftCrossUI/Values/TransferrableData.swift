import Foundation

public struct TransferrableData {
    public var data: Data
    public var contentType: ContentType

    public init(data: Data, contentType: ContentType?) {
        self.data = data
        self.contentType = contentType ?? .data
    }

    public init(url: URL) {
        data = Data(url.absoluteString.utf8)
        contentType = .fileURL
    }
}
