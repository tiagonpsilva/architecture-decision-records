# ADR-038 - 🏗️ Terraform para Versionamento de Infraestrutura

Data: 2024-04-19

## ⚡ Status

Proposto

## 🎯 Contexto

Para garantir a consistência, reprodutibilidade e versionamento da infraestrutura, precisamos adotar Infrastructure as Code (IaC) usando Terraform, considerando:
- Múltiplos ambientes
- Segurança e compliance
- Automação de provisionamento
- Controle de custos
- Disaster recovery
- Escalabilidade

## 🔨 Decisão

Adotar Terraform como ferramenta principal de IaC com a seguinte estrutura:

### Estrutura do Projeto
```
terraform/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   ├── staging/
│   └── prod/
├── modules/
│   ├── networking/
│   ├── compute/
│   ├── database/
│   ├── security/
│   └── monitoring/
├── scripts/
└── README.md
```

### Padrões de Código
1. Módulos Reutilizáveis
   ```hcl
   module "vpc" {
     source = "../../modules/networking"
     environment = var.environment
     vpc_cidr = var.vpc_cidr
     tags = local.common_tags
   }
   ```

2. Variáveis Tipadas
   ```hcl
   variable "environment" {
     type = string
     description = "Environment name (dev/staging/prod)"
     validation {
       condition = contains(["dev", "staging", "prod"], var.environment)
       error_message = "Environment must be dev, staging, or prod."
     }
   }
   ```

3. Tags Padronizadas
   ```hcl
   locals {
     common_tags = {
       Environment = var.environment
       Project     = var.project_name
       ManagedBy   = "Terraform"
       Owner       = var.team
     }
   }
   ```

### Práticas de Versionamento
1. Estado Remoto
   ```hcl
   terraform {
     backend "s3" {
       bucket = "terraform-state"
       key    = "env/${var.environment}/terraform.tfstate"
       region = "us-east-1"
       encrypt = true
     }
   }
   ```

2. Workspaces
   - Um workspace por ambiente
   - Isolamento de estado
   - Variáveis específicas

3. Locks
   - DynamoDB para locking
   - Prevenção de conflitos
   - Execução segura

### Pipeline CI/CD
1. Validação
   - Formato
   - Segurança
   - Custos

2. Planejamento
   - Review automático
   - Estimativa de custos
   - Aprovação manual

3. Aplicação
   - Deploy automatizado
   - Rollback automático
   - Notificações

## 📊 Consequências

### Positivas
- Infraestrutura versionada
- Reprodutibilidade garantida
- Automação completa
- Documentação como código
- Controle de custos
- Segurança reforçada
- Disaster recovery facilitado

### Negativas
- Curva de aprendizado
- Complexidade inicial
- Custo de ferramentas
- Overhead de manutenção
- Necessidade de expertise

### Riscos
- Erros de configuração
  - Mitigação: Testes e validações
- Custos inesperados
  - Mitigação: Políticas de custo
- Conflitos de estado
  - Mitigação: Locks e workspaces

## 🔄 Alternativas Consideradas

### CloudFormation
- Prós: Nativo AWS
- Contras: Vendor lock-in

### Pulumi
- Prós: Código em linguagens comuns
- Contras: Menos maduro

### Ansible
- Prós: Mais simples
- Contras: Menos adequado para cloud

## 📚 Referências

- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [AWS with Terraform](https://learn.hashicorp.com/collections/terraform/aws-get-started)
- [Terraform Module Registry](https://registry.terraform.io/)
- [Infrastructure as Code](https://www.thoughtworks.com/insights/blog/infrastructure-code-reason-smile)
- [State Management](https://www.terraform.io/docs/state/purpose.html)

## 📝 Notas

- Criar pipeline de CI/CD
- Documentar padrões
- Implementar monitoramento
- Treinar equipe
- Estabelecer processos de review 