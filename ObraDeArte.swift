import Foundation

// Define a estrutura para uma obra de arte, conformando com Identifiable
// para que possa ser usada em listas SwiftUI que requerem identificação única,
// e Equatable para permitir que o SwiftUI detecte mudanças em arrays deste tipo para animações.
struct ObraDeArte: Identifiable, Equatable { // <--- ADICIONADO Equatable AQUI
    // Identificador único para cada obra, gerado automaticamente.
    // Necessário para ForEach em SwiftUI.
    let id = UUID()
    let titulo: String
    let artista: String
    let ano: Int
    let estilo: String
    // Nome do arquivo de imagem (que deve estar no Asset Catalog).
    let imagemNome: String
    let descricao: String

    // O Swift pode sintetizar automaticamente a conformidade com Equatable
    // porque todas as propriedades armazenadas (id, titulo, artista, etc.)
    // já são Equatable. Se você tivesse propriedades que não são Equatable,
    // você precisaria implementar a função 'static func == (lhs: Self, rhs: Self) -> Bool' manualmente.
}
