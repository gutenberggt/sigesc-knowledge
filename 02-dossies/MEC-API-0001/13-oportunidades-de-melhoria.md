# 13 — Oportunidades de melhoria

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Contexto interno relacionado | Arquitetura MIG/CMDE e análise de impacto registrada neste dossiê |
| Estado | Oportunidades em revisão |
| Última revisão | 2026-08-05 |

## Estado deste artefato

Este arquivo registra oportunidades identificadas a partir da fonte e propostas de evolução para o SIGESC/MIG.

As oportunidades:

- não constituem requisitos aprovados;
- não autorizam implementação automática;
- não alteram a arquitetura oficial do SIGESC;
- não substituem decisões arquiteturais;
- não indicam prontidão para homologação ou produção;
- devem permanecer rastreadas aos GAPs e decisões do dossiê.

## Convenções

- `DE`: oportunidade derivada da fonte e das lacunas verificadas;
- `PA`: proposta arquitetural para avaliação no SIGESC/MIG;
- `P0`: bloqueador ou condição anterior à homologação real e à produção;
- `P1`: melhoria de alta prioridade para compatibilidade, segurança ou confiabilidade;
- `P2`: melhoria de maturidade operacional e governança;
- `Proposta`: oportunidade ainda não aprovada.

## Catálogo de oportunidades

