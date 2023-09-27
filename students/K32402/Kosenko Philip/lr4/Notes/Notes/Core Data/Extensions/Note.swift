

import Foundation

extension Note {

    var updatedAtAsDate: Date {
        guard let updatedAt = updatedAt else { return Date() }
        return Date(timeIntervalSince1970: updatedAt.timeIntervalSince1970)
    }

    var createdAtAsDate: Date {
        guard let createdAt = createdAt else { return Date() }
        return Date(timeIntervalSince1970: createdAt.timeIntervalSince1970)
    }

}
