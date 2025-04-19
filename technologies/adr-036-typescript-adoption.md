# 036 - 📝 Adoção do TypeScript

Data: 2024-04-19

## ⚡ Status

Proposto

## 🎯 Contexto

Com o crescimento do projeto e a necessidade de manter um código mais robusto e confiável, identificamos a necessidade de uma linguagem que ofereça:

- Tipagem estática forte
- Melhor tooling e suporte de IDE
- Detecção precoce de erros
- Melhor manutenibilidade
- Documentação mais clara
- Consistência entre diferentes partes do sistema

## 🔨 Decisão

Adotar TypeScript como linguagem principal para desenvolvimento em todo o projeto, incluindo:

1. **Backend**
   - APIs REST/GraphQL
   - Microsserviços
   - Workers e Jobs
   - Scripts de automação
   - Ferramentas CLI

2. **Frontend**
   - Aplicações React
   - Componentes reutilizáveis
   - Bibliotecas utilitárias
   - Testes E2E

3. **Shared**
   - DTOs
   - Tipos comuns
   - Validadores
   - Utilitários
   - Configurações

4. **Configurações**
   - Strict mode habilitado
   - ESLint com regras TypeScript
   - Prettier integrado
   - Path aliases
   - Module resolution

5. **Práticas**
   - Type-first development
   - Interface segregation
   - Generics quando apropriado
   - Utility types
   - Type guards

6. **Tooling**
   - TSConfig base compartilhada
   - Build tools otimizadas
   - Hot reload
   - Type checking em CI
   - VSCode extensions

## 📊 Consequências

### Positivas

- Código mais seguro e confiável
- Melhor DX (Developer Experience)
- Documentação através de tipos
- Refatoração mais segura
- Menos bugs em produção
- Melhor intellisense

### Negativas

- Curva de aprendizado inicial
- Setup mais complexo
- Tempo de compilação
- Arquivos de definição (.d.ts)
- Boilerplate adicional

### Riscos

- Complexidade excessiva de tipos
  - Mitigação: Guidelines claros e code reviews
- Performance de build
  - Mitigação: Otimizações e caching
- Resistência da equipe
  - Mitigação: Treinamento e documentação

## 🔄 Alternativas Consideradas

### JavaScript + JSDoc
- Prós: Sem compilação necessária
- Contras: Menos robusto, mais verboso

### Flow
- Prós: Mais leve que TypeScript
- Contras: Comunidade menor, menos recursos

### ReasonML/OCaml
- Prós: Sistema de tipos mais poderoso
- Contras: Ecossistema limitado, curva de aprendizado maior

## 📚 Referências

- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
- [Clean Code TypeScript](https://github.com/labs42io/clean-code-typescript)
- [TypeScript Deep Dive](https://basarat.gitbook.io/typescript/)
- [Effective TypeScript](https://effectivetypescript.com/)

## 📝 Notas

- Implementar gradualmente
- Criar guias de estilo
- Estabelecer padrões de código
- Manter templates atualizados
- Revisar configurações periodicamente

## 🎨 Exemplo de Configuração

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "lib": ["DOM", "DOM.Iterable", "ESNext"],
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@shared/*": ["shared/*"],
      "@tests/*": ["tests/*"]
    },
    "types": ["node", "jest", "cypress"],
    "incremental": true
  },
  "include": ["src", "tests", "shared"],
  "exclude": ["node_modules", "build", "dist"]
}
```

## 🔍 Métricas de Avaliação

1. **Qualidade**
   - Type coverage
   - Erros em runtime
   - Complexidade de tipos
   - Reusabilidade

2. **Produtividade**
   - Tempo de desenvolvimento
   - Tempo de build
   - Facilidade de refatoração
   - Onboarding time

3. **Manutenção**
   - Número de bugs
   - Tempo de debug
   - Clareza do código
   - Documentação 