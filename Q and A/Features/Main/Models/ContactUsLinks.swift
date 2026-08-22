//
//  ContactUsLinks.swift
//  Q and A
//
//  Created by GIGL-PC on 22/08/2026.
//

import Foundation


struct ContactLinks {
    var whatsApp: URL?
    var email: URL?
    var facebook: URL?
    var twitter: URL?
    var instagram: URL?
    var tiktok: URL?
 
    static let `default` = ContactLinks(
        // wa.me/<countrycode><number>, optionally with ?text= prefill
        whatsApp: URL(string: "https://wa.me/2347052193183"),
        // mailto: supports subject/body query params if you want to prefill
        email: URL(string: "mailto:knowbaseconsult@gmail.com"),
        facebook: URL(string: "https://www.facebook.com/qaapp"),
        twitter: URL(string: "https://x.com/qa_app"),
        instagram: URL(string: "https://www.instagram.com/qtn_ans/"),
        tiktok: URL(string: "https://www.tiktok.com/@qanda_app")
    )
}
