# ADR-052: Monitoramento com Prometheus

## Status

Proposto

## Contexto

A necessidade de monitoramento robusto e em tempo real de nossa infraestrutura e aplicações requer uma solução que seja:
- Escalável
- Confiável
- Fácil de integrar
- Com suporte a alertas
- Capaz de lidar com métricas personalizadas

O Prometheus se destaca como uma solução de monitoramento de código aberto que atende a esses requisitos.

## Decisão

Implementaremos o Prometheus como nossa principal solução de monitoramento, junto com ferramentas complementares:

### 1. Arquitetura de Monitoramento
```yaml
monitoring:
  prometheus:
    retention: 15d
    scrape_interval: 15s
    evaluation_interval: 15s
    storage:
      type: local
      retention: 30d
  alertmanager:
    resolve_timeout: 5m
    route:
      group_wait: 30s
      group_interval: 5m
      repeat_interval: 4h
  grafana:
    datasources:
      - name: Prometheus
        type: prometheus
        access: proxy
```

### 2. Métricas Padrão
```typescript
const metrics = {
  http_requests_total: new Counter({
    name: 'http_requests_total',
    help: 'Total de requisições HTTP',
    labelNames: ['method', 'path', 'status']
  }),
  http_request_duration_seconds: new Histogram({
    name: 'http_request_duration_seconds',
    help: 'Duração das requisições HTTP',
    buckets: [0.1, 0.5, 1, 2, 5]
  }),
  active_users: new Gauge({
    name: 'active_users',
    help: 'Usuários ativos no momento'
  })
};
```

### 3. Regras de Alerta
```yaml
groups:
  - name: application
    rules:
      - alert: HighErrorRate
        expr: |
          sum(rate(http_requests_total{status=~"5.."}[5m])) 
          / 
          sum(rate(http_requests_total[5m])) > 0.1
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "Alta taxa de erros"
          description: "Taxa de erros > 10% nos últimos 5 minutos"

      - alert: SlowResponses
        expr: |
          histogram_quantile(0.95, 
            sum(rate(http_request_duration_seconds_bucket[5m])) by (le)
          ) > 2
        for: 10m
        labels:
          severity: warning
        annotations:
          summary: "Respostas lentas"
          description: "95º percentil > 2s nos últimos 10 minutos"
```

### 4. Dashboards Padrão
```json
{
  "dashboard": {
    "title": "Application Overview",
    "panels": [
      {
        "title": "Request Rate",
        "type": "graph",
        "targets": [
          {
            "expr": "sum(rate(http_requests_total[5m])) by (status)"
          }
        ]
      },
      {
        "title": "Response Time",
        "type": "heatmap",
        "targets": [
          {
            "expr": "rate(http_request_duration_seconds_bucket[5m])"
          }
        ]
      }
    ]
  }
}
```

## Consequências

### Positivas
- Monitoramento em tempo real
- Alertas configuráveis
- Visualização rica com Grafana
- Coleta automática de métricas
- Escalabilidade horizontal

### Negativas
- Necessidade de manutenção da infraestrutura
- Curva de aprendizado para PromQL
- Consumo de recursos para armazenamento
- Complexidade na configuração inicial

## Riscos
- Sobrecarga de armazenamento
- Falsos positivos em alertas
- Perda de dados em caso de falha
- Impacto no desempenho das aplicações monitoradas

## Alternativas Consideradas
1. Datadog
2. Nagios
3. Zabbix
4. ELK Stack
5. CloudWatch

## Referências
- Prometheus Documentation
- Grafana Documentation
- AlertManager Documentation
- SRE Book - Google
- Prometheus: Up & Running - O'Reilly

## Notas
- Implementar backup dos dados do Prometheus
- Revisar regras de retenção periodicamente
- Manter documentação de métricas customizadas
- Treinar equipe em PromQL

## Exemplo de Configuração
```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'application'
    static_configs:
      - targets: ['localhost:8080']
    metrics_path: '/metrics'
    scheme: 'http'
    basic_auth:
      username: 'prometheus'
      password: '${PROM_PASSWORD}'

  - job_name: 'node-exporter'
    static_configs:
      - targets: ['localhost:9100']

alerting:
  alertmanagers:
    - static_configs:
        - targets: ['localhost:9093']
```

## Métricas de Avaliação
- Taxa de disponibilidade do Prometheus
- Tempo de resposta das consultas
- Uso de armazenamento
- Taxa de falsos positivos em alertas
- Cobertura de métricas críticas 