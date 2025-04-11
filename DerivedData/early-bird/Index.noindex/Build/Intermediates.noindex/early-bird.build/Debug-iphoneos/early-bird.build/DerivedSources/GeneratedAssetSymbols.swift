import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "LockIcon" asset catalog image resource.
    static let lockIcon = ImageResource(name: "LockIcon", bundle: resourceBundle)

    /// The "circleBtn" asset catalog image resource.
    static let circleBtn = ImageResource(name: "circleBtn", bundle: resourceBundle)

    /// The "circleBtn2" asset catalog image resource.
    static let circleBtn2 = ImageResource(name: "circleBtn2", bundle: resourceBundle)

    /// The "fireIcon" asset catalog image resource.
    static let fireIcon = ImageResource(name: "fireIcon", bundle: resourceBundle)

    /// The "lineArrowIcon" asset catalog image resource.
    static let lineArrowIcon = ImageResource(name: "lineArrowIcon", bundle: resourceBundle)

    /// The "mascotAngryFace" asset catalog image resource.
    static let mascotAngryFace = ImageResource(name: "mascotAngryFace", bundle: resourceBundle)

    /// The "mascotNormalFace" asset catalog image resource.
    static let mascotNormalFace = ImageResource(name: "mascotNormalFace", bundle: resourceBundle)

    /// The "mascotSmileFace" asset catalog image resource.
    static let mascotSmileFace = ImageResource(name: "mascotSmileFace", bundle: resourceBundle)

    /// The "onboardMascot" asset catalog image resource.
    static let onboardMascot = ImageResource(name: "onboardMascot", bundle: resourceBundle)

    /// The "splash" asset catalog image resource.
    static let splash = ImageResource(name: "splash", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "LockIcon" asset catalog image.
    static var lockIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lockIcon)
#else
        .init()
#endif
    }

    /// The "circleBtn" asset catalog image.
    static var circleBtn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .circleBtn)
#else
        .init()
#endif
    }

    /// The "circleBtn2" asset catalog image.
    static var circleBtn2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .circleBtn2)
#else
        .init()
#endif
    }

    /// The "fireIcon" asset catalog image.
    static var fireIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .fireIcon)
#else
        .init()
#endif
    }

    /// The "lineArrowIcon" asset catalog image.
    static var lineArrowIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lineArrowIcon)
#else
        .init()
#endif
    }

    /// The "mascotAngryFace" asset catalog image.
    static var mascotAngryFace: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mascotAngryFace)
#else
        .init()
#endif
    }

    /// The "mascotNormalFace" asset catalog image.
    static var mascotNormalFace: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mascotNormalFace)
#else
        .init()
#endif
    }

    /// The "mascotSmileFace" asset catalog image.
    static var mascotSmileFace: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mascotSmileFace)
#else
        .init()
#endif
    }

    /// The "onboardMascot" asset catalog image.
    static var onboardMascot: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .onboardMascot)
#else
        .init()
#endif
    }

    /// The "splash" asset catalog image.
    static var splash: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .splash)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "LockIcon" asset catalog image.
    static var lockIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lockIcon)
#else
        .init()
#endif
    }

    /// The "circleBtn" asset catalog image.
    static var circleBtn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .circleBtn)
#else
        .init()
#endif
    }

    /// The "circleBtn2" asset catalog image.
    static var circleBtn2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .circleBtn2)
#else
        .init()
#endif
    }

    /// The "fireIcon" asset catalog image.
    static var fireIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .fireIcon)
#else
        .init()
#endif
    }

    /// The "lineArrowIcon" asset catalog image.
    static var lineArrowIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lineArrowIcon)
#else
        .init()
#endif
    }

    /// The "mascotAngryFace" asset catalog image.
    static var mascotAngryFace: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mascotAngryFace)
#else
        .init()
#endif
    }

    /// The "mascotNormalFace" asset catalog image.
    static var mascotNormalFace: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mascotNormalFace)
#else
        .init()
#endif
    }

    /// The "mascotSmileFace" asset catalog image.
    static var mascotSmileFace: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mascotSmileFace)
#else
        .init()
#endif
    }

    /// The "onboardMascot" asset catalog image.
    static var onboardMascot: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .onboardMascot)
#else
        .init()
#endif
    }

    /// The "splash" asset catalog image.
    static var splash: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .splash)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog color resource name.
    fileprivate let name: Swift.String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog image resource name.
    fileprivate let name: Swift.String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif