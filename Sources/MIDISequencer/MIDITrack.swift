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
    public func add(preset: MIDIPreset, on channel: UInt8, at timeInBeats: MIDIBeat) -> Bool {
        add(bank: preset.bank, program: preset.program, on: channel, at: timeInBeats)
    }
    
    /// Add "bank select" and "program change" messages to the track.
    /// 
    /// Note that the bank is a 14-bit number, and msb is the upper 7 bits,
    /// and lsb is the lower 7 bits, but it seems like for SF2 sound fonts
    /// the msb is the lower 7 bits and the lsb is the upper 7 bits, for some reason.
    @discardableResult
    public func add(bank: (msb: UInt8, lsb: UInt8) = (msb: 0, lsb: 0), program: UInt8, on channel: UInt8, at timeInBeats: MIDIBeat) -> Bool {
        
        var message0 = MIDIChannelMessage(status: (0xB << 4) | channel, data1: 0, data2: bank.msb, reserved: 0)
        let status0 = MusicTrackNewMIDIChannelEvent(track, timeInBeats, &message0)
        guard status0 == noErr else {
            return false
        }

        var message1 = MIDIChannelMessage(status: (0xB << 4) | channel, data1: 32, data2: bank.lsb, reserved: 0)
        let status1 = MusicTrackNewMIDIChannelEvent(track, timeInBeats, &message1)
        guard status1 == noErr else {
            return false
        }
        
        var message2 = MIDIChannelMessage(status: (0xC << 4) | channel, data1: program, data2: 0, reserved: 0)
        let status2 = MusicTrackNewMIDIChannelEvent(track, timeInBeats, &message2)
        return status2 == noErr
    }
}
