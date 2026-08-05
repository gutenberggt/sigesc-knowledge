# 12 — Impacto no SIGESC

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Contexto interno relacionado | Arquitetura MIG/CMDE previamente documentada no projeto SIGESC |
| Estado | Análise de impacto em revisão |
| Última revisão | 2026-08-05 |

## Estado deste artefato

Este documento confronta as exigências e orientações extraídas da fonte `MEC-API-0001` com o estado arquitetural conhecido do SIGESC/MIG.

A análise:

- não substitui a documentação oficial da arquitetura do SIGESC;
- não redefine componentes já documentados no código ou no SIGESC Docs;
- não representa auditoria atualizada do código-fonte;
- não autoriza implementação ou ativação produtiva;
- registra impactos, lacunas e decisões que precisam ser tratadas nos repositórios oficiais do sistema.

As afirmações sobre o estado do SIGESC/MIG devem ser reconfirmadas contra o código e a documentação técnica vigentes antes de qualquer execução.

## Convenções

- `DE`: derivação de engenharia baseada na fonte e no contexto técnico conhecido do SIGESC/MIG;
- `DE / PC`: impacto derivado cuja conclusão depende do contrato oficial ou de nova verificação técnica;
- `PA`: decisão arquitetural proposta;
- `Alinhado`: a arquitetura existente oferece mecanismo conceitualmente compatível;
- `Parcial`: existe base reutilizável, mas falta adaptação ou confirmação;
- `Ausente`: capacidade específica ainda não está representada no estado conhecido;
- `Bloqueado`: não pode avançar sem dependência externa ou decisão formal.

## Síntese executiva

A arquitetura MIG já estabelecida possui fundamentos compatíveis com uma integração externa assíncrona:

- cliente HTTP centralizado;
- separação entre núcleo reutilizável e provider específico;
- validação e mapeamento;
- idempotência;
- fila durável;
- worker e retry;
- auditoria e métricas;
- feature flags;
- scheduler desabilitado por padrão;
- controles multi-tenant e estratégia `fail-closed`.

Esse alinhamento é **arquitetural**, não contratual.

A fonte atual não fornece elementos suficientes para declarar a integração pronta, porque permanecem ausentes ou incompletos:

- contrato oficial da autenticação;
- credenciais reais;
- contrato OpenAPI versionado;
- rota e schema de submissão dos lotes;
- estados oficiais e estrutura de erros;
- contratos dos módulos de instituições e profissionais;
- regras de autorização;
- evidências de homologação real.

### Veredito

| Dimensão | Avaliação | Fundamentação |
|---|---|---|
| Fundação arquitetural | Alinhada | O MIG possui separação de camadas, fila, workers, retry, auditoria, métricas e feature flags. |
| Compatibilidade com lotes assíncronos | Parcial | A infraestrutura é compatível, mas o contrato oficial de submissão, estados e erros não está consolidado. |
| Autenticação oficial | Bloqueada | Endpoint, payload, resposta e credenciais não estão confirmados pela cartilha. |
| Instituições de ensino | Ausente no escopo conhecido | A fonte cita operações, mas o estado conhecido do MIG está concentrado em frequência e infraestrutura genérica. |
| Profissionais da educação | Ausente no escopo conhecido | Não há contrato consolidado nem provider específico documentado para essas operações. |
| Homologação real | Bloqueada | Faltam credenciais, contrato versionado e evidências contra o ambiente oficial. |
| Produção | Bloqueada | A cartilha e o estado conhecido não sustentam ativação produtiva. |

## Componentes potencialmente afetados

