# 06 — Requisitos não funcionais

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Estado | Requisitos derivados em revisão |
| Última revisão | 2026-08-05 |

## Estado deste artefato

Os requisitos não funcionais abaixo são **derivações de engenharia** produzidas a partir das regras e restrições catalogadas em `04-regras-e-restricoes.md`.

Eles permanecem com estado `Proposto` até serem confrontados com a documentação técnica vigente, validados em homologação e revisados contra a arquitetura oficial do SIGESC/MIG.

## Convenções

- `DE`: derivação de engenharia sustentada pela fonte;
- `DE / PC`: derivação dependente de contrato técnico ou comportamento ainda não confirmado;
- `Proposto`: requisito ainda não promovido ao conhecimento consolidado.

## Requisitos não funcionais derivados

| ID | Requisito | Categoria | Origem | Classificação | Estado |
|---|---|---|---|---|---|
| `RNF-MEC-API-0001-001` | Credenciais e tokens de acesso não devem ser incorporados ao código-fonte, a payloads de negócio ou a documentos de evidência. | Segurança | `REG-MEC-API-0001-011`; `REG-MEC-API-0001-016` | `DE` | Proposto |
| `RNF-MEC-API-0001-002` | Tokens Bearer devem ser ocultados ou removidos de logs, mensagens de erro, relatórios e capturas de diagnóstico. | Segurança | `REG-MEC-API-0001-011`; `REG-MEC-API-0001-029` | `DE` | Proposto |
| `RNF-MEC-API-0001-003` | Homologação e produção devem utilizar configurações e credenciais segregadas. | Segurança / Configuração | `REG-MEC-API-0001-002`; `REG-MEC-API-0001-010` | `DE` | Proposto |
| `RNF-MEC-API-0001-004` | Requisições protegidas devem seguir exatamente o esquema oficial do cabeçalho `Authorization`. | Conformidade de protocolo | `REG-MEC-API-0001-016` | `DE` | Proposto |
| `RNF-MEC-API-0001-005` | O ciclo de vida do token deve ser configurável conforme a validade, a renovação e as respostas definidas pelo contrato oficial vigente. | Segurança / Configuração | `REG-MEC-API-0001-012`; `REG-MEC-API-0001-013`; `REG-MEC-API-0001-014` | `DE / PC` | Proposto |
| `RNF-MEC-API-0001-006` | A serialização dos atributos da API deve preservar exatamente a convenção `snake_case` definida pelo contrato oficial. | Interoperabilidade | `REG-MEC-API-0001-017` | `DE` | Proposto |
| `RNF-MEC-API-0001-007` | Processos relacionados a planilhas devem preservar a convenção de cabeçalhos em caixa alta, sem confundi-la com os nomes dos atributos da API. | Interoperabilidade | `REG-MEC-API-0001-018` | `DE` | Proposto |
| `RNF-MEC-API-0001-008` | Payloads e respostas devem ser validados contra os esquemas oficiais aplicáveis à operação e à versão da API. | Conformidade de contrato | `REG-MEC-API-0001-010`; `REG-MEC-API-0001-019`; `REG-MEC-API-0001-020` | `DE / PC` | Proposto |
| `RNF-MEC-API-0001-009` | O cliente deve preservar o código HTTP e os detalhes de diagnóstico retornados pela API, especialmente em respostas `422`. | Interoperabilidade / Diagnóstico | `REG-MEC-API-0001-021`; `REG-MEC-API-0001-029` | `DE` | Proposto |
| `RNF-MEC-API-0001-010` | URLs, versões e caminhos de integração devem ser configuráveis por ambiente, sem alteração da regra de negócio. | Configurabilidade | `REG-MEC-API-0001-010`; `REG-MEC-API-0001-022`; `REG-MEC-API-0001-023`; `REG-MEC-API-0001-024` | `DE / PC` | Proposto |
| `RNF-MEC-API-0001-011` | Dados reais não devem ser utilizados nos testes de homologação. | Proteção de dados | `REG-MEC-API-0001-004` | `DE` | Proposto |
| `RNF-MEC-API-0001-012` | Massas de homologação devem ser sintéticas, anonimizadas ou preparadas de forma a não expor dados pessoais reais. | Proteção de dados | `REG-MEC-API-0001-003`; `REG-MEC-API-0001-004` | `DE` | Proposto |
| `RNF-MEC-API-0001-013` | Evidências de teste devem permitir diagnóstico sem reproduzir desnecessariamente dados pessoais ou credenciais. | Proteção de dados / Evidência | `REG-MEC-API-0001-028`; `REG-MEC-API-0001-029` | `DE` | Proposto |
| `RNF-MEC-API-0001-014` | O cliente deve reutilizar o token enquanto válido, reduzindo chamadas de autenticação desnecessárias. | Eficiência operacional | `REG-MEC-API-0001-015` | `DE` | Proposto |
| `RNF-MEC-API-0001-015` | A renovação do token deve ocorrer sem interromper indevidamente operações válidas e conforme o comportamento oficial da API. | Confiabilidade | `REG-MEC-API-0001-013`; `REG-MEC-API-0001-014` | `DE / PC` | Proposto |
| `RNF-MEC-API-0001-016` | O processamento de lotes deve ser acompanhado sem presumir sucesso imediato da operação de envio. | Confiabilidade | `REG-MEC-API-0001-022`; `REG-MEC-API-0001-023`; `REG-MEC-API-0001-024` | `DE` | Proposto |
| `RNF-MEC-API-0001-017` | Cada lote deve permanecer correlacionado à operação local que o originou durante todo o acompanhamento de status e erros. | Rastreabilidade | `REG-MEC-API-0001-023`; `REG-MEC-API-0001-024`; `REG-MEC-API-0001-029` | `DE` | Proposto |
| `RNF-MEC-API-0001-018` | Registros de integração devem identificar, no mínimo, a operação executada, o ambiente utilizado, o resultado obtido e a correlação disponível. | Observabilidade | `REG-MEC-API-0001-028`; `REG-MEC-API-0001-029` | `DE` | Proposto |
| `RNF-MEC-API-0001-019` | Em caso de erro, a evidência deve preservar o código retornado, a mensagem recebida e o contexto necessário para reprodução. | Observabilidade / Diagnóstico | `REG-MEC-API-0001-029` | `DE` | Proposto |
| `RNF-MEC-API-0001-020` | Respostas inesperadas e divergências entre documentação e comportamento devem ser registradas de forma pesquisável e vinculadas ao teste correspondente. | Auditabilidade | `REG-MEC-API-0001-028` | `DE` | Proposto |
| `RNF-MEC-API-0001-021` | Erros de pré-validação devem ser distinguíveis de erros ocorridos durante o processamento de lotes. | Diagnóstico | `REG-MEC-API-0001-021`; `REG-MEC-API-0001-024` | `DE` | Proposto |
| `RNF-MEC-API-0001-022` | Testes de homologação devem ser reproduzíveis, com identificação da operação, dados de entrada controlados e resultado observado. | Testabilidade | `REG-MEC-API-0001-005`; `REG-MEC-API-0001-006`; `REG-MEC-API-0001-028`; `REG-MEC-API-0001-029` | `DE` | Proposto |
| `RNF-MEC-API-0001-023` | A suíte de homologação deve cobrir ausência de campos obrigatórios, tipos incorretos e atributos inválidos. | Testabilidade | `REG-MEC-API-0001-019`; `REG-MEC-API-0001-020`; `REG-MEC-API-0001-021` | `DE` | Proposto |
| `RNF-MEC-API-0001-024` | A suíte de homologação deve cobrir as operações declaradas para instituições de ensino e profissionais da educação. | Cobertura de testes | `REG-MEC-API-0001-025`; `REG-MEC-API-0001-026` | `DE` | Proposto |
| `RNF-MEC-API-0001-025` | Filtros, ordenação e paginação devem ser testados conforme os parâmetros definidos pela documentação técnica vigente. | Testabilidade | `REG-MEC-API-0001-027` | `DE / PC` | Proposto |
| `RNF-MEC-API-0001-026` | Swagger UI, Redocly e o contrato OpenAPI aplicável devem ser tratados como referências técnicas para testes de contrato e revisão de compatibilidade. | Manutenibilidade / Conformidade | `REG-MEC-API-0001-008`; `REG-MEC-API-0001-010` | `DE` | Proposto |
| `RNF-MEC-API-0001-027` | A ativação em produção deve permanecer bloqueada até a conclusão da homologação, a disponibilidade das credenciais e a validação do contrato técnico aplicável. | Segurança operacional | `REG-MEC-API-0001-002`; `REG-MEC-API-0001-006`; `REG-MEC-API-0001-010` | `DE` | Proposto |

