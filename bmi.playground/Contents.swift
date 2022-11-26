import UIKit

func bmi(_ weight: Int, _ height: Double) -> String {
    let bmi = Double(weight) / pow(height, 2)
    switch bmi {
      case ...18.5:
      return "Underweight"
      case 18.5...25:
      return "Normal"
      case 25...30:
      return "Overweight"
      default:
      return "Obese"
    }
}
bmi(55, 1.71)

