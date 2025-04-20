# ADR-044 - 🔄 Apache Kafka para Comunicação Baseada em Eventos

Data: 2024-04-19

## ⚡ Status

Proposto

## 🎯 Contexto

Para implementar uma arquitetura orientada a eventos robusta e escalável, precisamos adotar o Apache Kafka como plataforma de streaming de eventos, considerando:
- Alta disponibilidade
- Escalabilidade horizontal
- Garantia de entrega
- Ordenação de mensagens
- Processamento em tempo real
- Integração entre sistemas
- Monitoramento e observabilidade

## 🔨 Decisão

Adotar o Apache Kafka com as seguintes características:

### Arquitetura

1. Clusters
   ```yaml
   kafka:
     clusters:
       - name: prod
         brokers: 3
         partitions: 6
         replication: 3
       - name: staging
         brokers: 2
         partitions: 3
         replication: 2
   ```

2. Tópicos
   ```typescript
   interface TopicConfig {
     name: string;
     partitions: number;
     retention: Duration;
     cleanup: 'delete' | 'compact';
     replication: number;
   }
   ```

### Padrões de Mensagem

1. Evento Base
   ```typescript
   interface Event<T> {
     id: string;
     type: string;
     version: number;
     timestamp: DateTime;
     source: string;
     data: T;
     metadata: {
       correlationId: string;
       causationId: string;
       userId: string;
     };
   }
   ```

2. Schema Registry
   ```avro
   {
     "type": "record",
     "name": "UserEvent",
     "fields": [
       {"name": "id", "type": "string"},
       {"name": "action", "type": "string"},
       {"name": "timestamp", "type": "long"},
       {"name": "data", "type": "string"}
     ]
   }
   ```

### Produtores

1. Configuração
   ```typescript
   interface ProducerConfig {
     acks: 'all' | '1' | '0';
     compression: 'gzip' | 'snappy' | 'lz4';
     retries: number;
     batchSize: number;
     linger: Duration;
   }
   ```

2. Implementação
   ```typescript
   class KafkaProducer {
     async publish<T>(
       topic: string,
       event: Event<T>,
       key?: string
     ): Promise<RecordMetadata> {
       // Publicação com retry e circuit breaker
     }
     
     async bulkPublish<T>(
       topic: string,
       events: Event<T>[]
     ): Promise<RecordMetadata[]> {
       // Publicação em batch
     }
   }
   ```

### Consumidores

1. Configuração
   ```typescript
   interface ConsumerConfig {
     groupId: string;
     autoOffset: 'earliest' | 'latest';
     maxPoll: number;
     sessionTimeout: Duration;
     heartbeat: Duration;
   }
   ```

2. Implementação
   ```typescript
   class KafkaConsumer {
     async subscribe<T>(
       topics: string[],
       handler: (event: Event<T>) => Promise<void>
     ): void {
       // Consumo com retry e DLQ
     }
     
     async seek(
       topic: string,
       partition: number,
       offset: number
     ): Promise<void> {
       // Reprocessamento
     }
   }
   ```

### Monitoramento

1. Métricas
   ```prometheus
   # Producers
   kafka_producer_message_rate
   kafka_producer_error_rate
   kafka_producer_latency

   # Consumers
   kafka_consumer_lag
   kafka_consumer_processing_time
   kafka_consumer_errors
   ```

2. Alertas
   ```yaml
   alerts:
     consumer_lag:
       threshold: "> 1000 messages"
       duration: "5m"
       action: "Scale consumers"
     
     error_rate:
       threshold: "> 1%"
       duration: "1m"
       action: "Page SRE"
   ```

## 📊 Consequências

### Positivas
- Alta disponibilidade
- Escalabilidade horizontal
- Garantia de entrega
- Desacoplamento
- Performance
- Replayability
- Observabilidade

### Negativas
- Complexidade operacional
- Custo de infraestrutura
- Necessidade de expertise
- Overhead de manutenção
- Latência eventual

### Riscos
- Particionamento incorreto
  - Mitigação: Planejamento de chaves
- Perda de mensagens
  - Mitigação: Replication e acks
- Performance degradada
  - Mitigação: Monitoramento e tuning

## 🔄 Alternativas Consideradas

### RabbitMQ
- Prós: Mais simples
- Contras: Menos escalável

### AWS SNS/SQS
- Prós: Managed service
- Contras: Vendor lock-in

### Redis Pub/Sub
- Prós: Baixa latência
- Contras: Sem persistência

## 📚 Referências

- [Apache Kafka](https://kafka.apache.org/)
- [Confluent Blog](https://www.confluent.io/blog/)
- [Kafka Patterns](https://www.confluent.io/blog/event-driven-architecture-patterns/)
- [Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html)
- [Kafka Monitoring](https://docs.confluent.io/platform/current/kafka/monitoring.html)

## 📝 Notas

- Criar guias de operação
- Implementar monitoramento
- Definir SLOs
- Treinar equipe
- Estabelecer DR plan 