| ID | Oportunidade | Origem principal | Benefício esperado | Prioridade | Classificação | Estado |
|---|---|---|---|---|---|---|
| `OM-MEC-API-0001-001` | Preservar snapshots oficiais do contrato técnico por ambiente, data e hash. | `GAP-MEC-API-0001-003`; `INT-MEC-API-0001-004` a `INT-MEC-API-0001-007` | Permitir rastreabilidade das mudanças e reprodução dos testes de contrato. | `P0` | `DE` | Proposta |
| `OM-MEC-API-0001-002` | Consolidar uma matriz de rotas, métodos, parâmetros, payloads, respostas e erros. | `REG-MEC-API-0001-010`; `PC-INT-MEC-API-0001-001` a `PC-INT-MEC-API-0001-016` | Reduzir ambiguidades e impedir implementação baseada apenas em exemplos introdutórios. | `P0` | `DE` | Proposta |
| `OM-MEC-API-0001-003` | Padronizar evidências de homologação com ambiente, operação, contrato, entrada sanitizada, resposta e correlação. | `REG-MEC-API-0001-028`; `REG-MEC-API-0001-029`; `GAP-MEC-API-0001-017` | Tornar testes auditáveis, comparáveis e reproduzíveis sem expor segredos. | `P0` | `DE` | Proposta |
| `OM-MEC-API-0001-004` | Construir uma matriz de testes negativos para campos obrigatórios, tipos e atributos inválidos. | `REG-MEC-API-0001-019` a `REG-MEC-API-0001-021`; `RNF-MEC-API-0001-023` | Aumentar a cobertura da pré-validação e a qualidade dos diagnósticos HTTP `422`. | `P1` | `DE` | Proposta |
| `OM-MEC-API-0001-005` | Separar formalmente falhas de autenticação, transporte, pré-validação e processamento de lote. | `GAP-MEC-API-0001-007`; `GAP-MEC-API-0001-010`; `DEC-MEC-API-0001-008` | Evitar retry inadequado e melhorar suporte, métricas e correção de dados. | `P1` | `DE` | Proposta |
| `OM-MEC-API-0001-006` | Homologar filtros, ordenação e paginação com cenários reproduzíveis. | `REG-MEC-API-0001-027`; `GAP-MEC-API-0001-015` | Confirmar comportamento real das consultas antes da consolidação do cliente. | `P1` | `DE` | Proposta |
| `OM-MEC-API-0001-007` | Criar catálogo controlado de massas sintéticas ou anonimizadas para homologação. | `REG-MEC-API-0001-003`; `REG-MEC-API-0001-004`; `RNF-MEC-API-0001-011` a `RNF-MEC-API-0001-013` | Proteger dados pessoais e facilitar a repetição dos testes. | `P1` | `DE` | Proposta |
| `OM-MEC-API-0001-008` | Formalizar pacote de escalonamento ao suporte oficial. | `UC-MEC-API-0001-020`; `FLX-MEC-API-0001-008`; fonte pp. 7–8 | Encaminhar dificuldades com diagnóstico suficiente, sanitizado e rastreável. | `P2` | `DE` | Proposta |
| `OM-MEC-API-0001-009` | Implantar registro interno de contratos externos. | `DEC-MEC-API-0001-003`; `MAP-MEC-API-0001-004` | Centralizar ambiente, versão, hash, origem e vigência dos contratos consumidos. | `P0` | `PA` | Proposta |
| `OM-MEC-API-0001-010` | Implementar gerenciador dedicado do ciclo de vida do token. | `GAP-MEC-API-0001-001`; `GAP-MEC-API-0001-005`; `DEC-MEC-API-0001-004` | Isolar obtenção, cache, expiração, renovação, revogação e falhas de autenticação. | `P0` | `PA` | Proposta |
| `OM-MEC-API-0001-011` | Implementar o provider oficial atrás de feature flags granulares e `fail-closed`. | `GAP-MEC-API-0001-004`; `DEC-MEC-API-0001-001`; `DEC-MEC-API-0001-005` | Impedir chamadas reais sem tenant, ambiente, operação e autorização explícitos. | `P0` | `PA` | Proposta |
| `OM-MEC-API-0001-012` | Versionar DTOs, schemas e mapeadores por recurso e contrato. | `GAP-MEC-API-0001-006`; `DEC-MEC-API-0001-006` | Evitar acoplamento entre frequência, instituições e profissionais e facilitar evolução compatível. | `P1` | `PA` | Proposta |
| `OM-MEC-API-0001-013` | Manter tabela explícita de tradução entre estados oficiais e estados internos. | `GAP-MEC-API-0001-009`; `DEC-MEC-API-0001-007` | Preservar semântica e impedir equivalências implícitas entre API e fila local. | `P1` | `PA` | Proposta |
| `OM-MEC-API-0001-014` | Adotar taxonomia de erros vinculada à política de retry. | `DEC-MEC-API-0001-008`; `CMP-MEC-API-0001-012` | Aplicar repetição somente quando tecnicamente segura e tornar falhas comparáveis. | `P1` | `PA` | Proposta |
| `OM-MEC-API-0001-015` | Implantar repositório de evidências sanitizadas com hash e correlação. | `MAP-MEC-API-0001-006`; `MAP-MEC-API-0001-015`; `DEC-MEC-API-0001-010` | Sustentar auditoria sem transformar logs em depósito de dados sensíveis. | `P1` | `PA` | Proposta |
| `OM-MEC-API-0001-016` | Criar suíte automatizada de testes de contrato para homologação. | `GAP-MEC-API-0001-019`; `RNF-MEC-API-0001-022` a `RNF-MEC-API-0001-026` | Detectar incompatibilidades antes da habilitação de fluxos reais. | `P1` | `PA` | Proposta |
| `OM-MEC-API-0001-017` | Criar matriz de capacidades por provider, ambiente e versão. | `CMP-MEC-API-0001-004`; `DEC-MEC-API-0001-002`; `DEC-MEC-API-0001-009` | Declarar quais operações são simuladas, homologadas, bloqueadas ou produtivas. | `P1` | `PA` | Proposta |
| `OM-MEC-API-0001-018` | Separar os domínios de frequência, instituições e profissionais dentro do provider CMDE. | `GAP-MEC-API-0001-012` a `GAP-MEC-API-0001-014`; `DEC-MEC-API-0001-006` | Evitar que recursos distintos sejam forçados ao mesmo modelo de dados e processamento. | `P2` | `PA` | Proposta |
| `OM-MEC-API-0001-019` | Criar camada explícita de compatibilidade entre planilhas e API. | `GAP-MEC-API-0001-016`; `RF-MEC-API-0001-006`; `RF-MEC-API-0001-007` | Preservar cabeçalhos em caixa alta sem contaminar os contratos `snake_case`. | `P2` | `PA` | Proposta |
| `OM-MEC-API-0001-020` | Evoluir o painel técnico para uma visão de homologação. | `CMP-MEC-API-0001-018`; `UC-MEC-API-0001-018`; `UC-MEC-API-0001-019` | Reunir contrato usado, cenários, lotes, erros, evidências e divergências. | `P2` | `PA` | Proposta |
| `OM-MEC-API-0001-021` | Ampliar observabilidade por ambiente, operação, recurso e resultado. | `CMP-MEC-API-0001-016`; `RNF-MEC-API-0001-018` a `RNF-MEC-API-0001-021` | Facilitar diagnóstico e comparação sem inventar metas quantitativas ausentes na fonte. | `P2` | `PA` | Proposta |
| `OM-MEC-API-0001-022` | Automatizar o registro de divergências entre documentação e comportamento observado. | `REG-MEC-API-0001-028`; `RNF-MEC-API-0001-020` | Evitar perda de achados de homologação e apoiar atualização controlada do cliente. | `P2` | `PA` | Proposta |
| `OM-MEC-API-0001-023` | Formalizar o ciclo de rotação, revogação e teste de credenciais. | `AUT-PC-MEC-API-0001-007`; `ACL-MEC-API-0001-004`; `ACL-MEC-API-0001-018` | Reduzir risco operacional e garantir capacidade de interrupção segura do acesso. | `P0` | `PA` | Proposta |
| `OM-MEC-API-0001-024` | Instituir gate formal de `go/no-go` para produção. | `DEC-MEC-API-0001-012`; `GAP-MEC-API-0001-020` | Impedir ativação produtiva sem contrato, credencial, homologação, evidências e aprovação. | `P0` | `PA` | Proposta |

