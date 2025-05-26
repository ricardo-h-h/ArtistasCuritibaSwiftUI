import SwiftUI

struct GridItemScaleEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            // Aplica o efeito de escala quando o botão está pressionado.
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            // Anima a mudança na escala.
            // O 'value' garante que a animação ocorra apenas quando 'isPressed' muda.
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
