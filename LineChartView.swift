import SwiftUI

struct LineChartView: View {

    let values: [Double]

    var body: some View {
        GeometryReader { geometry in
            if values.count > 1 {
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height

                    let maxValue = values.max() ?? 1
                    let minValue = values.min() ?? 0
                    let range = max(maxValue - minValue, 1)

                    for index in values.indices {
                        let x = width * CGFloat(index) / CGFloat(values.count - 1)
                        let y = height * (1 - CGFloat((values[index] - minValue) / range))

                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .stroke(Color.green, lineWidth: 2)
            } else {
                Text("Datos insuficientes")
                    .foregroundColor(.secondary)
            }
        }
    }
}
