# ADR-036 - 📝 Padronização de Mensagens de Commit

Data: 2024-04-19

## ⚡ Status

Proposto

## 🎯 Contexto

Para melhorar a rastreabilidade, automação e compreensão das mudanças no código, precisamos padronizar as mensagens de commit usando o padrão Conventional Commits, considerando:
- Automação de CHANGELOG
- Versionamento semântico
- Clareza nas mudanças
- Integração com ferramentas
- Histórico organizado

## 🔨 Decisão

Adotar o padrão Conventional Commits com a seguinte estrutura:

### Formato Base
```
<tipo>[escopo opcional]: <descrição>

[corpo opcional]

[rodapé(s) opcional(is)]
```

### Tipos Principais
1. feat
   - Novas funcionalidades
   - Incrementa versão minor (1.x.0)
   - Exemplo: `feat(auth): adiciona login com Google`

2. fix
   - Correções de bugs
   - Incrementa versão patch (1.0.x)
   - Exemplo: `fix(api): corrige timeout em requisições longas`

### Tipos Adicionais
- chore: Manutenção de código
- docs: Documentação
- style: Formatação
- refactor: Refatoração
- perf: Performance
- test: Testes
- build: Build
- ci: Integração Contínua

### Regras
1. Primeira linha máximo 72 caracteres
2. Descrição sempre em português
3. Usar verbos no imperativo
4. Escopo em minúsculo
5. Sem ponto final
6. Breaking changes marcados com !

### Exemplos
```
feat(auth): adiciona autenticação OAuth

- Implementa fluxo completo OAuth2
- Adiciona endpoints de callback
- Integra com provedor externo

BREAKING CHANGE: nova estrutura de tokens
```

```
fix(api): corrige validação de entrada

Resolve o bug #123 onde inputs especiais causavam erro 500
```

## 📊 Consequências

### Positivas
- Histórico claro e organizado
- Geração automática de CHANGELOG
- Versionamento consistente
- Facilita code review
- Melhor rastreabilidade
- Automação simplificada
- Documentação implícita

### Negativas
- Curva de aprendizado inicial
- Overhead na escrita de commits
- Possível resistência do time
- Necessidade de ferramentas adicionais
- Commits mais demorados

### Riscos
- Commits mal formatados
  - Mitigação: Hooks de git e linters
- Complexidade excessiva
  - Mitigação: Guias e templates
- Inconsistência entre times
  - Mitigação: Automação e revisão

## 🔄 Alternativas Consideradas

### Commits Livres
- Prós: Mais simples e rápido
- Contras: Difícil manutenção e automação

### Outros Padrões
- Prós: Diferentes abordagens
- Contras: Menor adoção e ferramentas

### Gitmoji
- Prós: Visual e intuitivo
- Contras: Menos formal e profissional

## 📚 Referências

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Angular Commit Guidelines](https://github.com/angular/angular/blob/master/CONTRIBUTING.md#commit)
- [Semantic Versioning](https://semver.org/)
- [Commitlint](https://commitlint.js.org/)
- [Commitizen](https://commitizen.github.io/cz-cli/)

## 📝 Notas

- Configurar commitlint
- Criar templates de commit
- Implementar hooks de git
- Treinar equipe
- Automatizar CHANGELOG 