//
//  ScrumTimer.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 25/03/2023.
//

import Foundation

// Periodically updates the state of a meeting
//The timer calls the speakerChangedAction closure when the speaker changes and shares other important state changes through @Published properties.

/// Keeps time for a daily scrum meeting.
/// Keep track of the total meeting time,
/// the time for each speaker,
/// and the name of the current speaker.

class ScrumTimer: ObservableObject {

    /// A struct to keep track of meeting attendees during a meeting.
    struct Speaker: Identifiable {
        /// The attendee name.
        var name: String
        /// True if the attendee has completed their turn to speak.
        var isCompleted: Bool
        /// Id for Identifiable conformance.
        var id: UUID = UUID()
    }

    /// The name of the meeting attendee who is speaking.
    @Published var activeSpeaker: String = ""
    /// The number of seconds since the beginning of the meeting.
    @Published var secondsElapsed: Int = 0
    /// The number of seconds until all attendees have had a turn to speak.
    @Published var secondsRemaining: Int = 0
    /// All meeting attendees, listed in the order they will speak.
    private(set) var speakers: [Speaker] = []


    /// The scrum meeting length.
    private(set) var lengthInMinutes: Int
    /// A closure that is executed when a new attendee begins speaking.
    var speakerChangedAction: (() -> Void)?


    // A timer that fires after a certain time interval has elapsed, sending a specified message to a target object
    private var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerSpeaker: Int {
        (lengthInMinutes * 60) / speakers.count // total sec per speaker
    }
    private var secondsElapsedForSpeaker: Int = 0
    private var speakerIndex: Int = 0
    private var speakerText: String {
        return "Speaker \(speakerIndex + 1): " + speakers[speakerIndex].name
    }
    private var startDate: Date?

    /**
     Initialize a new timer. Initializing a time with no arguments creates a ScrumTimer with no attendees and zero length.
     Use `startScrum()` to start the timer.

     - Parameters:
        - lengthInMinutes: The meeting length.
        -  attendees: A list of attendees for the meeting.
     */

    init(lengthInMinutes: Int = 0, attendees: [DailyScrum.Attendee] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }

    /// Start the timer.
    func startScrum() {
       changeToSpeaker(at: 0)
    }

    /// Stop the timer.
    func stopScrum() {
        timer?.invalidate()
        timer = nil
        timerStopped = true
    }

    
    /// Advance the timer to the next speaker.
    func skipSpeaker() {
       changeToSpeaker(at: speakerIndex + 1)
    }

   private func changeToSpeaker(at index: Int) {
       if index > 0 {
           let previousSpeakerIndex = index - 1
           speakers[previousSpeakerIndex].isCompleted = true
       }
       secondsElapsedForSpeaker = 0     // start from 0 for a new one

       guard index < speakers.count else { return }
       speakerIndex = index
       activeSpeaker = speakerText

       secondsElapsed = index * secondsPerSpeaker // number of speakers * total time per speaker
       secondsRemaining = lengthInSeconds - secondsElapsed
       startDate = Date()
       timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
           if let self = self, let startDate = self.startDate {
               let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970 // current time - start time
               self.update(secondsElapsed: Int(secondsElapsed))
           }
       }
   }

   private func update(secondsElapsed: Int) {
       secondsElapsedForSpeaker = secondsElapsed
       self.secondsElapsed = secondsPerSpeaker * speakerIndex + secondsElapsedForSpeaker // total time running scrums in sec
       guard secondsElapsed <= secondsPerSpeaker else {
           return
       }
       secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)

       guard !timerStopped else { return }

       if secondsElapsedForSpeaker >= secondsPerSpeaker {
           changeToSpeaker(at: speakerIndex + 1)
           speakerChangedAction?()
       }
   }

   /**
    Reset the timer with a new meeting length and new attendees.

    - Parameters:
        - lengthInMinutes: The meeting length.
        - attendees: The name of each attendee.
    */
   func reset(lengthInMinutes: Int, attendees: [DailyScrum.Attendee]) {
       self.lengthInMinutes = lengthInMinutes
       self.speakers = attendees.speakers
       secondsRemaining = lengthInSeconds
       activeSpeaker = speakerText
   }
}

extension DailyScrum {
    /// A new `ScrumTimer` using the meeting length and attendees in the `DailyScrum`.
    var timer: ScrumTimer {
        ScrumTimer(lengthInMinutes: lengthInMinutes, attendees: attendees)
    }
}


extension Array where Element == DailyScrum.Attendee {
    var speakers: [ScrumTimer.Speaker] {
        if isEmpty {
            return [ScrumTimer.Speaker(name: "Speaker 1", isCompleted: false)]
        } else {
            return map { ScrumTimer.Speaker(name: $0.name, isCompleted: false) }
        }
    }
}
