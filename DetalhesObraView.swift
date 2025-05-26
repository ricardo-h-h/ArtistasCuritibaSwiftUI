import SwiftUI

struct DetalhesObraView: View {
    let obra: ObraDeArte
    @State private var appeared: Bool = false

    // Estado para controlar a apresentação da folha de compartilhamento
    @State private var isShareSheetShowing: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Image(obra.imagemNome)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x:0, y:2)
                    .padding(.bottom, 10)

                Text(obra.titulo)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fixedSize(horizontal: false, vertical: true)

                HStack {
                    Text(obra.artista)
                        .font(.title2)
                        .fontWeight(.medium)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    Text("Ano: \(String(obra.ano))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Text("Estilo: \(obra.estilo)")
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)

                Divider()
                    .padding(.vertical, 5)

                Text("Descrição")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5)

                Text(obra.descricao)
                    .font(.body)
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer() // Adicionado para empurrar o conteúdo para cima se for curto
            }
            .padding()
            .opacity(appeared ? 1 : 0)
            .onAppear {
                withAnimation(.easeIn(duration: 0.5)) {
                    appeared = true
                }
            }
        }
        .navigationTitle(obra.titulo)
        .navigationBarTitleDisplayMode(.inline)
        // Adiciona um botão de compartilhar à barra de navegação
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.isShareSheetShowing = true
                } label: {
                    Image(systemName: "square.and.arrow.up") // SF Symbol para compartilhar
                }
            }
        }
        // Apresenta a ActivityView como uma folha (sheet)
        .sheet(isPresented: $isShareSheetShowing) {
            let shareText = "Confira esta obra de \(obra.artista): \"\(obra.titulo)\". \nDetalhes: \(obra.descricao.prefix(100))..." // Limita a descrição
            // Para compartilhar a imagem também (opcional):
            // let imageToShare = UIImage(named: obra.imagemNome)
            // var itemsToShare: [Any] = [shareText]
            // if let image = imageToShare { itemsToShare.append(image) }
            // ActivityView(activityItems: itemsToShare)
            
            ActivityView(activityItems: [shareText]) { activityType, completed, returnedItems, error in
                // Este callback é opcional. Você pode usá-lo para saber se o compartilhamento
                // foi concluído ou se houve um erro.
                print("Compartilhamento concluído: \(completed), tipo: \(activityType?.rawValue ?? "N/A")")
                if let error = error {
                    print("Erro ao compartilhar: \(error.localizedDescription)")
                }
                // Garante que a folha seja dispensada.
                self.isShareSheetShowing = false
            }
        }
    }
}

// Preview (permanece o mesmo)
struct DetalhesObraView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetalhesObraView(obra: ObraStore().obras.first ?? ObraDeArte(
                titulo: "Obra de Exemplo Longo Para Testar Quebra de Linha no Título Principal",
                artista: "Artista Exemplo Com Nome Também Comprido Para Avaliar Layout",
                ano: 2025,
                estilo: "Estilo Exemplo Para Ver Como Fica",
                imagemNome: "photo",
                descricao: "Esta é uma descrição de exemplo para a obra de arte..."
            ))
        }
    }
}
