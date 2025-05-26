import SwiftUI
import UIKit

// MARK: - ActivityView

/// "ActivityView" é uma estrutura que encapsula "UIActivityViewController" para ser utilizada em SwiftUI.
/// Ela permite apresentar a folha de compartilhamento padrão do iOS (Share Sheet).
struct ActivityView: UIViewControllerRepresentable {
    // MARK: - Propriedades

    /// Os itens que serão compartilhados. Podem ser texto, imagens, URLs, etc.
    var activityItems: [Any]

    /// Atividades customizadas de aplicativo que podem ser adicionadas à folha de compartilhamento.
    /// Opcional, geralmente `nil` se apenas atividades padrão do sistema são desejadas.
    var applicationActivities: [UIActivity]? = nil

    /// Callback opcional executado quando a folha de compartilhamento é dispensada.
    /// Fornece informações sobre a atividade selecionada, se foi completada, os itens retornados e possíveis erros.
    var onComplete: ((UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void)? = nil

    // MARK: - Métodos UIViewControllerRepresentable

    /// Cria a instância de `UIActivityViewController` que será gerenciada pelo SwiftUI.
    /// Este método é chamado uma vez quando a view precisa ser criada.
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        // Define o handler de conclusão para executar o callback fornecido.
        controller.completionWithItemsHandler = onComplete
        return controller
    }

    /// Atualiza a "UIActivityViewController" apresentada quando o estado do SwiftUI muda.
    /// Para "UIActivityViewController", geralmente não são necessárias atualizações complexas aqui,
    /// pois a view é apresentada modalmente com dados definidos na sua criação.
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Nenhuma atualização específica é necessária para este caso de uso simples.
        // Se "activityItems" ou "applicationActivities" fossem alterados dinamicamente
        // enquanto a sheet estivesse visível (o que não é o comportamento padrão),
        // lógica de atualização poderia ser implementada aqui.
    }
}