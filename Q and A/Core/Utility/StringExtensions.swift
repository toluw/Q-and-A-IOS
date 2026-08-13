//
//  String.swift
//  Q and A
//
//  Created by GIGL-PC on 04/04/2026.
//

import Foundation


extension String{
    
    func isValidEmail() -> Bool {
            NSPredicate(
                format: "SELF MATCHES %@",
                "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
            ).evaluate(with: self)
        }
    
    func parseGeminiContent() -> [ContentSegment] {

            let pattern = #"\$\$(.*?)\$\$|\$(.*?)\$"#

            guard let regex = try? NSRegularExpression(
                pattern: pattern,
                options: [.dotMatchesLineSeparators]
            ) else {
                return [.text(self)]
            }

            var segments: [ContentSegment] = []
            var lastLocation = startIndex

            let matches = regex.matches(
                in: self,
                range: NSRange(startIndex..., in: self)
            )

            for match in matches {

                guard let fullRange = Range(match.range, in: self) else {
                    continue
                }

                if lastLocation < fullRange.lowerBound {
                    let text = String(self[lastLocation..<fullRange.lowerBound])

                    if !text.isEmpty {
                        segments.append(.text(text))
                    }
                }

                if let blockRange = Range(match.range(at: 1), in: self),
                   !blockRange.isEmpty {

                    segments.append(
                        .math(String(self[blockRange]))
                    )
                }
                else if let inlineRange = Range(match.range(at: 2), in: self),
                        !inlineRange.isEmpty {

                    segments.append(
                        .math(String(self[inlineRange]))
                    )
                }

                lastLocation = fullRange.upperBound
            }

            if lastLocation < endIndex {

                segments.append(
                    .text(String(self[lastLocation...]))
                )
            }

            return segments
        }
    
    func capitalizeWords() -> String {
            return self
                .lowercased()
                .split(separator: " ")
                .map { word in
                    word.prefix(1).uppercased() + word.dropFirst()
                }
                .joined(separator: " ")
        }
    
    func isValidYouTubeUrl() -> Bool {
         let pattern = #"^(https?://)?(www\.)?(youtube\.com|youtu\.be)/(watch\?v=|embed/|v/)?[a-zA-Z0-9_-]{11}"#

         guard let regex = try? NSRegularExpression(
             pattern: pattern,
             options: [.caseInsensitive]
         ) else {
             return false
         }

         let range = NSRange(startIndex..., in: self)

         return regex.firstMatch(in: self, options: [], range: range) != nil
     }
    
    func normalizedURL() -> URL? {
        if self.hasPrefix("http://") || self.hasPrefix("https://") {
            return URL(string: self)
        } else {
            return URL(string: "https://\(self)")
        }
    }
    
    
    func convertCommaDelimitedStringToList() -> [String] {
          self.split(separator: ",")
              .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
      }
    
    func isValidMobile() -> Bool {
        let hasLetters = self.range(of: "[a-zA-Z]+", options: .regularExpression) != nil
        return !hasLetters && (7...13).contains(self.count)
    }
    
    func extractGoogleDriveFileId() -> String? {
           
           let patterns = [
               #"drive\.google\.com/file/d/([a-zA-Z0-9_-]{10,})"#,
               #"drive\.google\.com/.*[?&]id=([a-zA-Z0-9_-]{10,})"#,
               #"drive\.google\.com/open\?id=([a-zA-Z0-9_-]{10,})"#,
               #"drive\.google\.com/uc\?export=download&id=([a-zA-Z0-9_-]{10,})"#
           ]
           
           for pattern in patterns {
               do {
                   let regex = try NSRegularExpression(pattern: pattern)
                   let range = NSRange(startIndex..<endIndex, in: self)
                   
                   if let match = regex.firstMatch(in: self, range: range),
                      let fileIdRange = Range(match.range(at: 1), in: self) {
                       return String(self[fileIdRange])
                   }
               } catch {
                   print("Invalid regex: \(error)")
               }
           }
           
           return nil
       }
    
