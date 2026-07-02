import SwiftCrossUI
import UWP
import WinUI
import WindowsFoundation
import CWinRT
import WinSDK

// swiftlint:disable force_try

typealias IReference_Thickness = __x_ABI_C__FIReference_1___x_ABI_CWindows__CUI__CXaml__CThickness
typealias IReference_Thickness_VTable =
    __x_ABI_C__FIReference_1___x_ABI_CWindows__CUI__CXaml__CThicknessVtbl

extension WindowsFoundation.IID {
    init(from string: String) throws {
        var iid = Self.zero
        try string.withCString(encodedAs: UTF16.self) { cstring in
            try withUnsafeMutablePointer(to: &iid) { pointer in
                try pointer.withMemoryRebound(to: _GUID.self, capacity: 1) { iidPointer in
                    try CHECKED(IIDFromString(cstring, iidPointer))
                }
            }
        }
        self = iid
    }

    static let zero = Self(Data1: 0, Data2: 0, Data3: 0, Data4: (0, 0, 0, 0, 0, 0, 0, 0))
}

// class ThicknessWrapper: WinRTWrapperBase<IReference_Thickness, Thickness>, IWinRTObject {
//     public init(_ thickness: Thickness) {
//         let vtblPtr = withUnsafeMutablePointer(to: &Self.vtable) { $0 }
//         let cAbi = IReference_Thickness(lpVtbl: vtblPtr)
//         super.init(cAbi, thickness)
//     }

//     var thisPtr: WindowsFoundation.IInspectable {
        
//     }

//     public static func unwrapFrom(abi: ComPtr<IReference_Thickness>?) -> Thickness? {
//         guard let abi = abi else { return nil }
//         return tryUnwrapFrom(abi: abi)
//     }

//     public static func tryUnwrapFrom(raw pUnk: UnsafeMutableRawPointer?) -> Thickness? {
//         tryUnwrapFromBase(raw: pUnk)
//     }

//     public static func tryUnwrapFromBase(raw pUnk: UnsafeMutableRawPointer?) -> Thickness? {
//         guard let pUnk = pUnk else { return nil }
//         return fromRaw(pUnk)?.takeUnretainedValue().swiftObj
//     }

//     private static func computeInterfaceIID() -> _GUID {
//         // var partsCount: DWORD = 0
//         // var parts: UnsafeMutablePointer<HString>? = nil
//         // try! CHECKED(
//         //     RoParseTypeName(try! HString("IReference`1<Thickness>"), &partsCount, &parts)
//         // )

//         // var locator = IRoMetaDataLocator(
//         //     Locate: { nameElement, destination in
//         //         let name = String(cString: nameElement.pointee, encoding: .utf16)!
//         //         print("Locating metadata for name '\(name)'")
//         //         if name == "IReference`1" {
//         //             let iid = try! IID(from: "61c17706-2d65-11e0-9ae8-d48564015472")
//         //             return destination.SetParameterizedInterface(iid, 1)
//         //         } else if name == "Thickness" {
//         //             return "Float64".withCString(encoding: UTF16.self) {
//         //                 let fieldTypes = [$0, $0, $0, $0]
//         //                 return destination.SetStruct(
//         //                     "Microsoft.UI.Xaml.Thickness",
//         //                     4,
//         //                     fieldTypes
//         //                 )
//         //             }
//         //         } else {
//         //             print("Failed to locate metadata for name '\(name)'")
//         //         }
//         //     }
//         // )

//         // var out = iid
//         // RoGetParameterizedTypeInstanceIID(
//         //     partsCount,
//         //     parts,
//         //     &locator
//         //     &out,
//         //     nil
//         // )

//         // return out
//         return _GUID.zero
//     }

//     internal static var vtable = IReference_Thickness_VTable(
//         QueryInterface: {
//             print("Queryhing interface")
//             guard let pUnk = $0, let riid = $1, let ppvObject = $2 else { return E_INVALIDARG }
//             if riid.pointee == IUnknown.IID ||
//                 riid.pointee == IInspectable.IID ||
//                 riid.pointee == ISwiftImplemented.IID ||
//                 riid.pointee == IAgileObject.IID
//                 /* TODO: Compute IID for IReference<Thickness> */
//             {
//                 print("Returning interface for IID \(riid.pointee)")
//                 _ = pUnk.pointee.lpVtbl.pointee.AddRef(pUnk)
//                 ppvObject.pointee = UnsafeMutableRawPointer(pUnk)
//                 return S_OK
//             }

//             print("Missing interface \(riid.pointee)")

//             ppvObject.pointee = nil
//             return E_NOINTERFACE
//         },
//         AddRef: { ThicknessWrapper.addRef($0) },
//         Release: { ThicknessWrapper.release($0) },
//         GetIids: {
//             print("Get IIDs called")

//             let iids = [
//                 IUnknown.IID,
//                 IInspectable.IID,
//                 /* TODO: Compute IID for IReference<Thickness> */
//             ]

//             let size = MemoryLayout<WindowsFoundation.IID>.size
//             let iidMem = CoTaskMemAlloc(UInt64(size * iids.count))
//                 .assumingMemoryBound(to: WindowsFoundation.IID.self)
//             for (index, iid) in iids.enumerated() {
//                 iidMem[index] = iid
//             }

