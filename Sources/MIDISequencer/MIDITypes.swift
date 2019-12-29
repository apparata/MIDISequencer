//
//  Copyright © 2017 Apparata AB. All rights reserved.
//

import Foundation

/// The duration of 1.0 beat = 60.0 / BPM
public typealias MIDIBeat = Float64

public typealias MIDIBeatsPerMinute = Float

/// Duration of a note expressed in beats (assuming 4/4 time signature).
public enum MIDINoteDuration: MIDIBeat {
    case whole = 4.0
    case half = 2.0
    case quarterDotted = 1.5
    case quarter = 1.0
    case eighth = 0.5
    case sixteenth = 0.25
}

public enum MIDIError: Swift.Error {
    case failedToCreateSequence(errorCode: OSStatus)
    case failedToSaveSequence(errorCode: OSStatus)
    case failedToSerializeSequence(errorCode: OSStatus)
    case failedToCreateTrack(errorCode: OSStatus)
}

// Middle C is represented as C4 (or 60)
private let MIDINoteNames: [MIDINoteName] = [
    .CM1, .C﹟M1, .DM1, .D﹟M1, .EM1, .FM1, .F﹟M1, .GM1, .G﹟M1, .AM1, .A﹟M1, .BM1,
    .C0, .C﹟0, .D0, .D﹟0, .E0, .F0, .F﹟0, .G0, .G﹟0, .A0, .A﹟0, .B0,
    .C1, .C﹟1, .D1, .D﹟1, .E1, .F1, .F﹟1, .G1, .G﹟1, .A1, .A﹟1, .B1,
    .C2, .C﹟2, .D2, .D﹟2, .E2, .F2, .F﹟2, .G2, .G﹟2, .A2, .A﹟2, .B2,
    .C3, .C﹟3, .D3, .D﹟3, .E3, .F3, .F﹟3, .G3, .G﹟3, .A3, .A﹟3, .B3,
    .C4, .C﹟4, .D4, .D﹟4, .E4, .F4, .F﹟4, .G4, .G﹟4, .A4, .A﹟4, .B4,
    .C5, .C﹟5, .D5, .D﹟5, .E5, .F5, .F﹟5, .G5, .G﹟5, .A5, .A﹟5, .B5,
    .C6, .C﹟6, .D6, .D﹟6, .E6, .F6, .F﹟6, .G6, .G﹟6, .A6, .A﹟6, .B6,
    .C7, .C﹟7, .D7, .D﹟7, .E7, .F7, .F﹟7, .G7, .G﹟7, .A7, .A﹟7, .B7,
    .C8, .C﹟8, .D8, .D﹟8, .E8, .F8, .F﹟8, .G8, .G﹟8, .A8, .A﹟8, .B8,
    .C9, .C﹟9, .D9, .D﹟9, .E9, .F9, .F﹟9, .G9,
]

public enum MIDINoteName: String {
    
    public var value: UInt8 {
        return UInt8(MIDINoteNames.firstIndex(of: self) ?? 0)
    }
    
    // Octave -1
    case CM1 = "C-1"
    case C﹟M1 = "C#-1"
    case DM1 = "D-1"
    case D﹟M1 = "D#-1"
    case EM1 = "E-1"
    case FM1 = "F-1"
    case F﹟M1 = "F#-1"
    case GM1 = "G-1"
    case G﹟M1 = "G#-1"
    case AM1 = "A-1"
    case A﹟M1 = "A#-1"
    case BM1 = "B-1"

    // Octave 0
    case C0 = "C0"
    case C﹟0 = "C#0"
    case D0 = "D0"
    case D﹟0 = "D#0"
    case E0 = "E0"
    case F0 = "F0"
    case F﹟0 = "F#0"
    case G0 = "G0"
    case G﹟0 = "G#0"
    case A0 = "A0"
    case A﹟0 = "A#0"
    case B0 = "B0"

    // Octave 1
    case C1 = "C1"
    case C﹟1 = "C#1"
    case D1 = "D1"
    case D﹟1 = "D#1"
    case E1 = "E1"
    case F1 = "F1"
    case F﹟1 = "F#1"
    case G1 = "G1"
    case G﹟1 = "G#1"
    case A1 = "A1"
    case A﹟1 = "A#1"
    case B1 = "B1"

    // Octave 2
    case C2 = "C2"
    case C﹟2 = "C#2"
    case D2 = "D2"
    case D﹟2 = "D#2"
    case E2 = "E2"
    case F2 = "F2"
    case F﹟2 = "F#2"
    case G2 = "G2"
    case G﹟2 = "G#2"
    case A2 = "A2"
    case A﹟2 = "A#2"
    case B2 = "B2"

    // Octave 3
    case C3 = "C3"
    case C﹟3 = "C#3"
    case D3 = "D3"
    case D﹟3 = "D#3"
    case E3 = "E3"
    case F3 = "F3"
    case F﹟3 = "F#3"
    case G3 = "G3"
    case G﹟3 = "G#3"
    case A3 = "A3"
    case A﹟3 = "A#3"
    case B3 = "B3"

    // Octave 4
    case C4 = "C4"
    case C﹟4 = "C#4"
    case D4 = "D4"
    case D﹟4 = "D#4"
    case E4 = "E4"
    case F4 = "F4"
    case F﹟4 = "F#4"
    case G4 = "G4"
    case G﹟4 = "G#4"
    case A4 = "A4"
    case A﹟4 = "A#4"
    case B4 = "B4"

    // Octave 5
    case C5 = "C5"
    case C﹟5 = "C#5"
    case D5 = "D5"
    case D﹟5 = "D#5"
    case E5 = "E5"
    case F5 = "F5"
    case F﹟5 = "F#5"
    case G5 = "G5"
    case G﹟5 = "G#5"
    case A5 = "A5"
    case A﹟5 = "A#5"
    case B5 = "B5"

    // Octave 6
    case C6 = "C6"
    case C﹟6 = "C#6"
    case D6 = "D6"
    case D﹟6 = "D#6"
    case E6 = "E6"
    case F6 = "F6"
    case F﹟6 = "F#6"
    case G6 = "G6"
    case G﹟6 = "G#6"
    case A6 = "A6"
    case A﹟6 = "A#6"
    case B6 = "B6"

    // Octave 7
    case C7 = "C7"
    case C﹟7 = "C#7"
    case D7 = "D7"
    case D﹟7 = "D#7"
    case E7 = "E7"
    case F7 = "F7"
    case F﹟7 = "F#7"
    case G7 = "G7"
    case G﹟7 = "G#7"
    case A7 = "A7"
    case A﹟7 = "A#7"
    case B7 = "B7"

    // Octave 8
    case C8 = "C8"
    case C﹟8 = "C#8"
    case D8 = "D8"
    case D﹟8 = "D#8"
    case E8 = "E8"
    case F8 = "F8"
    case F﹟8 = "F#8"
    case G8 = "G8"
    case G﹟8 = "G#8"
    case A8 = "A8"
    case A﹟8 = "A#8"
    case B8 = "B8"

    // Octave 9
    case C9 = "C9"
    case C﹟9 = "C#9"
    case D9 = "D9"
    case D﹟9 = "D#9"
    case E9 = "E9"
    case F9 = "F9"
    case F﹟9 = "F#9"
    case G9 = "G9"
    
    // MIDI range ends here.
    
}
