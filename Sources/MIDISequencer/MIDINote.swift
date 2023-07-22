import Foundation

public struct MIDINote {
    
    let channel: UInt8
    let note: UInt8
    let velocity: UInt8
    let releaseVelocity: UInt8
    let duration: MIDIBeat
    
    public init(channel: UInt8,
                note: UInt8,
                velocity: UInt8 = 64,
                releaseVelocity: UInt8 = 0,
                duration: MIDIBeat = 1.0) {
        self.channel = channel
        self.note = note
        self.velocity = velocity
        self.releaseVelocity = releaseVelocity
        self.duration = duration
    }
    
    public init(channel: UInt8,
                note: UInt8,
                velocity: UInt8 = 64,
                releaseVelocity: UInt8 = 0,
                duration: MIDINoteDuration) {
        self.init(channel: channel,
                  note: note,
                  velocity: velocity,
                  releaseVelocity: releaseVelocity,
                  duration: duration.rawValue)
    }

    public init(channel: UInt8,
                note: MIDINoteName,
                velocity: UInt8 = 64,
                releaseVelocity: UInt8 = 0,
                duration: MIDIBeat = 1.0) {
        self.channel = channel
        self.note = note.value
        self.velocity = velocity
        self.releaseVelocity = releaseVelocity
        self.duration = duration
    }
    
    public init(channel: UInt8,
                note: MIDINoteName,
                velocity: UInt8 = 64,
                releaseVelocity: UInt8 = 0,
                duration: MIDINoteDuration) {
        self.init(channel: channel,
                  note: note.value,
                  velocity: velocity,
                  releaseVelocity: releaseVelocity,
                  duration: duration.rawValue)
    }

}
