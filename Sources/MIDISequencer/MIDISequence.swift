import Foundation
import AudioToolbox

///
/// Example:
///
/// ```
/// func midiExample() throws {
///     let sequence = try MIDISequence(bpm: 120)
///
///     let track1 = try sequence.addTrack()
///     var time = 2.0
///     for index: UInt8 in 60...72 {
///         let note = MIDINote(channel: 0, note: index, velocity: 64, releaseVelocity: 0, duration: .quarter)
///         track1.add(note: note, at: time)
///         time += 1.0
///     }
///
///     let track2 = try sequence.addTrack()
///     time = 2.0
///     for index: UInt8 in 10...22 {
///         let note = MIDINote(channel: 0, note: index, velocity: 64, releaseVelocity: 0, duration: .whole)
///         track2.add(note: note, at: time)
///         time += MIDINoteDuration.whole.rawValue
///     }
///
///     let track3 = try sequence.addTrack()
///     time = 2.0
///     for index: UInt8 in 30...42 {
///         let note = MIDINote(channel: 1, note: index, velocity: 64, releaseVelocity: 0, duration: .quarter)
///         track3.add(note: note, at: time)
///         time += 1.0
///     }
///
///     let track4 = try sequence.addTrack()
///
///     track4.add(program: 127, on: 10, at: 1.0)
///
///     time = 2.0
///     for index: UInt8 in 36...48 {
///         let note = MIDINote(channel: 10, note: index, velocity: 64, releaseVelocity: 0, duration: .quarter)
///         track4.add(note: note, at: time)
///         time += 1.0
///     }
///
///     sequence.save(to: "/tmp/test.mid")
/// }
/// ```
///
public class MIDISequence {
        
    public let sequence: MusicSequence
    
    public init(bpm: MIDIBeatsPerMinute = 120.0) throws {
        var sequence: MusicSequence?
        let status = NewMusicSequence(&sequence)
        guard status == noErr else {
            throw MIDIError.failedToCreateSequence(errorCode: status)
        }
        self.sequence = sequence!
        
        let tempoStatus = addTempoTrackEvent(bpm: bpm)
        guard tempoStatus == noErr else {
            throw MIDIError.failedToCreateSequence(errorCode: status)
        }
    }
    
    public func addTrack() throws -> MIDITrack {
        let track = try MIDITrack(sequence: sequence)
        return track
    }
    
    /// Serialize MIDI file to data. Can be played by AVMIDIPlayer.
    public func serialize() throws -> Data {
        var cfData: Unmanaged<CFData>?
        let status = MusicSequenceFileCreateData(sequence, .midiType, .eraseFile, 480, &cfData)
        guard status == noErr else {
            throw MIDIError.failedToSerializeSequence(errorCode: status)
        }
        let data = cfData!.takeUnretainedValue() as Data
        return data
    }
    
    public func save(to path: String) throws {
        let url = NSURL(fileURLWithPath: path)
        let status = MusicSequenceFileCreate(sequence, url, .midiType, .eraseFile, 0)
        guard status == noErr else {
            throw MIDIError.failedToSaveSequence(errorCode: status)
        }
    }
    
    private func addTempoTrackEvent(bpm: MIDIBeatsPerMinute) -> OSStatus {
        var tempoTrack: MusicTrack?
        let status = MusicSequenceGetTempoTrack(sequence, &tempoTrack)
        guard status == OSStatus(noErr) else {
            return status
        }
        
        let eventStatus = MusicTrackNewExtendedTempoEvent(tempoTrack!, 0, Float64(bpm))
        guard eventStatus == noErr else {
            return eventStatus
        }
        
        return noErr
    }
    
}
