# 019 - Adoção do Padrão 12-Factor App 🏭

Data: 2024-03-21

## Status 📊

Aceito

## Contexto 🔍

Com a arquitetura de microsserviços, precisamos:
- Garantir consistência entre aplicações
- Facilitar operações em nuvem
- Maximizar portabilidade
- Permitir escalabilidade
- Habilitar entrega contínua
- Minimizar divergências dev/prod
- Manter observabilidade

## Decisão ✅

Adotar os princípios do 12-Factor App como base para desenvolvimento:

### 1. Base de Código
- Um repositório por serviço
- Branches para features
- Trunk-based development
- Versionamento semântico

### 2. Dependências
- Declaração explícita
- Isolamento de dependências
- Uso de lockfiles
- Sem dependências do sistema

### 3. Configurações
- Variáveis de ambiente
- Sem configs no código
- Secrets em vault
- Configs por ambiente

### 4. Backing Services
- Tratados como recursos anexados
- Conexões via URLs/endpoints
- Intercambiáveis por ambiente
- Circuit breakers

### 5. Build, Release, Run
- Estágios separados
- Builds imutáveis
- Releases versionadas
- Rollback possível

### 6. Processos
- Stateless
- Sem estado compartilhado
- Cache distribuído
- Sessões externalizadas

### 7. Port Binding
- Auto-contido
- Portas dinâmicas
- Healthchecks
- Graceful shutdown

### 8. Concorrência
- Escala horizontal
- Processos isolados
- Sem estado local
- Carga distribuída

### 9. Descartabilidade
- Startup rápido
- Shutdown gracioso
- Resiliente a falhas
- Auto-healing

### 10. Dev/Prod Parity
- Ambientes similares
- Containers Docker
- Infraestrutura como código
- Mesmo banco em dev

### 11. Logs
- Tratados como streams
- Sem gestão local
- Formato estruturado
- Centralização

### 12. Processos Admin
- One-off tasks em containers
- Mesmo ambiente da app
- Migrations automatizadas
- Jobs agendados

## Consequências 📈

### Positivas ✨

- Aplicações cloud-native
- Facilidade de deploy
- Escalabilidade natural
- Consistência entre serviços
- DevOps simplificado
- Manutenibilidade
- Portabilidade
- Observabilidade

### Negativas ⚠️

- Complexidade inicial
- Overhead de infraestrutura
- Necessidade de tooling
- Curva de aprendizado
- Custo de monitoramento

### Riscos 🚨

- Complexidade acidental
  - Mitigação: Automação e templates
- Overhead operacional
  - Mitigação: Platform team dedicado
- Resistência da equipe
  - Mitigação: Treinamento e documentação

## Alternativas Consideradas 🔄

### Arquitetura Tradicional
- Prós: Mais simples, familiar
- Contras: Menos escalável, mais acoplada

### Serverless
- Prós: Menos operacional, escalável
- Contras: Vendor lock-in, custos imprevisíveis

### PaaS Completo
- Prós: Menos complexidade, mais suporte
- Contras: Menos flexível, mais caro

## Referências 📚

- [12 Factor App](https://12factor.net/)
- [Beyond 12 Factor](https://www.cdta.org/sites/default/files/awards/beyond_the_12-factor_app_pivotal.pdf)
- [Cloud Native Patterns](https://www.manning.com/books/cloud-native-patterns)
- [Production-Ready Microservices](https://www.oreilly.com/library/view/production-ready-microservices/9781491965975/)

## Notas 📝

- Criar templates 12-factor
- Estabelecer padrões por fator
- Definir métricas de conformidade
- Documentar práticas por linguagem
- Implementar automações
- Treinar equipes 