## Agrupamento por atributo de qualidade

| Atributo | Requisitos |
|---|---|
| Segurança e configuração | `RNF-MEC-API-0001-001` a `RNF-MEC-API-0001-005` |
| Interoperabilidade e conformidade | `RNF-MEC-API-0001-006` a `RNF-MEC-API-0001-010` |
| Proteção de dados | `RNF-MEC-API-0001-011` a `RNF-MEC-API-0001-013` |
| Eficiência, confiabilidade e rastreabilidade | `RNF-MEC-API-0001-014` a `RNF-MEC-API-0001-017` |
| Observabilidade e auditabilidade | `RNF-MEC-API-0001-018` a `RNF-MEC-API-0001-021` |
| Testabilidade, manutenibilidade e operação | `RNF-MEC-API-0001-022` a `RNF-MEC-API-0001-027` |

## Dependências de validação

Antes da promoção, devem ser confirmados:

- contrato completo da autenticação e da renovação do token;
- esquemas oficiais de payload e resposta;
- política de versionamento e compatibilidade;
- parâmetros de filtros, ordenação e paginação;
- comportamento observado das respostas `422`;
- estados e transições oficiais do processamento de lotes;
- requisitos operacionais para liberação em produção.

## Limites deste artefato

A cartilha não define metas quantitativas de desempenho, disponibilidade, latência, capacidade, retenção de logs ou recuperação de desastre. Portanto, este dossiê não estabelece valores para esses atributos.

Tais metas exigem fonte oficial complementar, decisão arquitetural aprovada ou evidência operacional.

## Regra de promoção

A promoção para `03-conhecimento-consolidado/requisitos/` exige rastreabilidade entre:

```text
fonte → regra → requisito não funcional → controle técnico → teste → evidência
```

Requisitos não confirmados devem permanecer neste dossiê com estado `Proposto`.
