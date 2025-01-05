import SwiftUI

struct ActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(configuration.isPressed ? Color.gray.opacity(0.2) : Color.accentColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

extension Button {
    func actionButton() -> some View {
        self.buttonStyle(ActionButtonStyle())
    }
}
