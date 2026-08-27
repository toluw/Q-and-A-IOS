//
//  UpdateManager.swift
//  Q and A
//
//  Created by GIGL-PC on 27/08/2026.
//

import Foundation
import FirebaseRemoteConfig


@MainActor
final class UpdateManager: ObservableObject {
    @Published var updateStatus: UpdateStatus = .none

    private let remoteConfig: RemoteConfig

    init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 // adjust for production (e.g. 3600)
        remoteConfig.configSettings = settings
    }

    func checkForUpdate() async {
        do {
            try await remoteConfig.fetchAndActivate()

            let minRequiredVersion = remoteConfig["ios_minimum_required_version"].stringValue
            let latestVersion = remoteConfig["ios_latest_version"].stringValue
            let updateURLString = remoteConfig["ios_update_url"].stringValue
            let forceMessage = remoteConfig["force_update_message"].stringValue
            let optionalMessage = remoteConfig["optional_update_message"].stringValue

            guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                  let updateURL = URL(string: updateURLString) else {
                return
            }

            if currentVersion.isVersion(lessThan: minRequiredVersion) {
                updateStatus = .forced(message: forceMessage, url: updateURL)
            } else if currentVersion.isVersion(lessThan: latestVersion) {
                updateStatus = .optional(message: optionalMessage, url: updateURL)
            } else {
                updateStatus = .none
            }
        } catch {
            print("Remote Config fetch failed: \(error)")
        }
    }
}