//             $1!.pointee = ULONG(iids.count)
//             $2!.pointee = iidMem
//             return S_OK
//         },
//         GetRuntimeClassName: {
//             print("GetRuntimeClassName called")
//             _ = $0
//             $1!.pointee = try! HString("ThicknessWrapper").detach()
//             return S_OK
//         },
//         GetTrustLevel: {
//             print("GetTrustLevel called")
//             _ = $0
//             $1!.pointee = TrustLevel(rawValue: 0)
//             return S_OK
//         },
//         get_Value: {
//             print("Got value")
//             _ = $0
//             $1!.pointee = __x_ABI_CWindows_CUI_CXaml_CThickness(Left: 0, Top: 0, Right: 0, Bottom: 0)
//             return S_OK
//         }
//     )
// }

final class ThicknessWrapper: IWinRTObject {
    typealias CInterface = IReference_Thickness

    struct ABI {
        var vtbl: CInterface
        var thickness: Thickness
        var wrapper: Unmanaged<ThicknessWrapper>?
    }

    var abi: ABI

    var thisPtr: WindowsFoundation.IInspectable {
        withUnsafeMutablePointer(to: &abi) { pointer in
            WindowsFoundation.IInspectable(ComPtr(pointer))
        }
    }

    deinit {
        print("ThicknessWrapper deinit")
    }

    init(_ thickness: Thickness) {
        let vtblPtr = withUnsafeMutablePointer(to: &Self.vtable) { $0 }
        let cAbi = IReference_Thickness(lpVtbl: vtblPtr)
        abi = ABI(
            vtbl: cAbi,
            thickness: thickness,
            wrapper: nil
        )
        abi.wrapper = Unmanaged<ThicknessWrapper>.passUnretained(self)
    }

    static func fromIUnknown(
        _ pUnk: UnsafeMutableRawPointer?
    ) -> Unmanaged<ThicknessWrapper>? {
        guard let pUnk = pUnk else { return nil }

        return pUnk
            .assumingMemoryBound(to: ThicknessWrapper.ABI.self)
            .pointee.wrapper
    }

    static func addRef(_ pUnk: UnsafeMutablePointer<CInterface>?) -> ULONG {
        print("Add ref")

        guard let unmanaged = fromIUnknown(pUnk) else { return 1 }

        let wrapper = unmanaged.takeUnretainedValue()
        _ = unmanaged.retain()
        print("Retain count:", _getRetainCount(wrapper))
        return ULONG(_getRetainCount(wrapper))
    }

    static func release(_ pUnk: UnsafeMutablePointer<CInterface>?) -> ULONG {
        print("Release")

        guard let unmanaged = fromIUnknown(pUnk) else { return 1 }

        let wrapper = unmanaged.takeUnretainedValue()
        unmanaged.release()
        print("Retain count:", _getRetainCount(wrapper))
        return ULONG(_getRetainCount(wrapper))
    }

    private static func computeIID() -> WindowsFoundation.IID {
        // Querying interface
        // Missing interface {E7BEAEE7-160E-50F7-8789-D63463F979FA}
        // Querying interface
        // Missing interface {E7BEAEE7-160E-50F7-8789-D63463F979FA}
        // Querying interface
        // Missing interface {02DD3AD0-B9DE-4B55-A0C3-507235EAE8EA}
        // Querying interface
        // Missing interface {64BD43F8-BFEE-4EC4-B7EB-2935158DAE21}
        // Add ref
        // Querying interface
        // Missing interface {0C881986-86E1-40B3-9642-9E5090A8A6B0}
        // Querying interface
        // Returning interface for IID {4BD682DD-7554-40E9-9A9B-82654EDE7E62}

        try! WindowsFoundation.IID(from: "{62390189-15EC-5FD5-86D5-0D5321FEB589}")

        // try! WindowsFoundation.IID(from: "{0C881986-86E1-40B3-9642-9E5090A8A6B0}")
    }

