import Foundation
import SwiftUI

// Classe que gerencia a coleção de obras de arte.
// Conforma com ObservableObject para que as views SwiftUI possam se inscrever em suas alterações.
class ObraStore: ObservableObject {

    // A anotação @Published faz com que qualquer view que observa esta propriedade
    // seja atualizada automaticamente quando a propriedade 'obras' mudar.
    @Published var obras: [ObraDeArte] = []

    // Propriedade para armazenar as obras após a filtragem.
    // A interface do usuário observará esta propriedade.
    @Published var obrasFiltradas: [ObraDeArte] = []

    // Inicializador que carrega os dados das obras.
    init() {
        carregarObras()
        // Inicializa obrasFiltradas com todas as obras ao carregar.
        self.obrasFiltradas = self.obras
    }

    // Método para carregar a lista de obras de arte.
    private func carregarObras() {
        self.obras = [
            ObraDeArte(titulo: "Luar do Sertão", artista: "João Turin", ano: 1947, estilo: "Escultura",
                        imagemNome: "turin_luar",
                        descricao: "Escultura em bronze premiada no Salão Nacional de Belas Artes (1947). Turin, um dos expoentes do Paranismo, especializou-se na Bélgica e foi mestre em retratar a fauna e figuras regionais."),
            ObraDeArte(titulo: "O Largo da Ordem", artista: "Poty Lazzarotto", ano: 1993, estilo: "Mural (Azulejo)",
                        imagemNome: "poty_largodaordem",
                        descricao: "Mural em azulejos na Tv. Nestor de Castro que evoca a memória da Curitiba antiga. Poty foi um artista versátil, conhecido por seus painéis públicos e ilustrações."),
            ObraDeArte(titulo: "Porto de Paranaguá", artista: "Alfredo Andersen", ano: 1908, estilo: "Pintura",
                        imagemNome: "andersen_porto",
                        descricao: "Pintura a óleo do norueguês radicado em Curitiba, considerado o 'Pai da Pintura Paranaense'. Sua obra combina realismo com influências impressionistas."),
            ObraDeArte(titulo: "Árvore Amarela", artista: "Miguel Bakun", ano: 1950, estilo: "Pintura",
                        imagemNome: "bakun_arvore_amarela",
                        descricao: "Obra significativa de Bakun, pioneiro da arte moderna no Paraná. Sua pintura possui acentos pós-impressionistas e expressionistas. Acervo MON."),
            ObraDeArte(titulo: "Auto-retrato", artista: "Guido Viaro", ano: 1934, estilo: "Pintura",
                        imagemNome: "viaro_autoretrato_1934",
                        descricao: "Autorretrato (óleo sobre tela) de Viaro, figura central na renovação da pintura moderna no Paraná e professor na Escola de Música e Belas Artes do Paraná (EMBAP)."),
            ObraDeArte(titulo: "Paisagem de Morretes", artista: "Theodoro de Bona", ano: 1969, estilo: "Pintura",
                        imagemNome: "bona_morretes",
                        descricao: "Pintura a óleo de paisagem da cidade litorânea. Nascido em Morretes, De Bona foi aluno de Andersen e também um importante professor."),
            ObraDeArte(titulo: "Boiadas", artista: "Arthur Nísio", ano: 1960, estilo: "Pintura",
                        imagemNome: "nisio_boiadas",
                        descricao: "Pintura retratando cena rural/animal. Nísio estudou na Alemanha, especializando-se em pintura de animais, e é considerado um dos modernistas paranaenses."),
            ObraDeArte(titulo: "Marumbi", artista: "João Turin", ano: 1925, estilo: "Escultura",
                        imagemNome: "turin_marumbi",
                        descricao: "Escultura monumental de duas onças em luta, símbolo do Paranismo. O contorno da obra remete ao Pico Marumbi. Destaque no Memorial Paranista."),
            ObraDeArte(titulo: "Monumento 1º Centenário PR", artista: "Poty Lazzarotto", ano: 1953, estilo: "Mural (Azulejo)",
                        imagemNome: "poty_centenario",
                        descricao: "Primeiro mural de Poty em Curitiba (Praça 19 de Dezembro), feito em parceria com Erbo Stenzel e Humberto Cozzo para comemorar o centenário da emancipação política do Paraná."),
            ObraDeArte(titulo: "Casarios e Favelas", artista: "Domício Pedroso", ano: 1970, estilo: "Pintura",
                        imagemNome: "pedroso_casario",
                        descricao: "Obra que explora a 'tessitura urbana', tema recorrente do artista. Pedroso estudou com Viaro e foi pioneiro na serigrafia artística no Paraná.")
        ]
    }

    // Método para filtrar as obras com base em um termo de busca.
    func filtrarObras(comTermo termo: String) {
        if termo.isEmpty {
            // Se o termo de busca estiver vazio, exibe todas as obras.
            obrasFiltradas = obras
        } else {
            // Caso contrário, filtra as obras cujo título ou nome do artista
            // contenha o termo de busca (ignorando maiúsculas/minúsculas).
            let termoLowercased = termo.lowercased()
            obrasFiltradas = obras.filter { obra in
                let tituloMatch = obra.titulo.lowercased().contains(termoLowercased)
                let artistaMatch = obra.artista.lowercased().contains(termoLowercased)
                return tituloMatch || artistaMatch
            }
        }
    }
}
