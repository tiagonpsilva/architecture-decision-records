# ADR-035 - 📝 Padronização de Logs

Data: 2024-04-19

## ⚡ Status

Proposto

## 🎯 Contexto

Com o crescimento dos microsserviços e a necessidade de melhor observabilidade, precisamos padronizar a forma como os logs são gerados e gerenciados em toda a aplicação, considerando:
- Níveis de severidade consistentes
- Formato padronizado
- Informações contextuais
- Integração com ferramentas de análise
- Performance e custo de armazenamento

## 🔨 Decisão

Adotar um padrão de logs com os seguintes níveis e características:

### Níveis de Log

1. ERROR
   - Erros que impedem a operação normal
   - Requer ação imediata
   - Exemplos: Falha de conexão com banco, API indisponível
   - Formato: `ERROR [timestamp] [service] [traceId] message {context}`

2. CRITICAL
   - Falhas críticas que afetam múltiplos usuários
   - Requer notificação imediata do time
   - Exemplos: Sistema fora do ar, falha de segurança
   - Formato: `CRITICAL [timestamp] [service] [traceId] message {context}`

3. WARNING
   - Situações inesperadas mas não fatais
   - Monitoramento necessário
   - Exemplos: Retry de operação, degradação de performance
   - Formato: `WARNING [timestamp] [service] [traceId] message {context}`

### Estrutura do Log

```json
{
  "level": "ERROR|CRITICAL|WARNING",
  "timestamp": "ISO8601",
  "service": "service-name",
  "traceId": "uuid",
  "message": "Descrição clara do evento",
  "context": {
    "userId": "optional",
    "requestId": "uuid",
    "path": "/api/resource",
    "method": "GET|POST|PUT|DELETE",
    "errorCode": "ERROR_CODE",
    "stack": "stack trace"
  }
}
```

### Boas Práticas
1. Sempre incluir contexto relevante
2. Mensagens claras e acionáveis
3. Evitar informações sensíveis
4. Usar correlationId/traceId
5. Incluir stack trace quando apropriado
6. Padronizar códigos de erro

## 📊 Consequências

### Positivas
- Melhor debugabilidade
- Monitoramento eficiente
- Alertas mais precisos
- Análise facilitada
- Resposta mais rápida a incidentes
- Rastreabilidade completa
- Documentação implícita

### Negativas
- Overhead de processamento
- Maior consumo de armazenamento
- Necessidade de treinamento
- Complexidade adicional no código
- Custo de ferramentas de análise

### Riscos
- Volume excessivo de logs
  - Mitigação: Rotação e retenção configurável
- Informações sensíveis expostas
  - Mitigação: Filtros e mascaramento
- Performance impactada
  - Mitigação: Log assíncrono e sampling

## 🔄 Alternativas Consideradas

### Log Livre
- Prós: Mais simples de implementar
- Contras: Difícil de analisar e padronizar

### Outros Níveis de Log
- Prós: Mais granularidade
- Contras: Complexidade desnecessária

### Formatos Diferentes
- Prós: Flexibilidade
- Contras: Inconsistência e dificuldade de parsing

## 📚 Referências

- [Logging Best Practices](https://www.scalyr.com/blog/logging-best-practices/)
- [ELK Stack](https://www.elastic.co/what-is/elk-stack)
- [OpenTelemetry](https://opentelemetry.io/)
- [12 Factor App - Logs](https://12factor.net/logs)
- [Structured Logging](https://www.thoughtworks.com/insights/blog/structured-logging)

## 📝 Notas

- Criar biblioteca compartilhada de logging
- Implementar rotação de logs
- Configurar dashboards de monitoramento
- Definir políticas de retenção
- Estabelecer processos de auditoria 