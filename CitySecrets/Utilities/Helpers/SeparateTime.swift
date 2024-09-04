import Foundation

func separateTime(for time: String) -> [String] {
    return time.components(separatedBy: "-")
}

