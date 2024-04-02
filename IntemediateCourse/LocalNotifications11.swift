//
//  LocalNotifications11.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 24.03.2024.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager() // Singleton
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS!")
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Your discord server history has been exposed!"
        content.subtitle = "FBI and SWAT teams has been sent to your address. Say good bye your imaginary girlfriend."
        content.sound = .defaultCritical
        content.badge = 1
        
        // There are three types of triggers we can add
        // time
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 15
//        dateComponents.minute = 20
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // location
        let center = CLLocationCoordinate2D(
            latitude: 37.335400,
            longitude: -122.009201)
        let region = CLCircularRegion(
            center: center,
            radius: 100,
            identifier: "Headquarters")
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotifications11: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Send Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
    }
}

struct LocalNotifications11_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotifications11()
    }
}
