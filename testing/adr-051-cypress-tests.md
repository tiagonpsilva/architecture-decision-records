# ADR-051: Testes E2E com Cypress

## Status

Proposto

## Contexto

A necessidade de testes end-to-end (E2E) confiáveis e manuteníveis para nossas aplicações web requer uma ferramenta moderna que ofereça:
- Facilidade de escrita e manutenção
- Execução rápida e confiável
- Boa integração com CI/CD
- Suporte a aplicações modernas
- Boa documentação e comunidade ativa

O Cypress se apresenta como uma solução moderna que atende a esses requisitos.

## Decisão

Implementaremos o Cypress como nossa principal ferramenta de testes E2E:

### 1. Configuração Base
```typescript
// cypress.config.ts
import { defineConfig } from 'cypress'

export default defineConfig({
  e2e: {
    baseUrl: 'http://localhost:3000',
    viewportWidth: 1280,
    viewportHeight: 720,
    video: true,
    screenshotOnRunFailure: true,
    defaultCommandTimeout: 10000,
    retries: {
      runMode: 2,
      openMode: 0
    }
  },
  env: {
    apiUrl: 'http://localhost:8080',
    coverage: true
  }
})
```

### 2. Estrutura de Testes
```typescript
// support/commands.ts
Cypress.Commands.add('login', (email: string, password: string) => {
  cy.session([email, password], () => {
    cy.visit('/login')
    cy.get('[data-cy=email]').type(email)
    cy.get('[data-cy=password]').type(password)
    cy.get('[data-cy=submit]').click()
    cy.url().should('include', '/dashboard')
  })
})

// e2e/auth.spec.ts
describe('Autenticação', () => {
  beforeEach(() => {
    cy.visit('/login')
  })

  it('deve fazer login com sucesso', () => {
    cy.get('[data-cy=email]').type('user@example.com')
    cy.get('[data-cy=password]').type('password123')
    cy.get('[data-cy=submit]').click()
    cy.url().should('include', '/dashboard')
    cy.get('[data-cy=welcome]').should('contain', 'Bem-vindo')
  })

  it('deve mostrar erro com credenciais inválidas', () => {
    cy.get('[data-cy=email]').type('invalid@example.com')
    cy.get('[data-cy=password]').type('wrong')
    cy.get('[data-cy=submit]').click()
    cy.get('[data-cy=error]').should('be.visible')
  })
})
```

### 3. Padrões de Teste
```typescript
// support/e2e.ts
import './commands'

beforeEach(() => {
  cy.intercept('GET', '/api/health').as('healthCheck')
  cy.intercept('POST', '/api/login').as('login')
})

// plugins/index.ts
export default (on: Cypress.PluginEvents, config: Cypress.PluginConfigOptions) => {
  require('@cypress/code-coverage/task')(on, config)
  return config
}
```

### 4. CI/CD Integration
```yaml
# .github/workflows/cypress.yml
name: Cypress Tests
on: [push]
jobs:
  cypress:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: cypress-io/github-action@v4
        with:
          build: npm run build
          start: npm start
          wait-on: 'http://localhost:3000'
          record: true
        env:
          CYPRESS_RECORD_KEY: ${{ secrets.CYPRESS_RECORD_KEY }}
```

## Consequências

### Positivas
- Testes mais confiáveis e estáveis
- Melhor experiência de debugging
- Execução mais rápida que Selenium
- Boa integração com ferramentas modernas
- Screenshots e vídeos automáticos

### Negativas
- Limitado a testes em navegadores Chromium
- Maior consumo de recursos
- Necessidade de adaptação da equipe
- Possível complexidade em cenários específicos

## Riscos
- Testes flaky em CI/CD
- Custo de manutenção dos testes
- Dependência de seletores específicos
- Performance em suítes grandes

## Alternativas Consideradas
1. Selenium WebDriver
2. Playwright
3. TestCafe
4. Puppeteer
5. WebdriverIO

## Referências
- Cypress Documentation
- Testing JavaScript Applications
- Modern Frontend Testing with Cypress
- CI/CD Best Practices
- Web Testing Guide

## Notas
- Manter padrões de seletores data-cy
- Implementar relatórios detalhados
- Configurar retry em testes instáveis
- Manter documentação atualizada

## Exemplo de Configuração
```json
{
  "scripts": {
    "cy:open": "cypress open",
    "cy:run": "cypress run",
    "cy:ci": "cypress run --record --parallel",
    "test:e2e": "start-server-and-test start 3000 cy:run"
  },
  "devDependencies": {
    "cypress": "^12.0.0",
    "@cypress/code-coverage": "^3.10.0",
    "start-server-and-test": "^1.15.0"
  }
}
```

## Métricas de Avaliação
- Taxa de sucesso dos testes
- Tempo de execução da suíte
- Cobertura de testes E2E
- Número de testes flaky
- Tempo de manutenção dos testes 