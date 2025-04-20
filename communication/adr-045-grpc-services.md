# ADR-045 - 🔌 gRPC para Comunicação entre Serviços

Data: 2024-04-19

## ⚡ Status

Proposto

## 🎯 Contexto

Para melhorar a eficiência e confiabilidade da comunicação entre serviços, precisamos adotar gRPC como protocolo principal, considerando:
- Performance
- Type safety
- Contratos bem definidos
- Streaming bidirecional
- Multiplexação
- Interoperabilidade
- Monitoramento

## 🔨 Decisão

Adotar gRPC com as seguintes características:

### Definição de Serviços

1. Proto Base
   ```protobuf
   syntax = "proto3";

   package service.v1;

   import "google/protobuf/timestamp.proto";
   
   service UserService {
     rpc GetUser(GetUserRequest) returns (User);
     rpc ListUsers(ListUsersRequest) returns (stream User);
     rpc UpdateUser(UpdateUserRequest) returns (User);
     rpc WatchUpdates(WatchUpdatesRequest) returns (stream UserUpdate);
   }
   ```

2. Mensagens
   ```protobuf
   message User {
     string id = 1;
     string name = 2;
     string email = 3;
     google.protobuf.Timestamp created_at = 4;
     repeated string roles = 5;
     map<string, string> metadata = 6;
   }
   
   message GetUserRequest {
     string user_id = 1;
   }
   ```

### Implementação

1. Servidor
   ```typescript
   class UserServiceImpl implements UserService {
     async getUser(
       call: ServerUnaryCall<GetUserRequest>,
       callback: sendUnaryData<User>
     ): Promise<void> {
       try {
         const user = await this.userRepo.findById(call.request.userId);
         callback(null, user);
       } catch (error) {
         callback(error);
       }
     }
     
     async listUsers(
       call: ServerWritableStream<ListUsersRequest>
     ): Promise<void> {
       const users = await this.userRepo.findAll();
       for (const user of users) {
         call.write(user);
       }
       call.end();
     }
   }
   ```

2. Cliente
   ```typescript
   class UserClient {
     private client: UserServiceClient;
     
     async getUser(id: string): Promise<User> {
       return new Promise((resolve, reject) => {
         this.client.getUser(
           { userId: id },
           (error, response) => {
             if (error) reject(error);
             else resolve(response);
           }
         );
       });
     }
     
     async *listUsers(): AsyncIterator<User> {
       const stream = this.client.listUsers({});
       for await (const user of stream) {
         yield user;
       }
     }
   }
   ```

### Interceptors

1. Autenticação
   ```typescript
   const authInterceptor: Interceptor = async (
     call: ServerUnaryCall,
     callback: sendUnaryData
   ) => {
     const metadata = call.metadata.get('authorization');
     if (!metadata) {
       callback(new Error('Unauthorized'));
       return;
     }
     // Validação do token
   };
   ```

2. Logging
   ```typescript
   const loggingInterceptor: Interceptor = async (
     call: ServerUnaryCall,
     callback: sendUnaryData
   ) => {
     const start = Date.now();
     await callback();
     const duration = Date.now() - start;
     
     logger.info({
       method: call.method,
       duration,
       metadata: call.metadata
     });
   };
   ```

### Monitoramento

1. Métricas
   ```prometheus
   # Server
   grpc_server_started_total
   grpc_server_handled_total
   grpc_server_msg_received_total
   grpc_server_msg_sent_total

   # Client
   grpc_client_started_total
   grpc_client_completed
   grpc_client_msg_received_total
   ```

2. Tracing
   ```typescript
   const tracingInterceptor: Interceptor = async (
     call: ServerUnaryCall,
     callback: sendUnaryData
   ) => {
     const span = tracer.startSpan(call.method);
     span.setAttributes({
       'rpc.system': 'grpc',
       'rpc.service': call.service,
       'rpc.method': call.method
     });
   };
   ```

## 📊 Consequências

### Positivas
- Alta performance
- Contratos fortes
- Streaming nativo
- Type safety
- Geração de código
- Interoperabilidade
- Observabilidade

### Negativas
- Curva de aprendizado
- Complexidade inicial
- Tooling específico
- Debugging mais difícil
- Necessidade de proxy

### Riscos
- Breaking changes
  - Mitigação: Versionamento
- Problemas de rede
  - Mitigação: Retry e timeout
- Complexidade operacional
  - Mitigação: Ferramentas

## 🔄 Alternativas Consideradas

### REST
- Prós: Mais comum
- Contras: Menos eficiente

### GraphQL
- Prós: Mais flexível
- Contras: Overhead maior

### WebSocket
- Prós: Mais simples
- Contras: Menos recursos

## 📚 Referências

- [gRPC Docs](https://grpc.io/docs/)
- [Protocol Buffers](https://developers.google.com/protocol-buffers)
- [gRPC Best Practices](https://grpc.io/docs/guides/best-practices/)
- [gRPC Load Balancing](https://grpc.io/blog/grpc-load-balancing/)
- [OpenTelemetry gRPC](https://opentelemetry.io/docs/instrumentation/js/getting-started/nodejs/)

## 📝 Notas

- Criar templates de serviço
- Implementar observabilidade
- Definir padrões de erro
- Treinar equipe
- Estabelecer CI/CD 