| ID | Componente ou domínio | Estado conhecido no SIGESC/MIG | Impacto esperado | Avaliação | Classificação |
|---|---|---|---|---|---|
| `CMP-MEC-API-0001-001` | Configuração de ambientes | Há configuração hierárquica e feature flags por ambiente e tenant. | Incluir URLs oficiais, referências de contrato e segregação completa entre homologação e produção. | Parcial | `DE` |
| `CMP-MEC-API-0001-002` | Gestão de segredos e credenciais | O desenho prevê configuração externa, mas credenciais oficiais não estão disponíveis. | Integrar referência segura de segredo, rotação, revogação e auditoria de uso. | Bloqueado | `DE` |
| `CMP-MEC-API-0001-003` | Cliente HTTP centralizado | A arquitetura exige que toda saída externa passe por cliente único. | Adaptar autenticação, cabeçalhos, timeouts e tratamento de respostas ao contrato oficial. | Alinhado | `DE` |
| `CMP-MEC-API-0001-004` | Provider CMDE | Existe abstração de provider e simulador para evitar chamadas reais. | Implementar provider oficial somente após contrato e credenciais confirmados. | Parcial | `DE` |
| `CMP-MEC-API-0001-005` | Gerenciador de token | O fluxo conceitual de autenticação está previsto, sem contrato oficial consolidado. | Implementar cache, validade, renovação e falhas conforme a API oficial. | Bloqueado | `DE` |
| `CMP-MEC-API-0001-006` | DTOs e schemas externos | Há camada prevista para DTOs específicos do CMDE. | Versionar schemas de autenticação, lotes, instituições, profissionais e erros. | Parcial | `DE` |
| `CMP-MEC-API-0001-007` | Mapeadores | A arquitetura separa mapeamento externo da regra de negócio. | Aplicar `snake_case`, preservar mapeamentos de planilha e evitar acoplamento ao modelo interno. | Alinhado | `DE` |
| `CMP-MEC-API-0001-008` | Validação | Há infraestrutura para validação antes do envio. | Validar campos, tipos e atributos contra schemas oficiais versionados. | Parcial | `DE` |
| `CMP-MEC-API-0001-009` | Tratamento de HTTP `422` | O tratamento genérico de erros existe como preocupação arquitetural. | Criar normalização específica dos detalhes de pré-validação. | Parcial | `DE` |
| `CMP-MEC-API-0001-010` | Batch builder | Existe construção de lotes para o fluxo de frequência a partir da SSoT. | Revalidar o formato contra o contrato oficial e separar builders por recurso quando necessário. | Parcial | `DE` |
| `CMP-MEC-API-0001-011` | Fila durável | Há fila Mongo com lease, backpressure e estados internos. | Correlacionar itens locais ao `lote_id` e distinguir estados internos dos estados oficiais. | Alinhado | `DE` |
| `CMP-MEC-API-0001-012` | Worker e retry | Há worker com retry, auditoria, métricas e correlation ID. | Ajustar política de repetição para erros de transporte, autenticação, validação e processamento. | Parcial | `DE` |
| `CMP-MEC-API-0001-013` | Scheduler | Existe scheduler desabilitado por padrão, controlado por tenant, janela e lock. | Manter desabilitado até homologação; revisar cadência de acompanhamento de lotes. | Alinhado | `DE` |
| `CMP-MEC-API-0001-014` | Idempotência | Há chave determinística e armazenamento de idempotência. | Confirmar a composição da chave e o comportamento oficial de reenvio por operação. | Parcial | `DE` |
| `CMP-MEC-API-0001-015` | Auditoria e evidências | Há persistência de eventos MIG e correlação. | Sanitizar payloads, separar pré-validação de erro de lote e vincular evidências de homologação. | Parcial | `DE` |
| `CMP-MEC-API-0001-016` | Métricas e monitoramento | Há métricas operacionais e painel técnico. | Incluir métricas por ambiente, operação, status oficial, HTTP `422` e divergência documental. | Parcial | `DE` |
| `CMP-MEC-API-0001-017` | Controles multi-tenant | A estratégia conhecida é hierárquica e `fail-closed`. | Garantir isolamento de configuração, credencial, lote, evidência e autorização por tenant. | Alinhado | `DE` |
| `CMP-MEC-API-0001-018` | Dashboard administrativo e suporte | Existe painel técnico para estado, métricas, auditoria e flags. | Incorporar visão de homologação, contratos, lotes, erros sanitizados e chamados oficiais. | Parcial | `DE` |

