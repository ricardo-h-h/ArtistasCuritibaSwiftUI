import SwiftUI

struct ObraGridItemView: View {
    let obra: ObraDeArte

    var body: some View {
        VStack(alignment: .leading) {
            Image(obra.imagemNome) // Carrega a imagem do Asset Catalog
                .resizable()
                .aspectRatio(1, contentMode: .fit) // Proporção 1:1, .fit para ver a imagem toda
                .frame(minHeight: 100) // Garante uma altura mínima para itens
                .background(Color.gray.opacity(0.1))
                .clipped()

            Text(obra.titulo)
                .font(.headline)
                .lineLimit(1)

            Text(obra.artista)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .padding([.leading, .trailing, .bottom], 8)
        .background(Color(.systemBackground)) // Adapta-se ao modo claro/escuro
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
        // A transição para a animação de filtragem
        .transition(.opacity.combined(with: .scale(scale: 0.9)))
    }
}
