# ADR-043 - 📈 Métricas de Fluxo para Gestão Ágil

Data: 2024-04-19

## ⚡ Status

Proposto

## 🎯 Contexto

Para melhorar a previsibilidade e eficiência do processo de desenvolvimento, precisamos implementar métricas de fluxo que nos permitam:
- Medir Lead Time e Cycle Time
- Visualizar Cumulative Flow
- Analisar Aging de tickets
- Medir Throughput
- Identificar gargalos
- Fazer previsões
- Otimizar processos

## 🔨 Decisão

Adotar um conjunto de métricas de fluxo com as seguintes características:

### Métricas Principais

1. Lead Time
   ```typescript
   interface LeadTime {
     ticketId: string;
     createdAt: DateTime;
     startedAt: DateTime;
     completedAt: DateTime;
     totalLeadTime: Duration;
     waitTime: Duration;
     workTime: Duration;
   }
   ```

2. Cycle Time
   ```typescript
   interface CycleTime {
     phase: 'development' | 'review' | 'test' | 'deploy';
     startTime: DateTime;
     endTime: DateTime;
     duration: Duration;
     blockers: string[];
   }
   ```

3. Cumulative Flow
   ```sql
   SELECT 
     date_trunc('day', status_date) as day,
     status,
     count(*) as items
   FROM ticket_history
   GROUP BY day, status
   ORDER BY day, status
   ```

4. Aging
   ```typescript
   interface TicketAging {
     ticketId: string;
     currentStatus: string;
     currentStatusDuration: Duration;
     totalAge: Duration;
     priority: 'high' | 'medium' | 'low';
     isBlocked: boolean;
   }
   ```

5. Throughput
   ```typescript
   interface Throughput {
     period: 'daily' | 'weekly' | 'monthly';
     completedItems: number;
     points: number;
     categories: Record<string, number>;
   }
   ```

### Visualizações

1. Cumulative Flow Diagram
   ```typescript
   interface CFDData {
     date: DateTime;
     backlog: number;
     ready: number;
     inProgress: number;
     review: number;
     done: number;
   }
   ```

2. Aging Chart
   ```typescript
   interface AgingChart {
     tickets: {
       id: string;
       age: Duration;
       status: string;
       size: number;
     }[];
     thresholds: {
       warning: Duration;
       critical: Duration;
     };
   }
   ```

### Análises

1. Previsibilidade
   ```typescript
   interface Forecast {
     confidence: number;
     estimatedCompletion: DateTime;
     rangeMin: DateTime;
     rangeMax: DateTime;
     assumptions: string[];
   }
   ```

2. Gargalos
   ```typescript
   interface Bottleneck {
     phase: string;
     avgDuration: Duration;
     itemCount: number;
     impact: 'high' | 'medium' | 'low';
     suggestions: string[];
   }
   ```

## 📊 Consequências

### Positivas
- Melhor previsibilidade
- Identificação de problemas
- Decisões baseadas em dados
- Melhoria contínua
- Transparência do processo
- Otimização do fluxo
- Redução de desperdícios

### Negativas
- Complexidade de coleta
- Necessidade de ferramentas
- Overhead de análise
- Resistência à medição
- Custo de implementação

### Riscos
- Dados inconsistentes
  - Mitigação: Validação automática
- Interpretação incorreta
  - Mitigação: Treinamento
- Foco em métricas erradas
  - Mitigação: Revisão periódica

## 🔄 Alternativas Consideradas

### Métricas Básicas
- Prós: Mais simples
- Contras: Menos insights

### Ferramentas Proprietárias
- Prós: Pronto uso
- Contras: Custo alto

### Análise Manual
- Prós: Mais flexível
- Contras: Não escalável

## 📚 Referências

- [Kanban Metrics](https://www.atlassian.com/agile/kanban/metrics)
- [Flow Metrics](https://www.actionableagile.com/metrics/)
- [Cumulative Flow](https://www.digite.com/blog/cumulative-flow-diagram/)
- [Cycle Time](https://www.planview.com/resources/guide/lean-metrics/cycle-time/)
- [Predictability](https://www.leankit.com/learn/kanban/lean-flow-metrics/)

## 📝 Notas

- Implementar coleta automática
- Criar dashboards
- Treinar time em análise
- Estabelecer baselines
- Definir metas de melhoria 