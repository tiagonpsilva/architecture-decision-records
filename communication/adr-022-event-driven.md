# 🔄 ADR-022: Arquitetura Event-Driven

## Status

Proposto

## Contexto

Com o crescimento do sistema e a necessidade de garantir consistência, escalabilidade e desacoplamento entre serviços, precisamos de uma arquitetura que permita:

- Comunicação assíncrona entre serviços
- Processamento distribuído de eventos
- Rastreabilidade de operações
- Alta disponibilidade e resiliência
- Consistência eventual entre serviços

## Decisão

Decidimos adotar uma arquitetura Event-Driven utilizando Apache Kafka como principal plataforma de eventos, complementada por RabbitMQ para mensageria específica de serviços.

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

LAYOUT_WITH_LEGEND()

title Arquitetura Event-Driven

System_Boundary(c1, "Sistema") {
    Container(api_gateway, "API Gateway", "Kong", "Gateway de APIs")
    
    Container(order_service, "Order Service", "Python/FastAPI", "Serviço de Pedidos")
    Container(payment_service, "Payment Service", "Go", "Serviço de Pagamentos")
    Container(inventory_service, "Inventory Service", "Python/FastAPI", "Serviço de Inventário")
    Container(notification_service, "Notification Service", "Python/FastAPI", "Serviço de Notificações")
    Container(analytics_service, "Analytics Service", "Python/FastAPI", "Serviço de Analytics")
    
    ContainerDb(order_db, "Order DB", "MongoDB", "Banco de dados de pedidos")
    ContainerDb(payment_db, "Payment DB", "PostgreSQL", "Banco de dados de pagamentos")
    ContainerDb(inventory_db, "Inventory DB", "PostgreSQL", "Banco de dados de inventário")
    
    Container(event_store, "Event Store", "Apache Kafka", "Armazenamento de eventos")
    Container(event_streaming, "Event Streaming", "Kafka Streams", "Processamento de streams")
    Container(service_queue, "Service Queue", "RabbitMQ", "Filas de serviço")
}

System_Ext(email_system, "Email System", "Sistema de Email")
System_Ext(monitoring, "Monitoring", "Sistema de Monitoramento")

Rel(order_service, event_store, "Publica eventos", "Kafka Protocol")
Rel(payment_service, event_store, "Publica/Consome eventos", "Kafka Protocol")
Rel(inventory_service, event_store, "Publica/Consome eventos", "Kafka Protocol")
Rel(analytics_service, event_store, "Consome eventos", "Kafka Protocol")

Rel(event_store, event_streaming, "Processa eventos", "Kafka Streams")
Rel(event_streaming, analytics_service, "Envia dados processados", "Kafka Protocol")

Rel(order_service, order_db, "Persiste dados", "MongoDB Protocol")
Rel(payment_service, payment_db, "Persiste dados", "SQL")
Rel(inventory_service, inventory_db, "Persiste dados", "SQL")

Rel(notification_service, service_queue, "Consome mensagens", "AMQP")
Rel(order_service, service_queue, "Publica mensagens", "AMQP")
Rel(payment_service, service_queue, "Publica mensagens", "AMQP")

Rel(notification_service, email_system, "Envia emails", "SMTP")
Rel_U(monitoring, event_store, "Monitora", "JMX")
Rel_U(monitoring, service_queue, "Monitora", "AMQP")

@enduml
```

### Principais Componentes

1. **Event Store (Apache Kafka)**
   - Armazenamento durável de eventos
   - Garantia de ordenação
   - Particionamento para escalabilidade
   - Replicação para alta disponibilidade

2. **Event Streaming (Kafka Streams)**
   - Processamento em tempo real
   - Agregações e transformações
   - Window operations
   - State stores

3. **Service Queue (RabbitMQ)**
   - Mensageria ponto a ponto
   - Filas específicas por serviço
   - Dead Letter Queues
   - Retry policies

4. **Event Schemas**
   - Schema Registry
   - Versionamento de eventos
   - Compatibilidade retroativa
   - Documentação automática

## Consequências

### Positivas

- Alto desacoplamento entre serviços
- Melhor escalabilidade
- Processamento assíncrono eficiente
- Facilidade para adicionar novos consumidores
- Melhor resiliência a falhas

### Negativas

- Maior complexidade operacional
- Necessidade de garantir ordem de eventos
- Desafios com consistência eventual
- Complexidade no debugging
- Necessidade de monitoramento robusto

## Riscos

- Duplicação de eventos
- Perda de mensagens
- Problemas de performance
- Complexidade no troubleshooting
- Custos operacionais elevados

### Mitigação

- Implementar idempotência em consumidores
- Monitoramento detalhado
- Testes de carga e resiliência
- Documentação de padrões de eventos
- Ferramentas de rastreamento

## Alternativas Consideradas

1. **REST Síncrono**
   - Mais simples de implementar
   - Acoplamento forte
   - Menor resiliência

2. **gRPC**
   - Melhor performance
   - Suporte a streaming
   - Maior acoplamento

3. **GraphQL Subscriptions**
   - Bom para real-time
   - Complexidade adicional
   - Menos adequado para processamento assíncrono

## Referências

- [Event-Driven Architecture](https://martinfowler.com/articles/201701-event-driven.html)
- [Apache Kafka Documentation](https://kafka.apache.org/documentation/)
- [Event Sourcing Pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/event-sourcing)
- [CQRS Pattern](https://martinfowler.com/bliki/CQRS.html)

## Notas

- Implementar gradualmente por domínio
- Estabelecer padrões de eventos
- Criar ferramentas de monitoramento
- Documentar padrões de retry e DLQ
- Treinar equipes em debugging distribuído 