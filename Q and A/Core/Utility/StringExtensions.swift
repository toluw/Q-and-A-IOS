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
    
    
    func convertCommaDelimitedStringToList() -> [String] {
          self.split(separator: ",")
              .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
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
