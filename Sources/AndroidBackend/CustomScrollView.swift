import SwiftJava
import AndroidKit

@JavaClass(
    "dev.swiftcrossui.androidbackend.CustomScrollView",
    extends: AndroidKit.ScrollView.self
)
class CustomScrollView: JavaObject {
    @JavaMethod
    @_nonoverride convenience init(
        _ activity: Activity?,
        child: View?,
        environment: JNIEnvironment? = nil
    )
}
