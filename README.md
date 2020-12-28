
# MIDISequencer

## License

See the LICENSE file for licensing information.

## Example

```swift
func midiExample() throws {
    let sequence = try MIDISequence(bpm: 120)

    let track1 = try sequence.addTrack()
    var time = 2.0
    for index: UInt8 in 60...72 {
        let note = MIDINote(channel: 0, note: index, velocity: 64, releaseVelocity: 0, duration: .quarter)
        track1.add(note: note, at: time)
        time += 1.0
    }

    let track2 = try sequence.addTrack()
    time = 2.0
    for index: UInt8 in 10...22 {
        let note = MIDINote(channel: 0, note: index, velocity: 64, releaseVelocity: 0, duration: .whole)
        track2.add(note: note, at: time)
        time += MIDINoteDuration.whole.rawValue
    }

    let track3 = try sequence.addTrack()
    time = 2.0
    for index: UInt8 in 30...42 {
        let note = MIDINote(channel: 1, note: index, velocity: 64, releaseVelocity: 0, duration: .quarter)
        track3.add(note: note, at: time)
        time += 1.0
    }

    let track4 = try sequence.addTrack()

    track4.add(program: 127, on: 10, at: 1.0)

    time = 2.0
    for index: UInt8 in 36...48 {
        let note = MIDINote(channel: 10, note: index, velocity: 64, releaseVelocity: 0, duration: .quarter)
        track4.add(note: note, at: time)
        time += 1.0
    }

    sequence.save(to: "/tmp/test.mid")
}
```
