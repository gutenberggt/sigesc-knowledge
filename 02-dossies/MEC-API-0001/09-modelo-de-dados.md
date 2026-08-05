# 09 — Modelo de dados

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Estado | Modelo conceitual em revisão |
| Última revisão | 2026-08-05 |

## Estado deste artefato

A cartilha não apresenta um modelo lógico completo, diagramas de entidades, cardinalidades, tipos de dados ou esquemas integrais de payload.

Este arquivo separa:

1. elementos e relações identificáveis diretamente na fonte;
2. lacunas que dependem do contrato técnico oficial;
3. estruturas propostas para organizar a integração no SIGESC/MIG.

As estruturas propostas não são modelos oficiais do MEC e não devem ser promovidas sem validação arquitetural.

## Convenções

- `FD`: elemento ou relação diretamente sustentado pela fonte;
- `FD / PC`: elemento citado pela fonte, mas com estrutura técnica incompleta;
- `PA`: proposta arquitetural para o SIGESC/MIG;
- `Proposto`: estrutura ainda não aprovada como modelo corporativo consolidado.

## Entidades e estruturas identificadas

| ID | Elemento | Descrição e relações identificáveis | Classificação | Referência |
|---|---|---|---|---|
| `DAD-MEC-API-0001-001` | Ambiente da API | Contexto de execução classificado como homologação ou produção, com documentação e acesso próprios. | `FD` | pp. 2–3 |
| `DAD-MEC-API-0001-002` | Contrato documentado | Conjunto de rotas, parâmetros, exemplos de payload, respostas e códigos de erro apresentado em Swagger UI e Redocly. | `FD` | p. 3 |
| `DAD-MEC-API-0001-003` | Credencial de acesso | Informação necessária para autenticação e citada entre os itens a verificar em caso de dificuldade; formato e ciclo de vida não são definidos. | `FD / PC` | p. 7 |
| `DAD-MEC-API-0001-004` | Token Bearer | Credencial temporária gerada pela rota de autenticação, reutilizada enquanto válida e renovada automaticamente. O esquema da resposta não é apresentado. | `FD / PC` | p. 4 |
| `DAD-MEC-API-0001-005` | Cabeçalho `Authorization` | Estrutura da requisição que transporta o token no formato `Bearer {token}`. | `FD` | p. 4 |
| `DAD-MEC-API-0001-006` | Payload | Estrutura de dados enviada à API e submetida à pré-validação. Seus campos variam por operação e não são apresentados integralmente. | `FD / PC` | pp. 3, 5 e 7 |
| `DAD-MEC-API-0001-007` | Resultado de pré-validação | Resposta HTTP `422` com detalhes de campos obrigatórios ausentes, tipos incorretos ou atributos inválidos. O esquema dos detalhes não é informado. | `FD / PC` | p. 5 |
| `DAD-MEC-API-0001-008` | Lote | Unidade de processamento que pode ser listada, acompanhada quanto ao status e consultada quanto a erros. A fonte não apresenta seu esquema completo. | `FD / PC` | pp. 5–6 |
| `DAD-MEC-API-0001-009` | `lote_id` | Identificador utilizado para consultar o status e os erros de um lote específico. | `FD` | p. 5 |
| `DAD-MEC-API-0001-010` | Status do lote | Informação que indica o resultado ou o estágio do processamento de um lote; valores possíveis não são enumerados. | `FD / PC` | p. 5 |
| `DAD-MEC-API-0001-011` | Erro de lote | Erro encontrado durante o processamento e associado a um `lote_id`; estrutura e granularidade não são definidas. | `FD / PC` | p. 5 |
| `DAD-MEC-API-0001-012` | Instituição de ensino | Entidade que pode ser listada, cadastrada e editada. Seus atributos e identificadores completos não são apresentados. | `FD / PC` | p. 6 |
| `DAD-MEC-API-0001-013` | Código INEP | Valor citado para consulta ou filtro de instituições. Formato, obrigatoriedade e regras de validação não são apresentados. | `FD / PC` | p. 6 |
| `DAD-MEC-API-0001-014` | Profissional da educação | Entidade que pode ser listada, cadastrada e editada e à qual se relacionam vínculos, funções e formações. | `FD / PC` | p. 6 |
| `DAD-MEC-API-0001-015` | CPF | Valor citado para consulta ou filtro de profissionais. Formato e regras de tratamento não são definidos na cartilha. | `FD / PC` | p. 6 |
| `DAD-MEC-API-0001-016` | Vínculo profissional | Relação associada ao profissional, com operações de adição, edição, inativação, reativação e remoção. A estrutura não é apresentada. | `FD / PC` | p. 6 |
| `DAD-MEC-API-0001-017` | Função profissional | Informação associada ao profissional, com operações de adição e edição. A estrutura não é apresentada. | `FD / PC` | p. 6 |
| `DAD-MEC-API-0001-018` | Formação profissional | Informação associada ao profissional, com operações de adição, edição e remoção. A estrutura não é apresentada. | `FD / PC` | p. 6 |
| `DAD-MEC-API-0001-019` | Controle de consulta | Conjunto de filtros, ordenação e paginação que deve ser testado; parâmetros e formatos não são especificados. | `FD / PC` | p. 7 |
| `DAD-MEC-API-0001-020` | Registro de teste ou erro | Conjunto mínimo de evidência composto por operação executada, código retornado, payload enviado, mensagem recebida e observações. | `FD` | p. 7 |

