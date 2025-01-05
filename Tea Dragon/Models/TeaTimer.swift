//
//  TeaTimer.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 28.12.24.
//

import Foundation


@MainActor
final class TeaTimer: ObservableObject {

    
    @Published private var _timeElapsed = TimePeriod(seconds: 0)
    private weak var timer: Timer?
    @Published var timerStopped = false
    var isRunning: Bool {
        get {
            !timerStopped
        }
        set {
            timerStopped = !newValue
        }
    }
    private var frequency: TimeInterval { 1.0 / 60.0 }
    @Published var totalTime = TimePeriod(seconds: 0) // should not be changeable from outside?
    @Published var aaa = TimePeriod(seconds: 0)
    private var forceUpdate: Bool = false
    private var endDate: Date?
    private var _timeRemaining: TimePeriod {
        get {
            totalTime - _timeElapsed
        }
        set {
            _timeElapsed = totalTime - newValue
        }
    }
    
    var timeRemaining: TimePeriod {
        get {
            _timeRemaining
        }
        set {
            _timeRemaining = newValue
            forceUpdate = true
        }
    }
    
    var timeElapsed: TimePeriod {
        get {
            _timeElapsed
        }
        set {
            _timeElapsed = newValue
            forceUpdate = true
        }
    }
    
    var timerEndedAction: (() -> Void)?
    
    init(timePeriod: TimePeriod = TimePeriod(minutes: 0, seconds: 60)) {
        self.totalTime = timePeriod.copy()
        self._timeElapsed = TimePeriod(seconds: 0)
    }
    
    
    func start() {
        timerStopped = false
        forceUpdate = true
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            self?.update()
        }
        timer?.tolerance = 0.1
    }
    
    func stop() {
        timer?.invalidate()
        timerStopped = true
    }

    nonisolated private func update() {

        Task { @MainActor in
            if forceUpdate {
                endDate = Date(timeInterval: _timeRemaining.time_interval, since: Date())
                forceUpdate = false
            }
            guard let endDate,
                  !timerStopped else {
                return
            }
            let millisecondsRemaining = Int((endDate.timeIntervalSince1970 - Date().timeIntervalSince1970) * 1000)
            self._timeRemaining = TimePeriod(milliseconds: millisecondsRemaining)

                if (!_timeRemaining.isPositive()) {
                    timerStopped = true
                timerEndedAction?()
            }
        }
    }
    
    
    func reset(timePeriod: TimePeriod) {
        stop()
        self._timeElapsed = TimePeriod(seconds: 0)
        self.totalTime = timePeriod.copy()
    }
}
