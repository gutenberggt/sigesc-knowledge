# 14 — Rastreabilidade

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Escopo | Rastreabilidade documental e analítica do dossiê |
| Estado | Matriz em revisão; evidências operacionais pendentes |
| Última revisão | 2026-08-05 |

## Objetivo

Esta matriz conecta, de ponta a ponta:

```text
fonte → regra → requisito → caso de uso → fluxo
→ dado ou integração → impacto → GAP → decisão
→ oportunidade → teste → evidência
```

O objetivo é permitir que cada conclusão do dossiê seja verificada até sua origem e que nenhuma proposta seja confundida com determinação oficial.

## Limites

Esta matriz:

- registra rastreabilidade documental;
- não comprova implementação;
- não comprova homologação;
- não substitui o contrato OpenAPI;
- não substitui o código ou o SIGESC Docs;
- não autoriza ativação do provider oficial;
- não transforma propostas `PA` em decisões aprovadas.

Quando a coluna de evidência indicar pendência, isso significa que o dossiê ainda não contém comprovação operacional do comportamento.

## Convenções

- `DE`: cadeia derivada com sustentação documental suficiente para análise;
- `DE / PC`: cadeia cuja confirmação depende do contrato técnico ou de homologação;
- `PA`: elemento proposto, ainda sujeito a decisão arquitetural;
- `Pendente`: teste ou evidência ainda não produzido neste dossiê;
- `Bloqueado`: execução impedida por contrato, credencial ou aprovação ausente.

## Cobertura dos artefatos

| ID | Artefato | Identificadores cobertos | Quantidade | Papel na rastreabilidade |
|---|---|---|---:|---|
| `COV-MEC-API-0001-001` | Regras e restrições | `REG-MEC-API-0001-001` a `029` | 29 | Origem normativa, operacional e técnica extraída da fonte. |
| `COV-MEC-API-0001-002` | Requisitos funcionais | `RF-MEC-API-0001-001` a `030` | 30 | Capacidades funcionais derivadas. |
| `COV-MEC-API-0001-003` | Requisitos não funcionais | `RNF-MEC-API-0001-001` a `027` | 27 | Controles de segurança, conformidade, confiabilidade e teste. |
| `COV-MEC-API-0001-004` | Casos de uso | `UC-MEC-API-0001-001` a `020` | 20 | Intenções operacionais e resultados esperados. |
| `COV-MEC-API-0001-005` | Fluxos operacionais | `FLX-MEC-API-0001-001` a `008` | 8 | Sequências derivadas para homologação e integração. |
| `COV-MEC-API-0001-006` | Modelo de dados | `DAD-MEC-API-0001-001` a `020`; `MAP-MEC-API-0001-001` a `016` | 36 | Conceitos identificados e estruturas internas propostas. |
| `COV-MEC-API-0001-007` | Perfis e permissões | `ATO`, `AUT-PC`, `PER` e `ACL` de `MEC-API-0001` | 40 | Atores, lacunas de autorização, perfis e permissões propostos. |
| `COV-MEC-API-0001-008` | Integrações | `INT-MEC-API-0001-001` a `016`; `DEP-MEC-API-0001-001` a `012` | 28 | Interfaces externas e dependências técnicas. |
| `COV-MEC-API-0001-009` | Impacto no SIGESC | `CMP-MEC-API-0001-001` a `018` | 18 | Componentes potencialmente afetados. |
| `COV-MEC-API-0001-010` | GAPs | `GAP-MEC-API-0001-001` a `020` | 20 | Lacunas contratuais, funcionais e operacionais. |
| `COV-MEC-API-0001-011` | Decisões propostas | `DEC-MEC-API-0001-001` a `012` | 12 | Propostas que exigem decisão arquitetural formal. |
| `COV-MEC-API-0001-012` | Oportunidades | `OM-MEC-API-0001-001` a `024` | 24 | Melhorias derivadas e propostas de evolução. |
| `COV-MEC-API-0001-013` | Evidências operacionais | A criar em `05-evidencias/` | 0 | Comprovação futura de testes, respostas e decisões. |

