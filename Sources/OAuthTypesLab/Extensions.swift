//
//  Extensions.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-30.
//

extension String {

    /// Returns the character at the specified zero-based index if it exists.
    ///
    /// - Parameter index: The index number to search for.
    /// - Returns: The `Character` object containing the indexed character from the string (if valid), or
    /// `nil` (if not).
    public func character(at index: Int) -> Character? {
        guard index >= 0 && index < self.count else { return nil }
        let stringIndex = self.index(self.startIndex, offsetBy: index)

        return self[stringIndex]
    }
}