## Relações conceituais identificadas

```text
Ambiente
├── disponibiliza documentação técnica
├── utiliza credenciais próprias
└── recebe operações da integração

Credencial
└── permite gerar Token Bearer

Token Bearer
└── é enviado no cabeçalho Authorization

Operação
├── possui parâmetros
├── pode receber Payload
├── pode retornar HTTP 422
└── pode originar ou se relacionar a Lote

Lote
├── possui lote_id
├── possui status
└── possui zero ou mais erros de processamento

Instituição de ensino
└── pode ser consultada por código INEP

Profissional da educação
├── pode ser consultado por CPF
├── possui vínculos
├── possui funções
└── possui formações

Execução de teste
└── produz registro de evidência ou erro
```

**Classificação:** `FD` quanto às relações explícitas; `DE` quanto à organização gráfica.

## Limitações do modelo fornecido pela fonte

A cartilha não informa:

- schemas JSON completos;
- nomes e tipos de todos os campos;
- obrigatoriedade de cada atributo;
- cardinalidades formais;
- chaves primárias e estrangeiras;
- identificadores externos além de `lote_id`, código INEP e CPF citados;
- enums de status;
- estrutura dos erros HTTP `422`;
- estrutura dos erros de processamento;
- regras de versionamento dos schemas;
- regras de exclusão, inativação ou temporalidade;
- limites de tamanho de payload ou lote;
- parâmetros formais de filtros, ordenação e paginação.

Esses pontos permanecem como `PC` e dependem de Swagger UI, Redocly, contrato OpenAPI, credenciais e homologação.

## Mapeamentos propostos para o SIGESC/MIG

