import SwiftUI

@main
struct MandelbrotApp: App {
    var body: some Scene {
        WindowGroup {
            MandelbrotView()
        }
    }
}

struct MandelbrotView: View {
    @State private var zoom: Double = 1.0
    @State private var offsetX: Double = 0.0
    @State private var offsetY: Double = 0.0

    var body: some View {
        if #available(macOS 12.0, *) {
            MandelbrotCanvas(zoom: zoom, offsetX: offsetX, offsetY: offsetY)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                        print("Magnification value:", value)
                            zoom = max(0.1, value)
                        }
                )
                .frame(width: 600, height: 600)
        } else {
            Text("Mandelbrot nécessite macOS 12.0 ou supérieur.")
                .frame(width: 600, height: 600)
        }
    }
}

@available(macOS 12.0, *)
struct MandelbrotCanvas: View {
    let zoom: Double
    let offsetX: Double
    let offsetY: Double

    var body: some View {
        Canvas { context, size in
            let width = Int(size.width)
            let height = Int(size.height)

            for x in 0..<width {
                for y in 0..<height {
                    let cx = (Double(x) - Double(width)/2.0)/zoom/200 + offsetX
                    let cy = (Double(y) - Double(height)/2.0)/zoom/200 + offsetY
                    let color = mandelbrotColor(cx: cx, cy: cy)
                    context.fill(Path(CGRect(x: x, y: y, width: 1, height: 1)), with: .color(color))
                }
            }
        }
    }

    func mandelbrotColor(cx: Double, cy: Double) -> Color {
        var x = 0.0
        var y = 0.0
        var iteration = 0
        let maxIteration = 100

        while x*x + y*y <= 4 && iteration < maxIteration {
            let xtemp = x*x - y*y + cx
            y = 2*x*y + cy
            x = xtemp
            iteration += 1
        }

        let t = Double(iteration) / Double(maxIteration)
        return Color(hue: t, saturation: 1, brightness: t < 1 ? 1 : 0)
    }
}
