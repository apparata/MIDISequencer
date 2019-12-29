//
//  Copyright © 2017 Apparata AB. All rights reserved.
//

import Foundation
import AudioToolbox

public class MIDITrack {
    
    private let track: MusicTrack
    
    internal init(sequence: MusicSequence) throws {
        var track: MusicTrack?
        let status = MusicSequenceNewTrack(sequence, &track)
        guard status == noErr, let newTrack = track else {
            throw MIDIError.failedToCreateTrack(errorCode: status)
        }
        self.track = newTrack
    }
    
    @discardableResult
    public func add(note: MIDINote, at timeInBeats: MIDIBeat) -> Bool {
        var note = MIDINoteMessage(channel: note.channel,
                                   note: note.note,
                                   velocity: note.velocity,
                                   releaseVelocity: note.releaseVelocity,
                                   duration: Float32(note.duration))
        let status = MusicTrackNewMIDINoteEvent(track, timeInBeats, &note)
        return status == noErr
    }
    
    @discardableResult
    public func add(program: UInt8, on channel: UInt8, at timeInBeats: MIDIBeat) -> Bool {
        var message = MIDIChannelMessage(status: (0xC << 4) | channel, data1: program, data2: 0, reserved: 0)
        let status = MusicTrackNewMIDIChannelEvent(track, timeInBeats, &message)
        return status == noErr
    }
}
