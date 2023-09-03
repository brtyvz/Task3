import SwiftUI
import UserNotifications
import Foundation

class TimerManager: ObservableObject {
    @Published var selectedMinutes = UserDefaults.standard.integer(forKey: "selectedMinutes")
    @Published var selectedSeconds = UserDefaults.standard.integer(forKey: "selectedSeconds")
    @Published var isTimerRunning = false
    @Published var isTimerCompleted = false

    
    private var timer: Timer?
    
    var timeString: String {
        return String(format: "%02d:%02d", selectedMinutes, selectedSeconds)
    }
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if success {
                print("Notification authorization granted.")
            } else if let error = error {
                print("Error requesting authorization: \(error)")
            }
        }
        
        // Uygulama açıldığında, zamanlayıcıyı güncelleyin
        updateTimerBasedOnAppCloseTime()
    }
    
    func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.selectedSeconds > 0 {
                self.selectedSeconds -= 1
            } else if self.selectedMinutes > 0 {
                self.selectedMinutes -= 1
                self.selectedSeconds = 59
            } else {
                self.stopTimer()
                self.isTimerCompleted = true // Zamanlayıcı tamamlandı
            }
        }
        saveTime()
    }

    func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
        saveTime()
    }
    
    func resetTimer() {
        selectedMinutes = 0
        selectedSeconds = 0
        stopTimer()
        saveTime()
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your timer has finished counting down."
        
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "ringtone.mp3"))
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: "timerFinished", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error sending notification: \(error)")
            }
        }
    }
    
    func saveTime() {
        UserDefaults.standard.set(selectedMinutes, forKey: "selectedMinutes")
        UserDefaults.standard.set(selectedSeconds, forKey: "selectedSeconds")
    }
    
    func saveAppCloseTime() {
        let closeTime = Date()
        UserDefaults.standard.set(closeTime, forKey: "appCloseTime")
    }
    
    func updateTimerBasedOnAppCloseTime() {
        if let appCloseTime = UserDefaults.standard.object(forKey: "appCloseTime") as? Date {
            let currentTime = Date()
            let elapsedTime = currentTime.timeIntervalSince(appCloseTime)
            
            // ElapsedTime, uygulamanın kapalı kaldığı süreyi saniye cinsinden içerir.
            // Bu süreyi kullanarak zamanlayıcıyı güncelleyebilirsiniz.
            // Örneğin, self.selectedSeconds += Int(elapsedTime)
            
            // Zamanlayıcıyı güncelledikten sonra kaydedilen kapanma zamanını sıfırlayın.
            UserDefaults.standard.removeObject(forKey: "appCloseTime")
        }
    }
}













//
//
//
//import SwiftUI
//import UserNotifications
//import UIKit
//import Foundation
//
//class TimerManager: ObservableObject {
//    @Published var selectedMinutes = 0
//    @Published var selectedSeconds = 0
//    @Published var isTimerRunning = false
//
//    private var timer: Timer?
//
//    var timeString: String {
//        return String(format: "%02d:%02d", selectedMinutes, selectedSeconds)
//    }
//
//    init() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
//            if success {
//                print("Notification authorization granted.")
//            } else if let error = error {
//                print("Error requesting authorization: \(error)")
//            }
//        }
//    }
//
//    func startTimer() {
//        isTimerRunning = true
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if self.selectedSeconds > 0 {
//                self.selectedSeconds -= 1
//            } else if self.selectedMinutes > 0 {
//                self.selectedMinutes -= 1
//                self.selectedSeconds = 59
//            } else {
//                self.stopTimer()
//                self.sendNotification()
//            }
//        }
//    }
//
//    func stopTimer() {
//        isTimerRunning = false
//        timer?.invalidate()
//        timer = nil
//    }
//
//    func resetTimer() {
//        selectedMinutes = 0
//        selectedSeconds = 0
//        stopTimer()
//    }
//
//    func sendNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "Timer Finished"
//        content.body = "Your timer has finished counting down."
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//
//        let request = UNNotificationRequest(identifier: "timerFinished", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { (error) in
//            if let error = error {
//                print("Error sending notification: \(error)")
//            }
//        }
//    }
//}
