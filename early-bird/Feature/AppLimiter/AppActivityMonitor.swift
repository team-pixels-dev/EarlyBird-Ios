//
//  AppActivityMonitor.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/1/25.
//
import DeviceActivity
import ManagedSettings

class AppActivityMonitor: DeviceActivityMonitor {
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)

        if activity.rawValue == "GlobalAppLimit" {
            let store = ManagedSettingsStore()
            store.shield.applications = []
            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.none
            print("✅ [Extension] 앱 차단 해제 완료 (intervalDidEnd)")
        }
        // Handle the end of the interval.
    }
}
