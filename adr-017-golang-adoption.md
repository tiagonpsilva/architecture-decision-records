# 017 - Adoção de Go para Microsserviços 🦫

Data: 2024-03-21

## Status 📊

Aceito

## Contexto 🔍

Precisamos de uma linguagem que ofereça:
- Alta performance
- Baixo consumo de recursos
- Concorrência eficiente
- Compilação nativa
- Ferramentas robustas
- Deploy simplificado
- Manutenibilidade
- Curva de aprendizado razoável

## Decisão ✅

Adotar Go como linguagem principal para microsserviços de alta performance:

Princípios:
- Simplicidade sobre complexidade
- Concorrência via goroutines
- Código explícito sobre mágica
- Ferramentas padrão da linguagem
- Compilação estática
- Deploy como binário único
- Testes integrados

Padrões específicos:
- Clean Architecture em Go:
  - cmd/: pontos de entrada
  - internal/: código privado
  - pkg/: código público
  - api/: contratos de API
  - docs/: documentação

- Práticas:
  - Interfaces pequenas
  - Dependency injection
  - Error handling explícito
  - Context para cancelamento
  - Graceful shutdown
  - Métricas built-in

Frameworks e Bibliotecas:
- Gin/Chi para HTTP
- sqlx para banco de dados
- zap para logging
- prometheus para métricas
- testify para testes
- wire para DI
- migrate para migrations

## Consequências 📈

### Positivas ✨

- Performance excepcional
- Baixo footprint de memória
- Deployments simples
- Tooling nativo forte
- Código consistente (gofmt)
- Compilação rápida
- Documentação clara
- Garbage collection eficiente

### Negativas ⚠️

- Menos abstrações de alto nível
- Repetição de código (sem generics)
- Ecosystem menor vs Java/Node
- Necessidade de convenções claras
- Curva inicial para devs OOP

### Riscos 🚨

- Resistência da equipe
  - Mitigação: Treinamento e mentoria
- Código não idiomático
  - Mitigação: Code reviews, linters
- Complexidade em DDD
  - Mitigação: Padrões claros, exemplos

## Alternativas Consideradas 🔄

### Java/Spring
- Prós: Ecossistema maduro, ferramentas
- Contras: Overhead de recursos, startup

### Node.js
- Prós: Familiar, grande ecosystem
- Contras: Performance, tipagem opcional

### Rust
- Prós: Performance, segurança
- Contras: Complexidade, curva de aprendizado

## Referências 📚

- [Go Documentation](https://golang.org/doc/)
- [Effective Go](https://golang.org/doc/effective_go)
- [Clean Architecture in Go](https://www.youtube.com/watch?v=MzTcsI6tn-0)
- [Go Patterns](https://github.com/tmrts/go-patterns)

## Notas 📝

- Criar guias de estilo Go
- Estabelecer padrões de projeto
- Definir estrutura base
- Documentar práticas comuns
- Implementar CI/CD específico
- Treinar equipe em Go 