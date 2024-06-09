//
//  Localization.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-06.
//

import SwiftUI

public enum Localization {
    enum App {
        public static var title: LocalizedStringKey {
            return "weatherApp.title"
        }
        public static var loadingTitle: LocalizedStringKey {
            return "weatherApp.loading.title"
        }
        public static var error: LocalizedStringKey {
            return "weatherApp.error"
        }
        public static var ok: LocalizedStringKey {
            return "weatherApp.ok"
        }
    }
}
