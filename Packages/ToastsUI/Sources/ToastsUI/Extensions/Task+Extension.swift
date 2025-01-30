import Foundation

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        if #available(iOS 16.0, *) {
            try await sleep(for: .seconds(seconds))
        } else {
            try await sleep(nanoseconds: UInt64(seconds * 1000) * NSEC_PER_MSEC)
        }
    }
}
