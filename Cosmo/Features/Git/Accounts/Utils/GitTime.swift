/* -----------------------------------------------------------
 * :: :  C  O  S  M  O  :                                   ::
 * -----------------------------------------------------------
 * @wabistudios :: cosmos :: realms
 *
 * CREDITS.
 *
 * T.Furby              @furby-tm       <devs@wabi.foundation>
 *
 *         Copyright (C) 2023 Wabi Animation Studios, Ltd. Co.
 *                                        All Rights Reserved.
 * -----------------------------------------------------------
 *  . x x x . o o o . x x x . : : : .    o  x  o    . : : : .
 * ----------------------------------------------------------- */

import Foundation

// TODO: DOCS (Nanashi Li)
enum GitTime
{
  /**
   A date formatter for RFC 3339 style timestamps.
   Uses POSIX locale and GMT timezone so that date values are parsed as absolutes.
   - (https://tools.ietf.org/html/rfc3339)
   - (https://developer.apple.com/library/mac/qa/qa1480/_index.html)
   */
  static var rfc3339DateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
  }()

  /**
   Parses RFC 3339 date strings into NSDate
   - parameter string: The string representation of the date
   - returns: An `NSDate` with a successful parse, otherwise `nil`
   */
  static func rfc3339Date(_ string: String?) -> Date?
  {
    guard let string else { return nil }
    return GitTime.rfc3339DateFormatter.date(from: string)
  }
}
