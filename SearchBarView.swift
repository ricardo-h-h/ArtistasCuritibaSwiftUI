import SwiftUI

struct SearchBarView: View {
    @Binding var texto: String // Binding para o texto de busca

    var body: some View {
        TextField("Buscar por Título ou Artista...", text: $texto)
            .padding(7)
            .padding(.horizontal, 25) // Espaço para o ícone da lupa
            .background(Color(.systemGray6)) // Cor de fundo padrão para search bars
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass") // SF Symbol para ícone de busca
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)

                    // Botão para limpar o texto de busca (aparece se texto não estiver vazio)
                    if !texto.isEmpty {
                        Button(action: {
                            self.texto = ""
                            // Esconde o teclado ao limpar
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }) {
                            Image(systemName: "multiply.circle.fill") // SF Symbol para limpar
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal) // Padding para a barra de busca em si
            .padding(.top) // Um pouco de espaço no topo
    }
}
