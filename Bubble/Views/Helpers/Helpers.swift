import Foundation
import SwiftUI

/// `RelativeDateTimeFormatter` convenience function
func timeSince(_ interval: TimeInterval) -> String {
    let formatter = RelativeDateTimeFormatter()
    return formatter.localizedString(for: Date(timeIntervalSince1970: interval), relativeTo: Date())
}
