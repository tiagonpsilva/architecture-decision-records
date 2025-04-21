# 🚢 ADR-028: Orquestração com Kubernetes

## Status
Proposto

## Contexto
Com a adoção de uma arquitetura de microsserviços, precisamos de uma plataforma robusta para orquestrar nossos contêineres em produção. A complexidade de gerenciar múltiplos serviços, garantir alta disponibilidade, escalabilidade e resiliência requer uma solução madura de orquestração.

## Decisão
Decidimos adotar o Kubernetes como nossa plataforma de orquestração de contêineres. Utilizaremos o Amazon EKS (Elastic Kubernetes Service) como serviço gerenciado, alinhado com nossa decisão anterior de usar AWS como plataforma cloud.

### Componentes Principais

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

title Arquitetura Kubernetes

Person(dev, "DevOps", "Time de DevOps")
System_Boundary(k8s, "Cluster Kubernetes") {
    Container(api, "API Server", "Control Plane", "Gerencia o estado do cluster")
    Container(scheduler, "Scheduler", "Control Plane", "Agenda pods nos nodes")
    Container(cm, "Controller Manager", "Control Plane", "Mantém o estado desejado")
    Container(etcd, "etcd", "Control Plane", "Armazena o estado do cluster")
    
    Container(node1, "Worker Node 1", "Node", "Executa os workloads") {
        Container(kubelet1, "Kubelet", "Agent", "Gerencia containers")
        Container(proxy1, "Kube Proxy", "Network", "Roteamento de rede")
    }
    
    Container(node2, "Worker Node 2", "Node", "Executa os workloads") {
        Container(kubelet2, "Kubelet", "Agent", "Gerencia containers")
        Container(proxy2, "Kube Proxy", "Network", "Roteamento de rede")
    }
}

Rel(dev, api, "Gerencia", "kubectl")
Rel(api, scheduler, "Coordena")
Rel(api, cm, "Coordena")
Rel(api, etcd, "Persiste estado")
Rel(scheduler, node1, "Agenda pods")
Rel(scheduler, node2, "Agenda pods")
Rel(kubelet1, api, "Reporta estado")
Rel(kubelet2, api, "Reporta estado")

@enduml
```

### Principais Características
- **Alta Disponibilidade**: Múltiplos nós workers e control plane redundante
- **Escalabilidade**: Horizontal pod autoscaling baseado em métricas
- **Auto-healing**: Substituição automática de pods falhos
- **Service Discovery**: DNS interno e load balancing
- **Gerenciamento de Configuração**: ConfigMaps e Secrets
- **Monitoramento**: Integração com Prometheus e Grafana
- **Segurança**: Network Policies, RBAC, e Pod Security Policies

## Consequências

### Positivas
1. Plataforma madura e testada em produção por grandes empresas
2. Grande ecossistema de ferramentas e integrações
3. Automação de várias tarefas operacionais
4. Melhor utilização de recursos computacionais
5. Facilita práticas de CI/CD e GitOps
6. Abstração da infraestrutura subjacente

### Negativas
1. Curva de aprendizado significativa
2. Complexidade operacional aumentada
3. Custos iniciais mais altos
4. Necessidade de expertise específica na equipe

## Riscos
1. **Complexidade Operacional**
   - *Mitigação*: Treinamento contínuo da equipe e documentação detalhada
2. **Custos de Infraestrutura**
   - *Mitigação*: Implementar políticas de cost management e resource quotas
3. **Segurança**
   - *Mitigação*: Seguir best practices de segurança e realizar auditorias regulares

## Alternativas Consideradas
1. **Docker Swarm**
   - Mais simples, mas menos recursos
   - Menor ecossistema
2. **Amazon ECS**
   - Mais simples, mas específico para AWS
   - Menos flexibilidade
3. **Nomad**
   - Mais leve, mas menos recursos
   - Menor adoção no mercado

## Referências
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [EKS Best Practices](https://aws.github.io/aws-eks-best-practices/)
- [Kubernetes Patterns](https://www.redhat.com/cms/managed-files/cm-oreilly-kubernetes-patterns-ebook-f19824-201910-en.pdf)
- [Production-Grade Container Orchestration](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)

## Notas
- Iniciar com cluster de desenvolvimento para aprendizado
- Estabelecer práticas de GitOps desde o início
- Criar guias operacionais e playbooks de incidentes
- Implementar monitoramento e alertas adequados
- Definir estratégia de backup e DR
