#!/usr/bin/env swift

import Foundation

let width = 80
let height = 40
let maxIter = 100

for y in 0..<height {
    for x in 0..<width {
        let cx = (Double(x) - Double(width)/2.0) / 20.0
        let cy = (Double(y) - Double(height)/2.0) / 20.0

        var zx = 0.0
        var zy = 0.0
        var iter = 0

        while zx*zx + zy*zy < 4 && iter < maxIter {
            let xtemp = zx*zx - zy*zy + cx
            zy = 2 * zx * zy + cy
            zx = xtemp
            iter += 1
        }

//        let char = iter == maxIter ? "#" : " .:-=+*%@#"[iter % 10]
        let chars: [Character] = Array(" .:-=+*%@#")
        let char = iter == maxIter ? "#" : chars[iter % chars.count]
        print(char, terminator: "")
    }
    print("")
}
