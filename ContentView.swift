import SwiftUI

struct ContentView: View {
    // @StateObject garante que o ObraStore seja criado uma vez e mantido vivo
    // durante o ciclo de vida desta view e suas filhas que o observarem.
    @StateObject var obraStore = ObraStore()

    // @State para armazenar o texto de busca digitado pelo usuário.
    @State private var textoBusca: String = ""

    // Define as colunas para o LazyVGrid.
    // .adaptive fará com que o grid crie quantas colunas couberem,
    // desde que cada uma tenha no mínimo 150 pontos de largura.
    let colunas: [GridItem] = [
        GridItem(.adaptive(minimum: 150), spacing: 15) // spacing é o espaçamento horizontal entre itens na mesma linha
    ]

    var body: some View {
        NavigationView {
            VStack { // VStack principal para incluir a barra de busca e o ScrollView
                // Usando a SearchBarView extraída
                SearchBarView(texto: $textoBusca)

                ScrollView {
                    LazyVGrid(columns: colunas, spacing: 20) { // spacing aqui é o vertical entre linhas
                        // Agora itera sobre 'obraStore.obrasFiltradas'.
                        ForEach(obraStore.obrasFiltradas) { obra in
                            NavigationLink(destination: DetalhesObraView(obra: obra)) {
                                // Usando a ObraGridItemView extraída
                                ObraGridItemView(obra: obra)
                            }
                            // Aplicando o estilo de botão personalizado para efeito de clique
                            .buttonStyle(GridItemScaleEffectButtonStyle())
                        }
                    }
                    .padding()
                    // Adiciona uma animação para quando 'obrasFiltradas' mudar.
                    .animation(.easeInOut(duration: 0.3), value: obraStore.obrasFiltradas)
                }
            }
            .navigationTitle("Artistas Curitibanos")
            // Observa mudanças no 'textoBusca' e chama o método de filtragem do store.
            .onChange(of: textoBusca) { novoValor in
                obraStore.filtrarObras(comTermo: novoValor)
            }
            // Oculta o teclado quando o usuário toca fora da searchbar (na área do VStack/ScrollView)
            .onTapGesture {
                 UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        // Força o estilo de navegação em pilha para consistência entre iPhone e iPad,
        // evitando o comportamento de split-view padrão no iPad.
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// Preview para o Xcode Canvas
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            // Exemplo de como testar em um preview de iPad:
            // .previewDevice("iPad Pro (12.9-inch) (6th generation)")
            // .navigationViewStyle(StackNavigationViewStyle()) // Adicione aqui se o preview não pegar do corpo da view

            // Exemplo de preview para iPhone:
            // .previewDevice("iPhone 15 Pro Max")
    }
}
#endif