    func toBoldAttributedString() -> AttributedString {

            var result = AttributedString()

            let lines = self.components(separatedBy: .newlines)

            for line in lines {

                // Handle headings
                if line.hasPrefix("#### ") ||
                    line.hasPrefix("### ") ||
                    line.hasPrefix("## ") {

                    let title = line
                        .replacingOccurrences(of: "#### ", with: "")
                        .replacingOccurrences(of: "### ", with: "")
                        .replacingOccurrences(of: "## ", with: "")

                    var heading = AttributedString(title)
                    heading.font = .body.bold()

                    result.append(heading)
                    result.append(AttributedString("\n\n"))
                    continue
                }

                // Handle **bold**
                let pattern = #"\*\*(.*?)\*\*"#

                guard let regex = try? NSRegularExpression(
                    pattern: pattern
                ) else {

                    result.append(AttributedString(line))
                    result.append(AttributedString("\n"))
                    continue
                }

                var currentIndex = line.startIndex

                let matches = regex.matches(
                    in: line,
                    range: NSRange(line.startIndex..., in: line)
                )

                for match in matches {

                    guard
                        let fullRange = Range(match.range, in: line),
                        let boldRange = Range(match.range(at: 1), in: line)
                    else {
                        continue
                    }

                    // Normal text
                    let normalText = String(
                        line[currentIndex..<fullRange.lowerBound]
                    )

                    result.append(
                        AttributedString(normalText)
                    )

                    // Bold text
                    var boldText = AttributedString(
                        String(line[boldRange])
                    )

                    boldText.font = .body.bold()

                    result.append(boldText)

                    currentIndex = fullRange.upperBound
                }

                // Remaining text
                result.append(
                    AttributedString(
                        String(line[currentIndex...])
                    )
                )

                result.append(
                    AttributedString("\n")
                )
            }

            return result
        }
    
    
  /*  func toBoldAttributedString() -> AttributedString {
        var result = AttributedString()

        let titleRegex = try? NSRegularExpression(
            pattern: "^##\\s*(.*?)\\n",
            options: []
        )

        var currentIndex = startIndex

        // Handle title: ## Title
        if let match = titleRegex?.firstMatch(
            in: self,
            range: NSRange(startIndex..., in: self)
        ),
           let titleRange = Range(match.range(at: 1), in: self),
           let fullRange = Range(match.range, in: self) {

            var titleAttr = AttributedString(String(self[titleRange]))
            titleAttr.font = .body.bold()

            result.append(titleAttr)
            result.append(AttributedString("\n\n"))

            currentIndex = fullRange.upperBound
        }

        let contentText = String(self[currentIndex...])

        let boldRegex = try? NSRegularExpression(
            pattern: "\\*\\*(.*?)\\*\\*",
            options: []
        )

        var lastIndex = contentText.startIndex

        let matches = boldRegex?.matches(
            in: contentText,
            range: NSRange(contentText.startIndex..., in: contentText)
        ) ?? []

        for match in matches {
            guard
                let fullRange = Range(match.range, in: contentText),
                let boldRange = Range(match.range(at: 1), in: contentText)
            else { continue }

            // Append normal text
            result.append(
                AttributedString(
                    String(contentText[lastIndex..<fullRange.lowerBound])
                )
            )

            // Append bold text
            var boldAttr = AttributedString(String(contentText[boldRange]))
            boldAttr.font = .body.bold()
            result.append(boldAttr)

            lastIndex = fullRange.upperBound
        }

        // Append remaining text
        result.append(
            AttributedString(
                String(contentText[lastIndex...])
            )
        )

        return result
    }
    
   */
    func formatScore() -> String {
           // If the string doesn't contain a ".", treat it as an integer and return as-is
           guard contains(".") else { return self }
           
           guard let value = Double(self) else {
               return self // fallback: return original if it's not a valid number
           }
           
           let formatted = String(format: "%.2f", value)
           
           if formatted.hasSuffix(".00") {
               return String(formatted.dropLast(3))
           } else if formatted.hasSuffix("0") {
               return String(formatted.dropLast())
           } else {
               return formatted
           }
       }
    
   
}

extension Array where Element == String {
    func toCommaDelimitedString() -> String {
        return self.joined(separator: ", ")
    }
}


func convertGoogleDriveLinkToDirect(_ link: String?) -> String? {

    guard let link = link, !link.isEmpty else {
        return nil
    }

    // Match links containing /d/{fileId}
    let pattern = #"/d/([a-zA-Z0-9_-]+)"#

    if let regex = try? NSRegularExpression(pattern: pattern),
       let match = regex.firstMatch(
            in: link,
            range: NSRange(link.startIndex..., in: link)
       ),
       let fileIdRange = Range(match.range(at: 1), in: link) {

        let fileId = String(link[fileIdRange])
        return "https://drive.google.com/uc?export=download&id=\(fileId)"
    }

    // Fallback for links using ?id={fileId}
    if let components = URLComponents(string: link),
       let fileId = components.queryItems?
            .first(where: { $0.name == "id" })?
            .value,
       !fileId.isEmpty {

        return "https://drive.google.com/uc?export=download&id=\(fileId)"
    }

    return nil
}
