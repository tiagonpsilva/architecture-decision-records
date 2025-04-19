# ADR-025: Adoção de Infraestrutura como Código (IaC)

## Status

Proposto

## Contexto

Com o crescimento da nossa infraestrutura na AWS e a necessidade de garantir consistência, reprodutibilidade e versionamento dos recursos de infraestrutura, precisamos estabelecer uma abordagem padronizada para o gerenciamento de infraestrutura. A necessidade de automatizar a criação e manutenção de ambientes, reduzir erros humanos e melhorar a documentação da infraestrutura nos leva a considerar a adoção de Infraestrutura como Código (IaC).

## Decisão

Decidimos adotar o Terraform como nossa principal ferramenta de IaC, complementada pelo AWS CDK para casos específicos que requerem mais flexibilidade programática. A estrutura será organizada da seguinte forma:

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

title Arquitetura de Infraestrutura como Código

Person(devops, "DevOps Engineer", "Responsável por manter a infraestrutura")
Person(dev, "Desenvolvedor", "Desenvolve e deploya aplicações")

System_Boundary(iac, "Infraestrutura como Código") {
    Container(terraform, "Terraform", "HCL", "Gerenciamento principal de infraestrutura")
    Container(cdk, "AWS CDK", "TypeScript", "Recursos específicos e complexos")
    Container(modules, "Módulos Terraform", "HCL", "Componentes reutilizáveis")
    Container(state, "Estado Terraform", "S3 + DynamoDB", "Estado e lock distribuído")
}

System_Ext(ci, "CI/CD Pipeline", "GitHub Actions")
System_Ext(aws, "AWS Cloud", "Infraestrutura alvo")

Rel(devops, terraform, "Desenvolve e aplica", "git push")
Rel(dev, ci, "Commit/PR", "git push")
Rel(ci, terraform, "Executa", "plan/apply")
Rel(terraform, modules, "Utiliza", "module source")
Rel(terraform, state, "Gerencia estado", "read/write")
Rel(terraform, aws, "Provisiona", "API calls")
Rel(cdk, aws, "Provisiona", "API calls")
@enduml
```

### Estrutura de Diretórios

```
infrastructure/
├── terraform/
│   ├── environments/
│   │   ├── prod/
│   │   ├── staging/
│   │   └── dev/
│   ├── modules/
│   │   ├── ecs/
│   │   ├── rds/
│   │   └── vpc/
│   └── shared/
└── cdk/
    ├── lib/
    └── bin/
```

### Práticas Adotadas

1. **Modularização**:
   - Criação de módulos reutilizáveis para componentes comuns
   - Separação clara entre ambientes
   - Uso de workspaces para isolamento

2. **Versionamento**:
   - Todo código IaC versionado no Git
   - Uso de tags semânticas para releases
   - Branches protegidos para ambientes críticos

3. **Segurança**:
   - Secrets gerenciados via AWS Secrets Manager
   - RBAC para acesso aos recursos
   - Scanning de segurança do código IaC

4. **CI/CD**:
   - Pipeline automatizado para validação
   - Planos Terraform revisados em PRs
   - Aprovação manual para ambientes críticos

## Consequências

### Positivas
- Infraestrutura versionada e rastreável
- Redução de erros humanos
- Facilidade de replicação de ambientes
- Melhor documentação através do código
- Processo de mudança mais controlado
- Facilidade de rollback
- Padronização entre equipes

### Negativas
- Curva de aprendizado inicial
- Necessidade de manter múltiplas ferramentas (Terraform + CDK)
- Overhead de manutenção dos módulos
- Possível aumento inicial no tempo de implementação
- Custo com ferramentas e treinamento

## Riscos

1. **Complexidade**:
   - Mitigação: Documentação detalhada e treinamento contínuo
   - Revisão regular dos módulos para simplificação

2. **Drift de Configuração**:
   - Mitigação: Monitoramento regular do estado
   - Alertas para mudanças manuais

3. **Performance**:
   - Mitigação: Otimização de módulos
   - Uso de paralelismo quando possível

## Alternativas Consideradas

### 1. CloudFormation
- Pros: Integração nativa com AWS
- Contras: Limitado à AWS, sintaxe verbosa

### 2. Pulumi
- Pros: Linguagens de programação reais
- Contras: Menos maduro, comunidade menor

### 3. Ansible
- Pros: Mais simples, bom para configuração
- Contras: Menos adequado para infraestrutura cloud

## Referências

- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [AWS CDK Workshop](https://cdkworkshop.com/)
- [Infrastructure as Code by Kief Morris](https://infrastructure-as-code.com/)
- [HashiCorp Learn](https://learn.hashicorp.com/terraform) 