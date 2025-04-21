# 010 - 📝 ☁️ AWS Cloud

Data: 2024-03-21

## ⚡ Status

Aceito

## 🎯 Contexto

Nossa infraestrutura precisa suportar:
- Arquitetura de microsserviços
- Escalabilidade global
- Alta disponibilidade
- Segurança enterprise
- DevOps e automação
- Custos otimizados
- Compliance e regulamentações
- Inovação tecnológica constante

## 🔨 Decisão

Adotar AWS (Amazon Web Services) como nossa plataforma principal de cloud.

### Componentes Principais

1. **Computação e Containers**
   ```yaml
   compute:
     eks:
       version: "1.28"
       nodeGroups:
         - name: general
           instanceType: t3.large
           minSize: 2
           maxSize: 10
         - name: memory
           instanceType: r6g.xlarge
           minSize: 1
           maxSize: 5
       addons:
         - aws-load-balancer-controller
         - cluster-autoscaler
         - metrics-server
   ```

2. **Rede e Segurança**
   ```hcl
   # VPC Configuration
   vpc_cidr = "10.0.0.0/16"
   
   private_subnets = [
     "10.0.1.0/24",
     "10.0.2.0/24",
     "10.0.3.0/24"
   ]
   
   public_subnets = [
     "10.0.101.0/24",
     "10.0.102.0/24",
     "10.0.103.0/24"
   ]
   
   # Security Groups
   ingress_rules = [
     {
       from_port   = 443
       to_port     = 443
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
     }
   ]
   ```

3. **Banco de Dados**
   ```yaml
   databases:
     aurora:
       engine: postgresql
       version: "15.5"
       instances:
         writer: db.r6g.xlarge
         reader: db.r6g.large
       backup:
         retention: 7
         window: "03:00-04:00"
     
     elasticache:
       engine: redis
       version: "7.0"
       nodeType: cache.r6g.large
       numShards: 2
       replicasPerShard: 1
   ```

4. **Observabilidade**
   ```yaml
   monitoring:
     cloudwatch:
       logRetention: 30
       metrics:
         - namespace: "Custom"
           dimensions: ["Service", "Environment"]
     
     xray:
       samplingRule:
         httpMethod: "*"
         urlPath: "*"
         reservoirSize: 1
         fixedRate: 0.05
   ```

### Práticas de Segurança

1. **IAM e Permissões**
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": [
           "s3:GetObject",
           "s3:PutObject"
         ],
         "Resource": "arn:aws:s3:::my-bucket/*",
         "Condition": {
           "StringEquals": {
             "aws:PrincipalTag/Environment": "production"
           }
         }
       }
     ]
   }
   ```

2. **Criptografia e Proteção de Dados**
   ```yaml
   encryption:
     kms:
       enabled: true
       keyRotation: true
     s3:
       serverSide: AES256
     rds:
       atRest: true
       inTransit: true
   ```

## 📊 Diagrama

![Diagrama de Arquitetura AWS](../_assets/adr-010-cloud-aws.png)

## 📊 Consequências

### Positivas

- Infraestrutura escalável e resiliente
- Serviços gerenciados reduzindo overhead
- Ferramentas maduras de DevOps
- Segurança em camadas
- Compliance facilitada
- Automação extensiva
- Monitoramento integrado
- Disaster recovery simplificado

### Negativas

- Custos podem escalar rapidamente
- Complexidade na gestão de recursos
- Necessidade de expertise específica
- Potencial vendor lock-in
- Curva de aprendizado significativa

### Riscos e Mitigações

1. **Custos Inesperados**
   ```yaml
   cost_control:
     budgets:
       monthly_limit: 50000
       alerts:
         - threshold: 80
           notification: ["email", "slack"]
         - threshold: 100
           notification: ["email", "slack", "sms"]
     
     savings_plans:
       term: 3_years
       payment_option: all_upfront
       coverage: 70
   ```

2. **Dependência de Serviços Proprietários**
   ```yaml
   abstraction_layers:
     database:
       interface: "database/sql"
       implementations:
         - "postgres"
         - "mysql"
     
     messaging:
       interface: "messaging/queue"
       implementations:
         - "sqs"
         - "rabbitmq"
   ```

3. **Complexidade Operacional**
   ```yaml
   operational_excellence:
     documentation:
       - runbooks
       - architecture_diagrams
       - incident_response
     
     automation:
       - infrastructure_as_code
       - ci_cd_pipelines
       - monitoring_alerts
   ```

## 🔄 Alternativas Consideradas

### Google Cloud Platform
- Prós: Forte em Kubernetes e ML
- Contras: Menor maturidade, menos serviços

### Microsoft Azure
- Prós: Integração com ferramentas MS, híbrido
- Contras: Complexidade, custo maior

### Multi-cloud
- Prós: Evita vendor lock-in
- Contras: Complexidade extrema, custos maiores

## 📚 Referências

- [AWS Architecture Center](https://aws.amazon.com/architecture/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Cloud Adoption Framework](https://aws.amazon.com/cloud-adoption-framework/)
- [AWS vs Other Clouds](https://aws.amazon.com/compare/)
- [AWS Security Best Practices](https://aws.amazon.com/architecture/security-identity-compliance/)
- [AWS Cost Optimization](https://aws.amazon.com/architecture/cost-optimization/)

## 📝 Notas de Implementação

1. **Centro de Excelência Cloud**
   ```yaml
   cloud_excellence:
     teams:
       - cloud_architecture
       - security
       - devops
       - finops
     
     responsibilities:
       - standards_governance
       - best_practices
       - training_enablement
       - cost_optimization
   ```

2. **Governança**
   ```yaml
   governance:
     policies:
       - resource_tagging
       - security_standards
       - cost_allocation
       - compliance_requirements
     
     reviews:
       - quarterly_architecture
       - monthly_cost
       - weekly_security
   ```

3. **IaC Standards**
   ```yaml
   infrastructure_as_code:
     tools:
       - terraform
       - cloudformation
     
     practices:
       - modular_design
       - version_control
       - peer_review
       - automated_testing
   ```

4. **Disaster Recovery**
   ```yaml
   disaster_recovery:
     rpo: "4h"
     rto: "2h"
     
     strategies:
       - pilot_light
       - multi_region
       - backup_restore
     
     testing:
       frequency: "quarterly"
       scenarios:
         - region_failure
         - service_outage
         - data_corruption
   ``` 