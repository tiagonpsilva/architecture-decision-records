# ADR-037 - 🏷️ Tags Git para SEMVER

Data: 2024-04-19

## ⚡ Status

Proposto

## 🎯 Contexto

Para gerenciar efetivamente o versionamento das aplicações e garantir compatibilidade, precisamos estabelecer um padrão de uso de tags Git alinhado com Semantic Versioning (SEMVER), considerando:
- Releases previsíveis
- Compatibilidade entre versões
- Automação de deployment
- Rastreabilidade de mudanças
- Integração com CI/CD

## 🔨 Decisão

Adotar um padrão de tags Git seguindo SEMVER com as seguintes características:

### Formato de Tags
```
v<major>.<minor>.<patch>[-<pre-release>][+<build>]
```

### Componentes
1. Major (v1.0.0)
   - Breaking changes
   - Incompatibilidade com versões anteriores
   - Exemplo: `v2.0.0`

2. Minor (v1.1.0)
   - Novas funcionalidades compatíveis
   - Exemplo: `v1.2.0`

3. Patch (v1.0.1)
   - Correções de bugs
   - Exemplo: `v1.0.5`

4. Pre-release
   - alpha: Desenvolvimento inicial
   - beta: Testes externos
   - rc: Release candidate
   - Exemplo: `v1.0.0-beta.1`

5. Build
   - Metadados de build
   - Exemplo: `v1.0.0+20240419`

### Regras
1. Tags sempre prefixadas com 'v'
2. Números incrementais sem zeros à esquerda
3. Pre-release em ordem alfabética
4. Build apenas com caracteres seguros
5. Tags assinadas (git tag -s)

### Workflow
1. Desenvolvimento em branches
2. Merge para main/master
3. Criação de tag
4. Push da tag
5. CI/CD baseado em tags

### Exemplos
```bash
# Major release
git tag -a v2.0.0 -m "Segunda versão major"

# Minor com feature
git tag -a v1.1.0 -m "Nova funcionalidade X"

# Patch com fix
git tag -a v1.0.1 -m "Correção do bug Y"

# Beta release
git tag -a v1.0.0-beta.1 -m "Primeira beta"
```

## 📊 Consequências

### Positivas
- Versionamento previsível
- Compatibilidade clara
- Automação facilitada
- Deployment controlado
- Rollback simplificado
- Histórico organizado
- Releases documentadas

### Negativas
- Overhead de gerenciamento
- Necessidade de disciplina
- Complexidade adicional
- Processo mais formal
- Mais etapas no release

### Riscos
- Tags incorretas
  - Mitigação: Scripts de validação
- Conflitos de versão
  - Mitigação: Processo automatizado
- Esquecimento de tags
  - Mitigação: Hooks e CI/CD

## 🔄 Alternativas Consideradas

### Apenas Branches
- Prós: Mais simples
- Contras: Menos controle de versão

### Data como Versão
- Prós: Automático e único
- Contras: Não indica compatibilidade

### Hash do Commit
- Prós: Único e preciso
- Contras: Não indica evolução

## 📚 Referências

- [Semantic Versioning 2.0.0](https://semver.org/)
- [Git Tags](https://git-scm.com/book/en/v2/Git-Basics-Tagging)
- [npm semver](https://docs.npmjs.com/cli/v6/using-npm/semver)
- [Release Management](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases)

## 📝 Notas

- Criar scripts de automação
- Documentar processo de release
- Configurar CI/CD
- Treinar equipe
- Implementar validações 