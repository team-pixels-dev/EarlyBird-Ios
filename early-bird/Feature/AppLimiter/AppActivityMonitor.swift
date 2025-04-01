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
        AppLimiter.shared.stopBlocking()
    }
}
