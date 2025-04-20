# ADR-055: Estratégia de Cache

## Status

Proposto

## Contexto

A necessidade de otimizar o desempenho e reduzir a carga em sistemas de backend, bancos de dados e serviços externos requer uma estratégia de cache bem definida. Precisamos estabelecer padrões para:

- Diferentes níveis de cache (in-memory, distribuído, browser)
- Políticas de invalidação
- Consistência de dados
- Monitoramento e métricas
- Estratégias de fallback

## Decisão

Implementaremos uma estratégia de cache em múltiplas camadas:

### 1. Cache no Cliente (Browser)
```typescript
// Configuração do Service Worker
const CACHE_VERSION = 'v1';
const CACHE_CONFIG = {
  staticAssets: {
    maxAge: '7d',
    strategy: 'cache-first'
  },
  apiResponses: {
    maxAge: '1h',
    strategy: 'stale-while-revalidate'
  }
};
```

### 2. Cache em Memória (Aplicação)
```typescript
import { CacheModule } from '@nestjs/common';
import * as store from 'cache-manager';

@Module({
  imports: [
    CacheModule.register({
      store: store.memory,
      ttl: 300, // 5 minutos
      max: 1000, // máximo de itens
      updateAgeOnGet: true
    })
  ]
})
```

### 3. Cache Distribuído (Redis)
```typescript
import { RedisCache } from './cache';

const cacheConfig = {
  redis: {
    host: process.env.REDIS_HOST,
    port: process.env.REDIS_PORT,
    password: process.env.REDIS_PASSWORD,
  },
  defaultTTL: 3600, // 1 hora
  patterns: {
    userProfile: 'user:*',
    productCatalog: 'product:*'
  }
};
```

### 4. Políticas de Invalidação
```typescript
class CacheInvalidator {
  async invalidate(pattern: string): Promise<void> {
    // Invalidação por padrão
    await this.redis.del(pattern);
    
    // Notificação para outros serviços
    await this.eventBus.publish('cache.invalidated', {
      pattern,
      timestamp: new Date()
    });
  }
  
  async softInvalidate(key: string): Promise<void> {
    // Marca como stale mas mantém
    await this.redis.hset(key, 'stale', true);
  }
}
```

### 5. Monitoramento
```typescript
class CacheMetrics {
  private metrics = {
    hits: new Counter('cache_hits_total'),
    misses: new Counter('cache_misses_total'),
    latency: new Histogram('cache_operation_latency_seconds'),
    size: new Gauge('cache_size_bytes')
  };

  recordMetrics(operation: CacheOperation): void {
    // Registro de métricas para Prometheus
  }
}
```

## Consequências

### Positivas
- Redução significativa da carga em bancos de dados
- Melhor tempo de resposta para requisições frequentes
- Economia de recursos computacionais
- Maior resiliência do sistema

### Negativas
- Complexidade adicional no gerenciamento de cache
- Necessidade de sincronização entre múltiplas instâncias
- Possibilidade de inconsistências temporárias
- Overhead de memória

## Riscos
- Vazamento de memória por cache mal gerenciado
- Inconsistência de dados em caso de falha na invalidação
- Complexidade na depuração de problemas relacionados ao cache

## Alternativas Consideradas
1. Cache apenas em memória
2. Cache apenas no cliente
3. Uso de CDN para todo o conteúdo
4. Não utilizar cache

## Referências
- Redis Documentation
- Browser Cache MDN
- Cache-Control HTTP Headers
- Service Worker API

## Notas
- Implementar circuit breaker para fallback em caso de falha do Redis
- Manter logs de operações críticas de cache
- Revisar TTLs periodicamente
- Implementar warm-up de cache para dados críticos

## Exemplo de Configuração
```json
{
  "cache": {
    "layers": {
      "browser": {
        "enabled": true,
        "maxAge": 86400
      },
      "memory": {
        "enabled": true,
        "size": "256mb",
        "ttl": 300
      },
      "redis": {
        "enabled": true,
        "clusters": 3,
        "maxMemory": "1gb"
      }
    },
    "monitoring": {
      "enabled": true,
      "sampleRate": 0.1,
      "alertThresholds": {
        "missRate": 0.4,
        "latency": 100
      }
    }
  }
}
```

## Métricas de Avaliação
- Taxa de hit/miss do cache
- Latência média de operações
- Uso de memória
- Taxa de invalidação
- Tempo de vida médio dos itens em cache 