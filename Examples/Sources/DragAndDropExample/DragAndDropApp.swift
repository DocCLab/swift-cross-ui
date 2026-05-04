import DefaultBackend
import Foundation
import SwiftCrossUI
import ImageFormats

#if canImport(SwiftBundlerRuntime)
    import SwiftBundlerRuntime
#endif

extension AppStorageValues {
    @Entry var images: [URL] = []
}

@main
@HotReloadable
struct DragAndDropApp: App {
    @Environment(\.chooseFile) var chooseFile

    @AppStorage(\.images) var images

    var body: some Scene {
        WindowGroup("Drag and Drop") {
            #hotReloadable {
                VStack {
                    Color.gray
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay {
                            Text("Drop image files here")
                                .foregroundColor(.black)
                        }
                        .dropDestination(for: .fileURL) { items, _ in
                            for item in items {
                                guard
                                    let urlString = String(data: item.data, encoding: .utf8),
                                    let url = URL(string: urlString)
                                else {
                                    continue
                                }
                                images.append(url)
                            }
                        }

                    GeometryReader { proxy in
                        ScrollView([.horizontal]) {
                            HStack {
                                ForEach(Array(images.enumerated().reversed()), id: \.offset) { _, image in
                                    Image(image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .draggable(TransferrableData(url: image))
                                }

                                if images.isEmpty {
                                    Text("No images").italic()
                                        .frame(minWidth: proxy.size.width)
                                }
                            }
                        }.frame(height: proxy.size.height)
                    }.frame(height: 100)
                        .overlay(alignment: .topTrailing) {
                            if !images.isEmpty {
                                Button("Clear all") {
                                    images = []
                                }
                            }
                        }
                }.padding()
            }
        }
    }
}