| ID | Estrutura proposta | Finalidade | Campos conceituais sugeridos | Classificação | Estado |
|---|---|---|---|---|---|
| `MAP-MEC-API-0001-001` | `ExternalEnvironmentConfig` | Separar configurações de homologação e produção. | `environment`, `base_url`, `docs_url`, `redoc_url`, `enabled` | `PA` | Proposto |
| `MAP-MEC-API-0001-002` | `ExternalCredentialReference` | Referenciar credenciais sem armazená-las em documentos de negócio. | `environment`, `secret_reference`, `status`, `updated_at` | `PA` | Proposto |
| `MAP-MEC-API-0001-003` | `AccessTokenCache` | Controlar reutilização e renovação do token. | `environment`, `token_reference`, `issued_at`, `expires_at`, `refresh_state` | `PA` | Proposto |
| `MAP-MEC-API-0001-004` | `ContractReference` | Registrar a documentação técnica utilizada em cada teste ou implementação. | `environment`, `source_type`, `source_location`, `version_or_hash`, `captured_at` | `PA` | Proposto |
| `MAP-MEC-API-0001-005` | `IntegrationOperation` | Representar uma operação externa e sua correlação local. | `operation_id`, `environment`, `resource_type`, `action`, `correlation_id`, `status` | `PA` | Proposto |
| `MAP-MEC-API-0001-006` | `SanitizedPayloadEvidence` | Preservar uma representação controlada do payload para diagnóstico. | `operation_id`, `schema_reference`, `payload_hash`, `sanitized_content`, `captured_at` | `PA` | Proposto |
| `MAP-MEC-API-0001-007` | `ValidationIssue` | Normalizar detalhes de pré-validação HTTP `422`. | `operation_id`, `field_path`, `issue_code`, `message`, `raw_reference` | `PA` | Proposto |
| `MAP-MEC-API-0001-008` | `ExternalBatch` | Representar o lote externo e sua correlação com a operação local. | `lote_id`, `operation_id`, `environment`, `current_status`, `created_at`, `completed_at` | `PA` | Proposto |
| `MAP-MEC-API-0001-009` | `ExternalBatchStatusEvent` | Preservar o histórico de estados observados do lote. | `lote_id`, `observed_status`, `observed_at`, `response_reference` | `PA` | Proposto |
| `MAP-MEC-API-0001-010` | `ExternalBatchError` | Registrar erros retornados para um lote. | `lote_id`, `error_code`, `message`, `record_reference`, `raw_reference` | `PA` | Proposto |
| `MAP-MEC-API-0001-011` | `InstitutionExternalMap` | Relacionar instituição local e representação externa. | `tenant_id`, `local_institution_id`, `inep_code`, `external_reference`, `mapping_version` | `PA` | Proposto |
| `MAP-MEC-API-0001-012` | `ProfessionalExternalMap` | Relacionar profissional local e representação externa. | `tenant_id`, `local_professional_id`, `cpf_reference`, `external_reference`, `mapping_version` | `PA` | Proposto |
| `MAP-MEC-API-0001-013` | `ProfessionalRelationMap` | Organizar mapeamentos de vínculo, função e formação. | `professional_map_id`, `relation_type`, `local_reference`, `external_reference`, `state` | `PA` | Proposto |
| `MAP-MEC-API-0001-014` | `QueryProfile` | Registrar parâmetros confirmados de filtro, ordenação e paginação por operação. | `operation`, `filter_schema`, `sort_schema`, `pagination_schema`, `contract_reference` | `PA` | Proposto |
| `MAP-MEC-API-0001-015` | `HomologationEvidence` | Preservar resultado esperado, resultado observado e divergências. | `test_case_id`, `operation_id`, `environment`, `http_status`, `expected_result`, `observed_result`, `evidence_hash` | `PA` | Proposto |
| `MAP-MEC-API-0001-016` | `OfficialSupportCaseLink` | Relacionar dificuldade técnica e atendimento oficial. | `evidence_id`, `channel`, `protocol_reference`, `opened_at`, `response_reference`, `status` | `PA` | Proposto |

## Relações propostas para o SIGESC/MIG

```text
ExternalEnvironmentConfig
├── 1:1 ExternalCredentialReference
├── 1:N ContractReference
└── 1:N IntegrationOperation

IntegrationOperation
├── 0:1 SanitizedPayloadEvidence
├── 0:N ValidationIssue
├── 0:N ExternalBatch
└── 0:N HomologationEvidence

ExternalBatch
├── 1:N ExternalBatchStatusEvent
└── 0:N ExternalBatchError

InstitutionExternalMap
└── associa instituição local a referência externa

ProfessionalExternalMap
└── 1:N ProfessionalRelationMap

HomologationEvidence
└── 0:N OfficialSupportCaseLink
```

**Classificação:** `PA`.

## Regras de modelagem propostas

1. Tokens e credenciais não devem ser persistidos em texto aberto nas estruturas de evidência.
2. Payloads usados como evidência devem ser sanitizados e, quando apropriado, representados por hash.
3. O `lote_id` deve permanecer correlacionado à operação local de origem.
4. O histórico de status não deve ser sobrescrito por um único valor mutável.
5. Erros HTTP `422` devem ser separados dos erros de processamento do lote.
6. Mapeamentos de instituição e profissional devem preservar o contexto do tenant.
7. CPF e outros dados pessoais devem ser protegidos conforme a política de segurança e privacidade aplicável.
8. Campos sugeridos neste documento não devem ser implementados como contrato definitivo sem validação arquitetural.

**Classificação:** `PA`.

## Dependências de validação

Antes de qualquer consolidação ou implementação definitiva, devem ser obtidos:

- contrato da autenticação;
- schemas de payload e resposta;
- enums de status de lote;
- estrutura de erros HTTP `422`;
- estrutura de erros de processamento;
- identificadores e regras de instituições;
- identificadores e regras de profissionais;
- contratos de vínculos, funções e formações;
- parâmetros de consulta;
- regras de autorização e versionamento.

## Regra de promoção

A promoção deste modelo exige rastreabilidade entre:

```text
fonte → elemento identificado → schema oficial → mapeamento → implementação → teste → evidência
```

Estruturas classificadas como `PA` devem permanecer neste dossiê até aprovação por decisão arquitetural.
