//
//  Copyright © 2017 Apparata AB. All rights reserved.
//

import Foundation

public struct MIDIPreset {
    public let bank: (msb: UInt8, lsb: UInt8)
    public let program: UInt8
    
    public init(bank: (msb: UInt8, lsb: UInt8), program: UInt8) {
        self.bank = bank
        self.program = program
    }
}
