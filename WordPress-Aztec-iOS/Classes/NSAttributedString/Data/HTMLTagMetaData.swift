import Foundation

/// Class for storing meta-data for a single HTML tag.
///
class HTMLTagMetaData: CustomReflectable {

    /// The tag name.  The node name.  For example in the case of `<strong>` the name would be
    /// "strong".
    ///
    var name: String

    /// Unique ID to identify the tag.  Unfortunately we can't just use the tag name because
    /// doing so would break in cases such as `<div><div>...content...</div></div>`.
    ///
    let uuid = NSUUID().UUIDString

    // MARK: - Tag hierarchy

    /// Child tag.
    ///
    weak var child: HTMLTagMetaData?

    /// Parent tag.
    ///
    weak var parent: HTMLTagMetaData?

    // MARK: - Init

    init(name: String) {
        self.name = name
    }

    // MARK: - Attribute Key

    static func key(forTagNamed name: String, uniqueId uuid: String) -> String {
        return "Aztec.HTMLTag.\(name).\(uuid)"
    }

    func key() -> String {
        return self.dynamicType.key(forTagNamed: name, uniqueId: uuid)
    }

    // MARK: - CustomReflectable

    public func customMirror() -> Mirror {
        return Mirror(self, children: ["name": name, "parent": parent, "child": child])
    }
}