    private static var vtable = IReference_Thickness_VTable(
        QueryInterface: {
            print("Querying interface")
            guard let pUnk = $0, let riid = $1, let ppvObject = $2 else { return E_INVALIDARG }
            if riid.pointee == IUnknown.IID ||
                riid.pointee == IInspectable.IID ||
                riid.pointee == ISwiftImplemented.IID ||
                riid.pointee == IAgileObject.IID ||
                riid.pointee == __ABI_Windows_Foundation.IPropertyValue.IID ||
                riid.pointee == computeIID()
            {
                print("Returning interface for IID \(riid.pointee)")
                _ = pUnk.pointee.lpVtbl.pointee.AddRef(pUnk)
                ppvObject.pointee = UnsafeMutableRawPointer(pUnk)
                return S_OK
            }

            print("Missing interface \(riid.pointee)")

            ppvObject.pointee = nil
            return E_NOINTERFACE
        },
        AddRef: { ThicknessWrapper.addRef($0) },
        Release: { ThicknessWrapper.release($0) },
        GetIids: {
            print("Get IIDs called")

            let iids = [
                IUnknown.IID,
                IInspectable.IID,
                __ABI_Windows_Foundation.IPropertyValue.IID,
                computeIID()
            ]

            let size = MemoryLayout<WindowsFoundation.IID>.size
            let iidMem = CoTaskMemAlloc(UInt64(size * iids.count))
                .assumingMemoryBound(to: WindowsFoundation.IID.self)
            for (index, iid) in iids.enumerated() {
                iidMem[index] = iid
            }

            $1!.pointee = ULONG(iids.count)
            $2!.pointee = iidMem
            return S_OK
        },
        GetRuntimeClassName: {
            print("GetRuntimeClassName called")
            _ = $0
            $1!.pointee = try! HString("ThicknessWrapper").detach()
            return S_OK
        },
        GetTrustLevel: {
            print("GetTrustLevel called")
            _ = $0
            $1!.pointee = TrustLevel(rawValue: 0)
            return S_OK
        },
        get_Value: {
            print("Got value")
            _ = $0
            $1!.pointee = __x_ABI_CWindows_CUI_CXaml_CThickness(Left: 0, Top: 0, Right: 0, Bottom: 0)
            return S_OK
        }
    )
}

extension WinUIBackend: BackendFeatures.Sheets {
    public class Sheet: ContentDialog {
        var dismissHandler: (() -> Void)?
    }

    public func createSheet(content: Widget) -> Sheet {
        let sheet = Sheet()
        sheet.content = content

        // When all buttons are unlabelled, WinUI hides the actions section of
        // the dialog automatically.
        sheet.primaryButtonText = ""
        sheet.secondaryButtonText = ""
        sheet.closeButtonText = ""

        // Sometimes the sheet will have its own default escape key handling,
        // and sometimes it won't. This accelerator is for the cases where it
        // doesn't. It's not exactly clear what determines whether this
        // accelerator is required, but from some testing it seems that sheets
        // without interactive content don't have escape key handling by default
        // (e.g. sheets with only text).
        let accelerator = WinUI.KeyboardAccelerator()
        accelerator.key = .escape
        accelerator.invoked.addHandler { [weak sheet] _, _ in
            guard let sheet else { return }
            try! sheet.hide()
            sheet.dismissHandler?()
        }
        sheet.keyboardAccelerators.append(accelerator)
        sheet.keyboardAcceleratorPlacementMode = .hidden

        // The top portion of a ContentDialog (the dialog portion) is an
        // overlay with its own background color. We hide the action portion
        // of the dialog to use it as a sheet, so we remove the overlay
        // background and simply use the dialog's background property to
        // control the background color of the sheet.
        _ = sheet.resources.insert("ContentDialogTopOverlay", nil)
        _ = sheet.resources.insert("ContentDialogSeparatorBorderBrush", nil)
        _ = sheet.resources.insert("ContentDialogMaxWidth", 1000000 as Double)
        _ = sheet.resources.insert("ContentDialogMinWidth", 0 as Double)
        _ = sheet.resources.insert("ContentDialogMaxHeight", 1000000 as Double)
        _ = sheet.resources.insert("ContentDialogMinHeight", 0 as Double)
        _ = sheet.resources.insert(
            "ContentDialogPadding",
            ThicknessWrapper(Thickness(left: 0, top: 0, right: 0, bottom: 0))
        )

        return sheet
    }

    public func updateSheet(
        _ sheet: Sheet,
        window: Window,
        environment: EnvironmentValues,
        size: SIMD2<Int>,
        onDismiss: @escaping () -> Void,
        cornerRadius: Double?,
        detents _: [PresentationDetent],
        dragIndicatorVisibility _: SwiftCrossUI.Visibility,
        backgroundColor: SwiftCrossUI.Color.Resolved?,
        interactiveDismissDisabled: Bool
    ) {
        sheet.width = Double(size.x)
        sheet.height = Double(size.y)
        sheet.dismissHandler = onDismiss

        if let backgroundColor {
            sheet.background = WinUI.SolidColorBrush(backgroundColor.uwpColor)
        } else {
            try! sheet.clearValue(Sheet.backgroundProperty)
        }

        sheet.requestedTheme = switch environment.colorScheme {
            case .light: .light
            case .dark: .dark
        }
    }

    public func presentSheet(
        _ sheet: Sheet,
        window: Window,
        parentSheet: Sheet?
    ) {
        sheet.xamlRoot = window.content.xamlRoot
        do {
            let promise = try sheet.showAsync()!
            promise.completed = { [weak sheet] _, status in
                guard let sheet, status == .completed else {
                    return
                }

                sheet.dismissHandler?()
            }
        } catch {
            // Force tries don't print properly in some Windows environments, and this
            // is a particularly useful error to have access to, because there are legitimate
            // edge cases under which this could be triggered
            print("Error: \(error)")
            fatalError("\(error)")
        }
    }

    public func dismissSheet(_ sheet: Sheet, window: Window, parentSheet: Sheet?) {
        print("Dismissing sheet programmatically")
        try! sheet.hide()
    }

    public func size(ofSheet sheet: Sheet) -> SIMD2<Int> {
        .zero
    }
}
