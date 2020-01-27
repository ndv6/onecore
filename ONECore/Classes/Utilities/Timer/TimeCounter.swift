//
//  TimeCounter.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 19/09/19.
//

import Foundation

public protocol TimeCounterDelegate: class {
    func timeCounterDidStart(ticker: TimeInterval)
    func timeCounterDidStop(ticker: TimeInterval)
    func timeCounterDidChanged(ticker: TimeInterval)
}

public class TimeCounter {
    private var lowerLimit: TimeInterval = DefaultValue.emptyTimeInterval
    private var upperLimit: TimeInterval = DefaultValue.emptyTimeInterval
    private var departureTime: TimeInterval = DefaultValue.emptyTimeInterval
    private var timer: Timer = Timer()
    private var direction: Int = DefaultValue.emptyInt
    private var interval: TimeInterval = DefaultValue.emptyTimeInterval
    private var ticker: TimeInterval = DefaultValue.emptyTimeInterval
    public weak var delegate: TimeCounterDelegate?

    public init() {}

    public func setLimit(
        lowerLimit: TimeInterval = DefaultValue.emptyTimeInterval,
        upperLimit: TimeInterval = DefaultValue.emptyTimeInterval
    ) {
        if upperLimit < lowerLimit { return }
        self.lowerLimit = lowerLimit
        self.upperLimit = upperLimit
    }

    public func startCountDown(interval: TimeInterval = 1) {
        startCounter(direction: -1, interval: interval)
    }

    public func startCountUp(interval: TimeInterval = 1) {
        startCounter(direction: 1, interval: interval)
    }

    public func stopCounter() {
        timer.invalidate()
        delegate?.timeCounterDidStop(ticker: ticker)
    }

    private func startCounter(direction: Int, interval: TimeInterval) {
        if interval <= DefaultValue.emptyTimeInterval { return }
        self.departureTime = TimeInterval(Date.currentUnixTimestamp())
        self.direction = direction
        self.interval = interval
        ticker = direction == -1 ? upperLimit : lowerLimit
        timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: (#selector(self.run)),
            userInfo: nil,
            repeats: true
        )
        delegate?.timeCounterDidStart(ticker: ticker)
    }

    @objc private func run() {
        let seconds = TimeInterval(Date.currentUnixTimestamp()) - departureTime
        ticker = direction == -1 ? upperLimit : lowerLimit
        ticker += (seconds * TimeInterval(direction))
        if (direction == 1 && ticker >= upperLimit) || (direction == -1 && ticker <= lowerLimit) {
            stopCounter()
            return
        }
        delegate?.timeCounterDidChanged(ticker: ticker)
    }
}
