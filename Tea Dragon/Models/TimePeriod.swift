import SwiftUI

struct TimePeriod: Identifiable, Hashable, Codable {
    
    let id: UUID
    var total_milliseconds: Int = 0
    
    var time_interval: TimeInterval {
        get {
            Double(total_milliseconds) / 1000.0
        }
        set {
            total_milliseconds = Int(newValue * 1000)
        }
    }
    
    var total_seconds: Int {
        set {
            total_milliseconds = newValue * 1000
        }
        get {
            total_milliseconds / 1000
        }
    }
    
    var total_minutes: Int {
        set {
            total_seconds = newValue * 60
        }
        get {
            total_seconds / 60
        }
    }
    
    // Getter for minutes
        var minutes: Int {
            get {
                return total_milliseconds / 60000 // 1 minute = 60000 milliseconds
            }
            set(newMinutes) {
                // Calculate the total milliseconds for the new minutes
                let currentSeconds = (total_milliseconds / 1000) % 60 // Extract the current seconds
                total_milliseconds = (newMinutes * 60000) + (currentSeconds * 1000)
            }
        }

        // Getter for seconds
        var seconds: Int {
            get {
                return (total_milliseconds / 1000) % 60 // Extract seconds from total milliseconds
            }
            set(newSeconds) {
                // Validate the newSeconds to ensure it fits within the 0–59 range
                guard newSeconds >= 0 && newSeconds < 60 else {
                    print("Seconds must be in the range 0–59.")
                    return
                }

                // Calculate the new total milliseconds, preserving minutes
                let currentMinutes = total_milliseconds / 60000
                total_milliseconds = (currentMinutes * 60000) + (newSeconds * 1000)
            }
        }
    
    
    init(id: UUID = UUID(), minutes: Int, seconds: Int) {
        self.id = id
        self.minutes = minutes
        self.seconds = seconds
    }
    
    init(seconds: Int) {
        self.init(minutes: seconds / 60, seconds: seconds % 60)
    }
    
    init(milliseconds: Int) {
        self.id = UUID()
        self.total_milliseconds = milliseconds
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(minutes)
        hasher.combine(seconds)
    }
    

    func formatTime() -> String {
        String(format: "%02d:%02d", minutes, seconds)
    }
    
    func copy() -> TimePeriod {
        TimePeriod(milliseconds: self.total_milliseconds)
    }
    
    static func - (lhs: TimePeriod, rhs: TimePeriod) -> TimePeriod {
        let milliseconds = lhs.total_milliseconds - rhs.total_milliseconds
        return TimePeriod(milliseconds: max(milliseconds, 0))
        
    }
    
    static func + (lhs: TimePeriod, rhs: TimePeriod) -> TimePeriod {
        let milliseconds = lhs.total_milliseconds + rhs.total_milliseconds
        return TimePeriod(milliseconds: milliseconds)
    }
    
    func isPositive() -> Bool {
        if total_milliseconds > 0 {
            return true
        }
        return false
    }
}
