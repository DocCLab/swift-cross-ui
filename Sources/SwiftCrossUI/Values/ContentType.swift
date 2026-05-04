/// A content type corresponding to a specific file/data format.
public struct ContentType: Sendable {
    /// The HTML content type.
    public static let html = ContentType(
        name: "HTML",
        utType: "public.html",
        mimeTypes: ["text/html"],
        fileExtensions: ["html", "htm"]
    )

    /// The special file URL content type, used for file URLs being transferred
    /// via drag and drop or other means such as the clipboard.
    public static let fileURL = ContentType(
        name: "File URL",
        utType: "public.file-url",
        mimeTypes: [],
        fileExtensions: []
    )

    /// The data content type, representing any generic byte stream or bytes container.
    public static let data = ContentType(
        name: "Data",
        utType: "public.data",
        mimeTypes: [],
        fileExtensions: []
    )

    /// The name of this content type.
    public var name: String
    /// The Apple Uniform Type Identifier associated with this content type.
    public var utType: String
    /// An array of MIME types associated with this content type.
    public var mimeTypes: [String]
    /// An array of file extensions associated with this content type.
    public var fileExtensions: [String]

    /// Creates an instance of `ContentType`.
    ///
    /// - Parameters:
    ///   - name: The name of this content type.
    ///   - mimeTypes: An array of MIME types associated with this content type.
    ///   - fileExtensions: An array of file extensions associated with this
    ///     content type.
    public init(
        name: String,
        utType: String,
        mimeTypes: [String],
        fileExtensions: [String]
    ) {
        self.name = name
        self.utType = utType
        self.mimeTypes = mimeTypes
        self.fileExtensions = fileExtensions
    }
}
