import Foundation

/// Note that the bank is a 14-bit number, and msb is the upper 7 bits,
/// and lsb is the lower 7 bits, but it seems like for SF2 sound fonts
/// the msb is the lower 7 bits and the lsb is the upper 7 bits, for some reason.
public struct MIDIPreset {
    public let bank: (msb: UInt8, lsb: UInt8)
    public let program: UInt8
    
    public init(bank: (msb: UInt8, lsb: UInt8), program: UInt8) {
        self.bank = bank
        self.program = program
    }
}