## Distribuição por prioridade

| Prioridade | Quantidade | Finalidade |
|---|---:|---|
| `P0` | 8 | Remover bloqueadores e estabelecer controles obrigatórios antes de integração real. |
| `P1` | 10 | Consolidar compatibilidade, segurança, confiabilidade e testes. |
| `P2` | 6 | Elevar maturidade operacional, suporte, observabilidade e governança. |

## Agrupamento temático

| Tema | Oportunidades |
|---|---|
| Contrato e rastreabilidade documental | `001`, `002`, `009`, `012`, `016`, `022` |
| Autenticação e segurança operacional | `010`, `011`, `023`, `024` |
| Validação, erros e retry | `004`, `005`, `013`, `014` |
| Homologação e evidências | `003`, `006`, `007`, `008`, `015`, `020` |
| Expansão funcional e compatibilidade | `017`, `018`, `019` |
| Observabilidade | `021` |

## Sequência recomendada de avaliação

### Onda 0 — Bloqueadores

1. Obter e preservar o contrato oficial.
2. Confirmar autenticação e credenciais.
3. Definir padrão de evidência.
4. Garantir feature flags `fail-closed`.
5. Formalizar rotação e revogação.
6. Instituir o gate de produção.

### Onda 1 — Compatibilidade

1. Versionar DTOs e mapeadores.
2. Normalizar erros.
3. Definir tradução de estados.
4. Construir testes negativos e de contrato.
5. Validar filtros, ordenação e paginação.
6. Organizar massas controladas.

### Onda 2 — Maturidade operacional

1. Separar os domínios funcionais.
2. Implementar compatibilidade de planilhas.
3. Evoluir dashboard e observabilidade.
4. Automatizar divergências.
5. Formalizar suporte e acompanhamento.

## Critérios para transformar oportunidade em trabalho aprovado

Uma oportunidade somente deve gerar implementação após:

- confirmação da origem;
- identificação dos GAPs relacionados;
- definição de responsável;
- delimitação de escopo;
- análise de segurança e privacidade;
- decisão arquitetural quando aplicável;
- critérios de aceite;
- estratégia de teste;
- plano de rollback ou revogação;
- autorização explícita para execução.

## Itens que não devem ser antecipados

Ainda não devem ser tratados como concluídos:

- provider oficial ativo;
- autenticação real;
- contratos definitivos;
- equivalência entre estados internos e oficiais;
- suporte produtivo a instituições e profissionais;
- autorização para uso de dados reais;
- prontidão de produção.

## Regra de promoção

A promoção de uma oportunidade exige rastreabilidade entre:

```text
fonte → GAP → oportunidade → decisão → plano → implementação → teste → evidência
```

Oportunidades `DE` devem ser validadas contra a fonte técnica completa. Oportunidades `PA` exigem decisão arquitetural formal antes da implementação.