## Matriz de rastreabilidade ponta a ponta

| ID | Tema e origem | Regra e requisito | Caso de uso e fluxo | Dado, integração ou controle | Impacto, GAP e decisão | Teste e evidência | Classificação | Estado |
|---|---|---|---|---|---|---|---|---|
| `TRC-MEC-API-0001-001` | CMDEB e nova versão; fonte p. 2 | `REG-MEC-API-0001-001` | Contexto transversal | `INT-MEC-API-0001-001` | Revisar contrato e escopo vigente antes da implementação | Verificação documental da versão e da base normativa; evidência operacional não aplicável | `DE` | Rastreado documentalmente |
| `TRC-MEC-API-0001-002` | Separação entre homologação e produção; pp. 2–3 | `REG-002`; `RF-005`; `RNF-003`, `010`, `027` | `UC-001`; `FLX-001` | `DAD-001`; `INT-002` a `007`; `DEP-001`; `PER-003`, `007` | `CMP-001`, `013`, `017`; `GAP-002`, `020`; `DEC-001`, `011`, `012`; `OM-011`, `024` | Testar resolução de ambiente, bloqueio cruzado e feature flags; evidência pendente | `DE` | Homologação pendente |
| `TRC-MEC-API-0001-003` | Descarte de dados e restrição a dados reais; p. 2 | `REG-003`, `004`; `RNF-011` a `013` | `UC-018`; `FLX-001` | `DEP-011`; `ACL-007`, `014` | `CMP-015`; `GAP-017`; `DEC-010`; `OM-003`, `007`, `015` | Testar massa sintética, sanitização e ausência de dados reais; evidência pendente | `DE` | Controle proposto |
| `TRC-MEC-API-0001-004` | Swagger UI, Redocly e contrato; p. 3 | `REG-008`, `010`; `RNF-008`, `026` | `UC-003`, `017`; `FLX-002` | `DAD-002`; `INT-004` a `007`; `DEP-005` | `CMP-006`, `008`; `GAP-003`, `006`; `DEC-003`, `006`; `OM-001`, `002`, `009`, `012`, `016` | Capturar OpenAPI, hash e versão; executar testes de contrato; evidência pendente | `DE / PC` | Contrato oficial pendente |
| `TRC-MEC-API-0001-005` | Autenticação Bearer e rota não detalhada; p. 4 | `REG-011`, `012`; `RF-001`; `RNF-001`, `005` | `UC-002`; `FLX-003` | `DAD-003`, `004`; `INT-008`, `009`; `DEP-002`, `003` | `CMP-002`, `003`, `005`; `GAP-001`, `002`; `DEC-004`, `005`; `OM-010`, `023` | Testar autenticação somente após contrato e credencial de homologação; bloqueado | `DE / PC` | Bloqueado |
| `TRC-MEC-API-0001-006` | Validade, renovação e reutilização do token; p. 4 | `REG-013` a `015`; `RF-002`, `003`; `RNF-005`, `014`, `015` | `UC-002`; `FLX-003` | `DAD-004`; `DEP-004`; `MAP-003` | `CMP-005`; `GAP-005`; `DEC-004`; `OM-010` | Testar cache, expiração, renovação e falhas; contrato e evidência pendentes | `DE / PC` | Contrato pendente |
| `TRC-MEC-API-0001-007` | Cabeçalho `Authorization`; p. 4 | `REG-016`; `RF-004`; `RNF-004` | `UC-002`; `FLX-003` | `DAD-005`; `INT-009`; `ACL-007`, `008` | `CMP-003`; `GAP-001`; `DEC-005` | Testar formato do cabeçalho e mascaramento do token; evidência pendente | `DE` | Teste pendente |
| `TRC-MEC-API-0001-008` | Atributos da API em `snake_case`; p. 4 | `REG-017`; `RF-006`; `RNF-006` | `UC-003`; `FLX-004` | `DAD-006`; `DEP-006`; mapeadores | `CMP-007`; `GAP-006`; `DEC-006`; `OM-012` | Testar serialização contra schema oficial; contrato pendente | `DE` | Teste de contrato pendente |
| `TRC-MEC-API-0001-009` | Cabeçalhos de planilha em caixa alta; p. 4 | `REG-018`; `RF-007`; `RNF-007` | Fluxo de compatibilidade a definir | `INT-013`; `DEP-007` | `CMP-007`; `GAP-016`; `DEC-006`; `OM-019` | Testar conversão planilha ↔ API sem perda semântica; evidência pendente | `DE` | Mapeamento pendente |
| `TRC-MEC-API-0001-010` | Pré-validação de obrigatoriedade, tipos e atributos; p. 5 | `REG-019`, `020`; `RF-008` a `010`; `RNF-008`, `023` | `UC-003`; `FLX-004` | `DAD-006`, `007`; `DEP-005`; validators | `CMP-008`; `GAP-006`; `DEC-006`; `OM-004`, `012`, `016` | Executar matriz de testes negativos contra schemas oficiais; evidência pendente | `DE / PC` | Schema pendente |
| `TRC-MEC-API-0001-011` | Resposta HTTP `422`; p. 5 | `REG-021`; `RF-011`; `RNF-009`, `021`, `023` | `UC-004`; `FLX-004` | `DAD-007`; `DEP-008`; `MAP-007` | `CMP-009`; `GAP-007`; `DEC-008`; `OM-004`, `005`, `014` | Testar e preservar código, detalhes e distinção de erro; schema e evidência pendentes | `DE / PC` | Schema de erro pendente |
| `TRC-MEC-API-0001-012` | Listagem de lotes; p. 5 | `REG-022`; `RF-012`; `RNF-010`, `016` | `UC-005`; `FLX-005` | `DAD-008`, `009`; `INT-010`; `DEP-009`, `010` | `CMP-011`; `GAP-008`, `009`; `DEC-007`; `OM-013`, `014` | Testar `/api/v2/lotes`, paginação e correlação; evidência pendente | `DE` | Teste pendente |
| `TRC-MEC-API-0001-013` | Consulta de status por `lote_id`; p. 5 | `REG-023`; `RF-013`, `015`, `016`; `RNF-016`, `017` | `UC-006`; `FLX-005` | `DAD-008` a `010`; `MAP-008`, `009`; `INT-010` | `CMP-011`, `016`; `GAP-009`; `DEC-007`; `OM-013`, `021` | Testar estados, transições, polling e terminalidade; contrato pendente | `DE / PC` | Estados oficiais pendentes |
| `TRC-MEC-API-0001-014` | Consulta de erros do lote; p. 5 | `REG-024`; `RF-014` a `016`; `RNF-009`, `017`, `019`, `021` | `UC-007`; `FLX-005` | `DAD-011`; `MAP-010`; `INT-010`; `DEP-008`, `010` | `CMP-009`, `012`, `015`, `016`; `GAP-010`; `DEC-008`; `OM-005`, `014`, `021` | Testar schema, correlação, retry e diagnóstico; evidência pendente | `DE / PC` | Schema pendente |
| `TRC-MEC-API-0001-015` | Listagem e filtro de instituições; p. 6 | `REG-025`; `RF-017`, `020`; `RNF-024`, `025` | `UC-008`, `017`; `FLX-006` | `DAD-012`, `013`; `INT-011`; `MAP-011` | `CMP-006` a `008`; `GAP-012`, `015`; `DEC-006`, `009`; `OM-006`, `016`, `018` | Testar listagem e consulta por código INEP; contrato e evidência pendentes | `DE / PC` | Contrato do módulo pendente |
| `TRC-MEC-API-0001-016` | Cadastro e edição de instituições; p. 6 | `REG-025`; `RF-018`, `019`; `RNF-024` | `UC-009`, `010`; `FLX-006` | `DAD-012`; `INT-011`; `MAP-011` | `CMP-006` a `008`; `GAP-012`; `DEC-006`, `009`; `OM-016`, `018` | Testar cenários válidos, inválidos e lotes relacionados; contrato pendente | `DE / PC` | Contrato do módulo pendente |
| `TRC-MEC-API-0001-017` | Listagem e filtro de profissionais; pp. 6–7 | `REG-026`, `027`; `RF-021`, `027`, `030`; `RNF-024`, `025` | `UC-011`, `017`; `FLX-007` | `DAD-014`, `015`, `019`; `INT-012`; `MAP-012`, `014` | `CMP-006` a `008`; `GAP-013`, `015`; `DEC-006`, `009`; `OM-006`, `016`, `018` | Testar listagem e consulta por CPF; contrato e evidência pendentes | `DE / PC` | Contrato do módulo pendente |
| `TRC-MEC-API-0001-018` | Cadastro e edição de profissionais; p. 6 | `REG-026`; `RF-022`, `023`; `RNF-024` | `UC-012`, `013`; `FLX-007` | `DAD-014`; `INT-012`; `MAP-012` | `CMP-006` a `008`; `GAP-013`; `DEC-006`, `009`; `OM-016`, `018` | Testar cenários válidos, inválidos e lotes relacionados; contrato pendente | `DE / PC` | Contrato do módulo pendente |
| `TRC-MEC-API-0001-019` | Vínculos, funções e formações; p. 6 | `REG-026`; `RF-024` a `026`; `RNF-024` | `UC-014` a `016`; `FLX-007` | `DAD-016` a `018`; `INT-012`; `MAP-013` | `CMP-006` a `008`; `GAP-014`; `DEC-006`, `009`; `OM-016`, `018` | Testar cada operação e transição permitida; contratos e evidências pendentes | `DE / PC` | Contratos pendentes |
| `TRC-MEC-API-0001-020` | Filtros, ordenação e paginação; p. 7 | `REG-027`; `RF-020`, `027`, `030`; `RNF-025` | `UC-017`; `FLX-002`, `006`, `007` | `DAD-019`; `MAP-014`; parâmetros dos módulos | `GAP-015`; `DEC-006`; `OM-006`, `016` | Executar cenários reproduzíveis por operação; parâmetros e evidência pendentes | `DE / PC` | Parâmetros pendentes |
| `TRC-MEC-API-0001-021` | Observações, respostas inesperadas e divergências; p. 7 | `REG-028`; `RF-028`; `RNF-013`, `018`, `020`, `022` | `UC-018`; `FLX-008` | `DAD-020`; `MAP-015`; `DEP-012`; `ACL-014`, `015` | `CMP-015`, `018`; `GAP-017`, `019`; `DEC-010`; `OM-003`, `015`, `016`, `020`, `022` | Criar evidência sanitizada, reproduzível e vinculada ao contrato; pendente | `DE` | Evidência operacional pendente |
| `TRC-MEC-API-0001-022` | Registro de erro com código, payload, mensagem e operação; p. 7 | `REG-029`; `RF-029`; `RNF-002`, `009`, `013`, `018`, `019`, `021`, `022` | `UC-019`; `FLX-008` | `DAD-020`; `DEP-008`, `012`; `MAP-006`, `007`, `010`, `015` | `CMP-015`, `016`; `GAP-007`, `010`, `017`, `019`; `DEC-008`, `010`; `OM-003`, `005`, `014`, `015` | Testar sanitização, correlação e reprodução; evidência pendente | `DE` | Evidência operacional pendente |
| `TRC-MEC-API-0001-023` | Canais técnicos e institucionais; pp. 7–8 | `REG-010`, `029`; requisitos de diagnóstico | `UC-020`; `FLX-008` | `INT-014` a `016`; `MAP-016`; `DEP-012`; `ACL-016` | `CMP-018`; `OM-008`, `020`, `022` | Preparar pacote sanitizado e vincular protocolo ou resposta; evidência pendente | `DE` | Processo de suporte pendente |
| `TRC-MEC-API-0001-024` | Bloqueio de produção e gate `go/no-go`; derivação do conjunto da fonte | `REG-002`, `006`, `010`; `RNF-027` | Fluxo de liberação controlada | `PER-007`, `008`; `ACL-008`, `017`, `018`; feature flags | `CMP-004`, `013`, `017`; `GAP-020`; `DEC-001`, `011`, `012`; `OM-011`, `024` | Validar contrato, credencial, homologação, evidências, monitoramento e revogação | `DE` | Produção bloqueada |

