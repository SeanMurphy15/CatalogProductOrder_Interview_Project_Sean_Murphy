import Foundation

precedencegroup Bonus {
    associativity: left
}

infix operator >>>: Bonus

// Implement this function
func >>> <A,B,C>(lhs: @escaping (A) -> B, rhs: @escaping(B) -> C) -> (A) -> C {
  fatalError()
}