## Relação com a arquitetura conhecida do MIG

```text
backend/mig/
├── core/
│   ├── http_client
│   ├── retry
│   ├── audit
│   ├── monitoring
│   ├── validation
│   ├── mapping
│   ├── feature_flags
│   └── exceptions
├── providers/
│   └── base
└── cmde/
    ├── client
    ├── config
    ├── dtos
    ├── mapper
    ├── validators
    ├── batch_builder
    ├── queue
    ├── worker
    ├── scheduler
    └── service
```

A representação acima resume o contexto arquitetural previamente documentado. O repositório de código e o SIGESC Docs continuam sendo as autoridades para nomes, caminhos e implementação vigentes.

**Classificação:** `DE`.

## Alinhamentos que devem ser preservados

1. Toda comunicação externa deve continuar passando pelo cliente oficial único.
2. Routers devem permanecer sem regra de negócio.
3. Serviços não devem executar HTTP diretamente.
4. Componentes específicos do CMDE devem continuar isolados de `mig/core`.
5. Produção deve permanecer desabilitada por padrão.
6. Feature flags devem continuar hierárquicas e `fail-closed`.
7. Idempotência, correlação, auditoria e métricas devem acompanhar todo envio.
8. A fila local não deve confundir seus estados com estados oficiais do lote.
9. Dados da SSoT devem ser mapeados, não duplicados como nova fonte de verdade.
10. Erros e evidências não devem expor tokens, credenciais ou dados pessoais desnecessários.

**Classificação:** `DE`.

## GAPs

| ID | Situação exigida ou esperada | Situação conhecida no SIGESC/MIG | Impacto | Classificação |
|---|---|---|---|---|
| `GAP-MEC-API-0001-001` | Contrato completo da autenticação. | A cartilha informa Bearer, mas não define endpoint, método, payload e resposta. | Bloqueia o cliente oficial de autenticação. | `DE / PC` |
| `GAP-MEC-API-0001-002` | Credenciais válidas de homologação e produção. | Não há credenciais oficiais disponíveis no contexto documentado. | Bloqueia homologação real e produção. | `DE / PC` |
| `GAP-MEC-API-0001-003` | Contrato OpenAPI versionado e preservado. | A arquitetura prevê DTOs, mas não há snapshot oficial consolidado neste dossiê. | Impede testes de contrato e versionamento confiável. | `DE / PC` |
| `GAP-MEC-API-0001-004` | Provider oficial ativo. | O provider conhecido permanece simulador, sem chamadas reais ao MEC. | Exige implementação posterior, preservando o simulador para testes. | `DE` |
| `GAP-MEC-API-0001-005` | Ciclo de vida oficial do token. | Reutilização e renovação são conhecidas apenas em nível introdutório. | Impede fechar cache, expiração e recuperação de falhas. | `DE / PC` |
| `GAP-MEC-API-0001-006` | Schemas completos de payload e resposta. | A camada existe, mas os contratos dos recursos não estão consolidados. | Impede DTOs definitivos e validação estrita. | `DE / PC` |
| `GAP-MEC-API-0001-007` | Schema dos detalhes HTTP `422`. | Há necessidade de tratamento, mas a estrutura oficial não está definida. | Impede normalização completa da pré-validação. | `DE / PC` |
| `GAP-MEC-API-0001-008` | Rota e contrato de submissão de lotes. | A cartilha apresenta listagem, status e erros, não a submissão completa. | Impede fechar o fluxo assíncrono ponta a ponta. | `DE / PC` |
| `GAP-MEC-API-0001-009` | Estados e transições oficiais dos lotes. | A fila possui estados internos próprios. | Exige tabela explícita de tradução sem equivalência presumida. | `DE / PC` |
| `GAP-MEC-API-0001-010` | Schema oficial dos erros de lote. | A consulta é conhecida, mas o formato dos erros não. | Impede normalização, correção e métricas definitivas. | `DE / PC` |
| `GAP-MEC-API-0001-011` | Lote de frequência compatível com o contrato vigente. | O batch builder existente foi construído a partir da SSoT de frequência, ainda sem validação contratual completa. | Pode exigir adaptação de campos, agrupamento e versão. | `DE / PC` |
| `GAP-MEC-API-0001-012` | Operações de instituições de ensino. | Não há provider funcional documentado para listar, cadastrar e editar instituições. | Exige novo domínio específico dentro de `mig/cmde`. | `DE` |
| `GAP-MEC-API-0001-013` | Operações de profissionais da educação. | Não há provider funcional documentado para listar, cadastrar e editar profissionais. | Exige novo domínio específico dentro de `mig/cmde`. | `DE` |
| `GAP-MEC-API-0001-014` | Gestão de vínculos, funções e formações. | Não há contratos nem serviços específicos documentados. | Exige DTOs, mapeadores, validações, autorização e testes próprios. | `DE` |
| `GAP-MEC-API-0001-015` | Filtros, ordenação e paginação confirmados. | A infraestrutura pode suportar parâmetros, mas o contrato não está disponível. | Impede implementar consultas compatíveis. | `DE / PC` |
| `GAP-MEC-API-0001-016` | Compatibilidade formal com planilhas em caixa alta. | O mapeamento entre planilha e API não está comprovado no contexto conhecido. | Exige camada de tradução separada e testes. | `DE / PC` |
| `GAP-MEC-API-0001-017` | Política completa de sanitização de evidências. | Auditoria e correlação existem, mas o padrão documental precisa ser formalizado. | Risco de exposição de dados pessoais, payloads ou segredos. | `DE` |
| `GAP-MEC-API-0001-018` | Perfis e permissões para novos recursos. | O MIG possui controles técnicos, mas a matriz externa não está confirmada. | Exige RBAC interno e validação contra autorização oficial. | `DE` |
| `GAP-MEC-API-0001-019` | Testes de contrato e homologação oficial. | Os testes conhecidos usam simulador e infraestrutura local. | Exige suíte contra homologação, evidências e comparação documental. | `DE` |
| `GAP-MEC-API-0001-020` | Critérios de liberação produtiva satisfeitos. | Scheduler e provider oficial devem permanecer desabilitados. | Produção continua formalmente bloqueada. | `DE` |