## Matriz de estados de comprovação

| Nível | Significado | Situação atual |
|---|---|---|
| Fonte catalogada | Documento original preservado e identificado por hash. | Concluído |
| Regra extraída | Regra vinculada à página da fonte. | Concluído |
| Requisito derivado | Requisito vinculado às regras de origem. | Concluído, ainda não promovido |
| Caso de uso e fluxo | Comportamento analítico descrito. | Concluído, ainda não validado |
| Contrato técnico | Endpoint, schema e autorização confirmados em contrato versionado. | Parcial ou pendente |
| Implementação | Código oficial revisado contra o contrato. | Fora do escopo deste dossiê |
| Teste de homologação | Cenário executado no ambiente oficial. | Pendente |
| Evidência operacional | Resposta, erro, lote ou resultado preservado e sanitizado. | Pendente |
| Decisão arquitetural | Proposta aprovada no mecanismo oficial do SIGESC. | Pendente |
| Produção | Provider e operações explicitamente autorizados. | Bloqueado |

## Lacunas de rastreabilidade ainda abertas

1. Não há snapshot OpenAPI oficial anexado a este dossiê.
2. Não há contrato completo da autenticação.
3. Não há credencial de homologação registrada como disponível.
4. Não há schema confirmado de submissão de lote.
5. Não há enum confirmado de estados oficiais.
6. Não há schema confirmado dos erros de lote.
7. Não há contratos completos de instituições e profissionais.
8. Não há parâmetros confirmados de filtros, ordenação e paginação.
9. Não há evidências de testes executados contra o ambiente oficial.
10. Não há decisão arquitetural formal aprovando as propostas `PA`.
11. Não há autorização para ativação produtiva.
12. Não há equivalência aprovada entre estados internos e estados externos.

## Regras de manutenção

1. Todo novo requisito deve indicar sua regra de origem.
2. Todo caso de uso deve indicar os requisitos que o sustentam.
3. Todo fluxo deve indicar os casos de uso relacionados.
4. Todo mapeamento deve indicar schema e versão do contrato.
5. Todo GAP deve indicar o item esperado e o estado conhecido.
6. Toda decisão `PA` deve indicar o GAP que pretende tratar.
7. Toda oportunidade deve indicar origem, benefício e prioridade.
8. Todo teste deve indicar ambiente, contrato, entrada controlada e resultado esperado.
9. Toda evidência deve ser sanitizada, identificada por hash e vinculada ao teste.
10. Nenhum item deve ser marcado como validado apenas por existir na cartilha.

## Regra de promoção

A promoção para conhecimento consolidado exige uma cadeia completa:

```text
fonte preservada
→ regra identificada
→ requisito revisado
→ contrato confirmado
→ implementação rastreada
→ teste executado
→ evidência aprovada
→ decisão registrada
```

Enquanto algum elo obrigatório estiver ausente, o item deve permanecer no dossiê como `Proposto`, `Pendente`, `PC` ou `Bloqueado`, conforme o caso.
