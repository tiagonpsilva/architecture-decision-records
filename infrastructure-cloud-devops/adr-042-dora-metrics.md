# ADR-042 - 📊 DORA Metrics com Integração de Ferramentas

Data: 2024-04-19

## ⚡ Status

Proposto

## 🎯 Contexto

Para melhorar a performance e maturidade do processo de desenvolvimento, precisamos implementar as métricas DORA (DevOps Research and Assessment) integradas com nossas ferramentas de gestão, considerando:
- Deployment Frequency
- Lead Time for Changes
- Mean Time to Recovery
- Change Failure Rate
- Integração com GitHub e Jira
- Automação de coleta
- Visualização e relatórios

## 🔨 Decisão

Adotar uma implementação de DORA Metrics com as seguintes características:

### Métricas Principais

1. Deployment Frequency (DF)
   ```sql
   SELECT 
     date_trunc('day', deployment_time) as day,
     count(*) as deployments
   FROM deployments
   WHERE status = 'success'
   GROUP BY day
   ORDER BY day DESC
   ```

2. Lead Time for Changes (LT)
   ```typescript
   interface LeadTime {
     commitTime: DateTime;
     prCreatedTime: DateTime;
     prMergedTime: DateTime;
     deploymentTime: DateTime;
     totalLeadTime: Duration;
   }
   ```

3. Mean Time to Recovery (MTTR)
   ```typescript
   interface Incident {
     startTime: DateTime;
     detectionTime: DateTime;
     resolutionTime: DateTime;
     impact: 'high' | 'medium' | 'low';
     mttr: Duration;
   }
   ```

4. Change Failure Rate (CFR)
   ```typescript
   const changeFailureRate = (
     failedDeployments / totalDeployments
   ) * 100;
   ```

### Integrações

1. GitHub
   ```typescript
   class GitHubMetrics {
     async getDeploymentFrequency(
       repo: string,
       period: DateRange
     ): Promise<Frequency> {
       // Coleta via GitHub Actions
     }
     
     async getLeadTime(
       pr: PullRequest
     ): Promise<Duration> {
       // Análise de PR timeline
     }
   }
   ```

2. Jira
   ```typescript
   class JiraMetrics {
     async getIncidentMTTR(
       project: string,
       period: DateRange
     ): Promise<Duration> {
       // Análise de tickets de incidente
     }
     
     async getChangeFailures(
       project: string
     ): Promise<FailureRate> {
       // Análise de rollbacks
     }
   }
   ```

### Visualização

1. Dashboard
   ```typescript
   interface DashboardMetrics {
     deploymentFrequency: {
       daily: number;
       weekly: number;
       monthly: number;
     };
     leadTime: {
       average: Duration;
       p90: Duration;
     };
     mttr: {
       average: Duration;
       byImpact: Record<string, Duration>;
     };
     changeFailureRate: {
       current: number;
       trend: number;
     };
   }
   ```

2. Alertas
   ```yaml
   alerts:
     deployment_frequency:
       threshold: "< 1 per day"
       action: "Notify DevOps team"
     
     lead_time:
       threshold: "> 1 week"
       action: "Review process"
     
     mttr:
       threshold: "> 24 hours"
       action: "Incident review"
     
     failure_rate:
       threshold: "> 15%"
       action: "Quality review"
   ```

## 📊 Consequências

### Positivas
- Visibilidade do processo
- Decisões baseadas em dados
- Melhoria contínua
- Automação da coleta
- Identificação de gargalos
- Benchmarking possível
- Cultura orientada a métricas

### Negativas
- Complexidade de implementação
- Overhead de manutenção
- Possível gaming do sistema
- Custo de ferramentas
- Necessidade de contexto

### Riscos
- Métricas incorretas
  - Mitigação: Validação periódica
- Foco excessivo em números
  - Mitigação: Balanced scorecard
- Dados incompletos
  - Mitigação: Múltiplas fontes

## 🔄 Alternativas Consideradas

### Métricas Customizadas
- Prós: Mais específicas
- Contras: Sem benchmark

### Ferramentas Prontas
- Prós: Rápido setup
- Contras: Menos flexível

### Coleta Manual
- Prós: Mais simples
- Contras: Propenso a erros

## 📚 Referências

- [DORA Metrics](https://www.devops-research.com/research.html)
- [Google Cloud DORA](https://cloud.google.com/blog/products/devops-sre/using-the-four-keys-to-measure-your-devops-performance)
- [GitHub Metrics](https://docs.github.com/en/rest/metrics)
- [Jira Metrics](https://www.atlassian.com/software/jira/features/reports)
- [DevOps Metrics](https://cloud.google.com/solutions/devops/devops-measurement)

## 📝 Notas

- Implementar coleta automatizada
- Criar dashboards
- Definir baselines
- Treinar equipe
- Estabelecer metas 