## Priorização dos GAPs

| Prioridade | GAPs | Justificativa |
|---|---|---|
| `P0 — Bloqueadores externos` | `001`, `002`, `003`, `008` | Sem autenticação, credencial, contrato e submissão não há homologação ponta a ponta. |
| `P1 — Contrato e compatibilidade` | `005`, `006`, `007`, `009`, `010`, `011`, `015`, `016` | Necessários para DTOs, validação, estados, erros e mapeamentos confiáveis. |
| `P2 — Expansão funcional` | `012`, `013`, `014`, `018` | Introduzem instituições, profissionais, relações e permissões. |
| `P3 — Operação e governança` | `004`, `017`, `019`, `020` | Provider oficial, evidências, homologação e liberação produtiva. |

## Decisões necessárias

| ID | Decisão proposta | Motivo | Classificação | Estado |
|---|---|---|---|---|
| `DEC-MEC-API-0001-001` | Manter provider oficial e scheduler produtivo desabilitados por padrão. | Evitar chamadas reais sem contrato, credencial, homologação e aprovação. | `PA` | Proposta |
| `DEC-MEC-API-0001-002` | Preservar o simulador como provider obrigatório para desenvolvimento e testes locais. | Permitir evolução segura sem dependência do MEC. | `PA` | Proposta |
| `DEC-MEC-API-0001-003` | Versionar o contrato OpenAPI oficial por ambiente, data e hash. | Garantir rastreabilidade de DTOs, testes e mudanças. | `PA` | Proposta |
| `DEC-MEC-API-0001-004` | Implementar gerenciador de token separado do cliente de negócio. | Isolar credencial, cache, renovação e falhas de autenticação. | `PA` | Proposta |
| `DEC-MEC-API-0001-005` | Manter um único cliente oficial CMDE para toda saída HTTP. | Preservar auditoria, retry, segurança e consistência arquitetural. | `PA` | Proposta |
| `DEC-MEC-API-0001-006` | Separar DTOs e mapeadores por recurso e versão do contrato. | Evitar acoplamento entre frequência, instituições e profissionais. | `PA` | Proposta |
| `DEC-MEC-API-0001-007` | Criar tabela explícita de tradução entre estados oficiais e estados internos da fila. | Impedir equivalências implícitas e perda de semântica. | `PA` | Proposta |
| `DEC-MEC-API-0001-008` | Separar erros de transporte, autenticação, HTTP `422` e processamento de lote. | Permitir retry, diagnóstico e métricas corretos. | `PA` | Proposta |
| `DEC-MEC-API-0001-009` | Reutilizar a infraestrutura de fila apenas quando a semântica do recurso for compatível. | Evitar forçar instituições e profissionais ao modelo de frequência. | `PA` | Proposta |
| `DEC-MEC-API-0001-010` | Formalizar padrão de evidência sanitizada com hash, correlação e referência ao contrato. | Proteger dados e sustentar auditoria de homologação. | `PA` | Proposta |
| `DEC-MEC-API-0001-011` | Exigir revisão de RBAC, tenant e feature flags antes de cada novo recurso externo. | Preservar menor privilégio e isolamento multi-tenant. | `PA` | Proposta |
| `DEC-MEC-API-0001-012` | Adotar gate formal de `go/no-go` para produção. | Centralizar verificação de contrato, credencial, testes, evidências, monitoramento e revogação. | `PA` | Proposta |

## Gate proposto de prontidão

### Para homologação real

- contrato de autenticação confirmado;
- credencial de homologação disponível;
- OpenAPI preservado e identificado;
- schemas do cenário implementados;
- massa de dados não real;
- feature flag restrita ao tenant de teste;
- auditoria, correlação e sanitização habilitadas;
- rollback e revogação previstos.

### Para produção

Além dos requisitos de homologação:

- evidências aprovadas;
- credencial produtiva protegida;
- autorização formal;
- contrato e versão congelados para a liberação;
- matriz de acesso aprovada;
- monitoramento e alertas ativos;
- scheduler e provider habilitados explicitamente;
- plano de resposta a falhas;
- decisão `go/no-go` registrada.

**Classificação:** `PA`.

## Impacto por fase de evolução

| Fase | Resultado esperado | Produção permitida |
|---|---|---|
| `Fase A — Contrato` | Obter autenticação, OpenAPI, schemas e regras oficiais. | Não |
| `Fase B — Adaptação` | Implementar provider, DTOs, mapeadores e tratamento de erros. | Não |
| `Fase C — Homologação` | Executar testes oficiais e registrar evidências. | Não |
| `Fase D — Hardening` | Revisar segurança, RBAC, métricas, revogação e operação. | Não |
| `Fase E — Go/No-Go` | Avaliar todos os critérios e registrar decisão. | Somente após aprovação |
| `Fase F — Operação controlada` | Ativar por tenant, ambiente, operação e janela monitorada. | Sim, de forma restrita |

**Classificação:** `PA`.

## Conclusão

A fonte confirma que o desenho assíncrono, a autenticação Bearer, a pré-validação e o acompanhamento de lotes precisam ser considerados pela integração.

O MIG possui uma base arquitetural adequada para receber esse contrato, mas ainda não possui comprovação suficiente para operação oficial.

A orientação resultante é:

```text
preservar a arquitetura existente
→ obter o contrato oficial
→ adaptar componentes específicos
→ homologar com evidências
→ endurecer controles
→ decidir go/no-go
```

Até que esse ciclo seja concluído, o provider oficial e a operação produtiva devem permanecer bloqueados.

## Regra de promoção

A promoção desta análise para decisões ou requisitos consolidados exige rastreabilidade entre:

```text
fonte → regra → requisito → impacto → GAP → decisão → implementação → teste → evidência
```

Decisões classificadas como `PA` devem ser registradas no mecanismo oficial de decisões arquiteturais do SIGESC antes da implementação.
