# 15 — Notas e pendências

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Estado da análise documental | Concluída para o escopo da fonte |
| Estado da validação técnica | Pendente |
| Estado da homologação oficial | Não iniciada neste dossiê |
| Estado da produção | Bloqueada |
| Última revisão | 2026-08-05 |

## Finalidade

Este arquivo reúne ressalvas, premissas, pendências de confirmação, critérios de revisão e registros editoriais que não devem ser confundidos com requisitos aprovados ou evidências operacionais.

As notas deste artefato complementam os arquivos temáticos do dossiê. Em caso de conflito:

1. a fonte original preservada prevalece sobre a interpretação;
2. o contrato técnico oficial prevalece sobre exemplos introdutórios;
3. evidência de homologação prevalece sobre expectativa não testada;
4. o código e o SIGESC Docs prevalecem quanto à arquitetura vigente do sistema;
5. decisões arquiteturais aprovadas prevalecem sobre propostas `PA`.

## Situação consolidada

| Dimensão | Situação | Observação |
|---|---|---|
| Fonte preservada | Concluída | PDF identificado e protegido por checksum SHA-256. |
| Estrutura documental | Concluída | Páginas e seções da cartilha foram mapeadas. |
| Regras e requisitos derivados | Concluídos em nível analítico | Permanecem propostos até validação contratual e operacional. |
| Casos de uso e fluxos | Concluídos em nível analítico | Não representam comportamento comprovado da API. |
| Modelo de dados | Conceitual | A cartilha não fornece schemas completos. |
| Perfis e permissões | Propostos | A fonte não apresenta matriz oficial de autorização. |
| Integrações | Mapeadas parcialmente | Interfaces conhecidas, contratos incompletos. |
| Impacto no SIGESC | Avaliado documentalmente | Exige reconfirmação contra código e documentação vigentes. |
| Rastreabilidade | Estruturada | Ainda sem evidências operacionais. |
| Homologação real | Pendente | Depende de contrato e credenciais oficiais. |
| Produção | Bloqueada | Não há base para ativação produtiva. |

## Pendências de confirmação

| ID | Questão | Motivo | Responsável ou fonte esperada | Estado |
|---|---|---|---|---|
| `PC-MEC-API-0001-001` | Qual é o endpoint e o método HTTP da autenticação? | A cartilha informa a existência da rota, mas não apresenta seu contrato. | OpenAPI, Swagger UI, Redocly ou orientação técnica oficial | Aberto |
| `PC-MEC-API-0001-002` | Qual é o payload exigido para autenticação? | Necessário para implementar o cliente oficial sem inferência. | Contrato oficial de autenticação | Aberto |
| `PC-MEC-API-0001-003` | Qual é o schema da resposta de autenticação? | Necessário para tratar token, validade, renovação e erros. | Contrato oficial de autenticação | Aberto |
| `PC-MEC-API-0001-004` | A validade atual de 5 minutos permanece vigente? | A própria fonte apresenta a validade como situação atual, sujeita a mudança. | Documentação técnica vigente ou resposta oficial | Aberto |
| `PC-MEC-API-0001-005` | Como funciona exatamente a renovação automática do token? | A cartilha não define gatilho, endpoint, resposta ou comportamento em falha. | Contrato oficial e homologação | Aberto |
| `PC-MEC-API-0001-006` | Como são emitidas, armazenadas, rotacionadas e revogadas as credenciais de homologação? | Sem esse ciclo não é possível executar testes autenticados com segurança. | MEC e gestão segura de segredos do SIGESC | Aberto |
| `PC-MEC-API-0001-007` | Como são emitidas, armazenadas, rotacionadas e revogadas as credenciais de produção? | Condição obrigatória para qualquer avaliação de prontidão produtiva. | MEC, responsável institucional e governança de segurança | Aberto |
| `PC-MEC-API-0001-008` | Qual é o contrato OpenAPI oficial e sua política de versionamento? | Necessário para versionar DTOs, schemas, testes e compatibilidade. | Snapshot OpenAPI oficial por ambiente | Aberto |
| `PC-MEC-API-0001-009` | Qual é a rota e o contrato de submissão de lotes? | A cartilha apresenta listagem, consulta e erros, mas não fecha o envio ponta a ponta. | OpenAPI, Swagger UI ou Redocly | Aberto |
| `PC-MEC-API-0001-010` | Quais são os estados oficiais dos lotes e suas transições? | Não se deve equiparar estados externos aos estados internos da fila. | Contrato oficial e homologação | Aberto |
| `PC-MEC-API-0001-011` | Qual é o schema dos erros de processamento de lote? | Necessário para diagnóstico, correção, retry e métricas. | Contrato oficial e respostas observadas | Aberto |
| `PC-MEC-API-0001-012` | Qual é o schema completo das respostas HTTP `422`? | Necessário para normalizar os detalhes de pré-validação. | Contrato oficial e testes negativos | Aberto |
| `PC-MEC-API-0001-013` | Quais são as rotas e os schemas de instituições de ensino? | A fonte cita listagem, cadastro e edição sem apresentar contrato completo. | OpenAPI e documentação do módulo | Aberto |
| `PC-MEC-API-0001-014` | Quais são as rotas e os schemas de profissionais da educação? | A fonte cita operações sem apresentar contrato completo. | OpenAPI e documentação do módulo | Aberto |
| `PC-MEC-API-0001-015` | Quais são os contratos de vínculos, funções e formações? | As operações e transições são citadas sem schemas e regras formais. | OpenAPI, documentação e homologação | Aberto |
| `PC-MEC-API-0001-016` | Quais são os formatos e regras de consulta por código INEP e CPF? | A cartilha cita os identificadores, mas não define parâmetros e validações. | Contrato dos módulos e homologação | Aberto |
| `PC-MEC-API-0001-017` | Quais são os parâmetros oficiais de filtros, ordenação e paginação? | A cartilha orienta testar esses recursos sem apresentar seus contratos. | OpenAPI, Swagger UI ou Redocly | Aberto |
| `PC-MEC-API-0001-018` | Quais perfis, escopos ou claims autorizam cada operação? | A fonte não apresenta matriz oficial de autorização. | Contrato de segurança e orientação oficial | Aberto |
| `PC-MEC-API-0001-019` | Existe restrição por ente, rede, instituição, tenant, PGP, IP ou outro vínculo institucional? | O escopo de acesso precisa ser conhecido antes de modelar autorização e isolamento. | MEC, responsável institucional e documentação complementar | Aberto |
| `PC-MEC-API-0001-020` | Quais critérios formais autorizam a promoção de homologação para produção? | A cartilha não constitui autorização produtiva nem define gate completo. | MEC, governança institucional e decisão arquitetural | Aberto |

## Premissas analíticas adotadas

| ID | Premissa | Justificativa | Condição de revisão | Classificação |
|---|---|---|---|---|
| `PREM-MEC-API-0001-001` | A cartilha é introdutória e não representa o contrato completo da API. | Diversos endpoints, schemas e regras são citados sem detalhamento. | Revisar quando o contrato OpenAPI oficial for preservado. | `DE` |
| `PREM-MEC-API-0001-002` | Homologação e produção devem permanecer completamente segregadas. | A fonte apresenta ambientes distintos e exige testes anteriores à produção. | Revisar apenas mediante orientação oficial mais restritiva. | `DE` |
| `PREM-MEC-API-0001-003` | Dados reais não devem ser utilizados na homologação. | A fonte não recomenda dados reais e informa descarte posterior dos dados de teste. | Revisar somente mediante política oficial explícita e controles aprovados. | `DE` |
| `PREM-MEC-API-0001-004` | Estados internos da fila MIG não equivalem automaticamente aos estados oficiais de lote. | Não há enum ou máquina de estados oficial na cartilha. | Revisar após obter contrato e evidências de homologação. | `DE` |
| `PREM-MEC-API-0001-005` | Instituições, profissionais, vínculos, funções e formações exigirão contratos e mapeamentos próprios. | São recursos com semânticas distintas e schemas ainda ausentes. | Revisar após análise do OpenAPI. | `DE` |
| `PREM-MEC-API-0001-006` | O provider oficial deve continuar desabilitado até conclusão do gate de homologação. | Não há contrato completo, credencial ou evidência oficial neste dossiê. | Revisar somente após decisão `go/no-go`. | `PA` |
| `PREM-MEC-API-0001-007` | O simulador deve permanecer disponível mesmo após a criação do provider oficial. | Testes locais e regressões não devem depender da disponibilidade externa. | Revisar por decisão arquitetural formal. | `PA` |
| `PREM-MEC-API-0001-008` | Evidências devem ser sanitizadas e vinculadas a hash, contrato e correlação. | Diagnóstico não deve expor segredos ou dados pessoais desnecessários. | Revisar quando o padrão corporativo de evidência for aprovado. | `PA` |

## Ressalvas obrigatórias

1. A existência de URL pública de documentação não comprova autorização de acesso.
2. A presença de uma rota em Swagger ou Redocly não comprova que o ente esteja habilitado para utilizá-la.
3. O valor mostrado como `api_key_security` ou mecanismo equivalente não deve ser inventado nem derivado deste dossiê.
4. Tokens, chaves e credenciais não devem ser registrados neste repositório.
5. URLs, rotas, schemas e regras podem variar entre ambientes ou versões.
6. Exemplos de payload não devem ser tratados como schema completo.
7. A ausência de erro imediato não comprova sucesso do processamento assíncrono.
8. O `lote_id` precisa permanecer correlacionado à operação local e ao ambiente.
9. Requisitos `DE / PC` não devem ser promovidos antes da confirmação.
10. Propostas `PA` exigem decisão arquitetural formal.
11. O estado conhecido do MIG precisa ser reconfirmado no repositório de código antes da implementação.
12. Nenhuma conclusão deste dossiê libera produção.

## Divergências

### Divergências comprovadas

Até a revisão de 2026-08-05, este dossiê registra **zero divergências comprovadas** entre documentação e comportamento, porque ainda não contém testes executados contra o ambiente oficial.

### Situações que devem ser registradas como divergência quando comprovadas

- endpoint documentado com comportamento incompatível;
- campo obrigatório ausente no contrato ou na resposta;
- tipo de dado divergente;
- código HTTP diferente do documentado;
- estado de lote não previsto;
- erro de processamento sem estrutura compatível;
- diferença entre Swagger UI, Redocly e OpenAPI;
- diferença entre homologação e produção;
- alteração de contrato sem versionamento identificável;
- autorização efetiva diferente da matriz documentada.

Uma divergência somente deve ser aberta com:

```text
ambiente + operação + contrato consultado + entrada sanitizada
+ resposta observada + resultado esperado + correlação + evidência
```

## Decisões não tomadas neste dossiê

Este dossiê não decide:

- habilitar o provider oficial;
- ativar o scheduler produtivo;
- cadastrar credenciais;
- enviar dados ao MEC;
- promover requisitos para conhecimento consolidado;
- criar ou alterar banco de dados;
- alterar a arquitetura oficial do MIG;
- aprovar perfis ou permissões;
- liberar instituições ou profissionais;
- autorizar produção.

Essas decisões pertencem aos mecanismos oficiais de arquitetura, segurança, operação e governança do SIGESC.

## Gatilhos de revisão

| ID | Evento | Ação obrigatória | Resultado esperado |
|---|---|---|---|
| `REV-MEC-API-0001-001` | Recebimento de contrato OpenAPI oficial | Preservar arquivo, URL, data, ambiente e hash; comparar com o dossiê. | Atualização de regras, requisitos, dados, integrações e rastreabilidade. |
| `REV-MEC-API-0001-002` | Emissão de credencial de homologação | Revisar segurança, armazenamento, escopo e revogação antes do uso. | Decisão controlada sobre início da homologação. |
| `REV-MEC-API-0001-003` | Mudança na autenticação ou validade do token | Revisar requisitos, gerenciador de token, testes e riscos. | Contrato e implementação alinhados. |
| `REV-MEC-API-0001-004` | Identificação da rota de submissão de lotes | Completar o fluxo ponta a ponta e revisar idempotência e correlação. | Modelo assíncrono validável. |
| `REV-MEC-API-0001-005` | Disponibilização dos contratos de instituições e profissionais | Revisar DTOs, mapeamentos, permissões e casos de uso. | Escopo funcional detalhado. |
| `REV-MEC-API-0001-006` | Primeiro teste executado em homologação | Criar evidência sanitizada e atualizar a matriz de rastreabilidade. | Início da comprovação operacional. |
| `REV-MEC-API-0001-007` | Divergência entre documentação e comportamento | Registrar evidência, impacto e encaminhamento ao canal oficial. | Divergência formalmente rastreada. |
| `REV-MEC-API-0001-008` | Solicitação de ativação produtiva | Executar o gate completo de `go/no-go`. | Decisão formal de aprovação ou bloqueio. |

## Fontes complementares esperadas

A evolução deste dossiê depende, conforme disponibilidade, de:

- contrato OpenAPI oficial;
- Swagger UI e Redocly vigentes;
- documentação da autenticação;
- orientações de credenciamento e acesso;
- matriz oficial de perfis e escopos;
- documentação de lotes e erros;
- contratos de instituições e profissionais;
- respostas oficiais aos pontos de confirmação;
- evidências de homologação;
- decisões arquiteturais do SIGESC;
- documentação e código vigentes do MIG.

## Histórico editorial

| Data | Alteração | Responsável |
|---|---|---|
| 2026-08-05 | Criação da estrutura controlada do dossiê. | Governança do SIGESC |
| 2026-08-05 | Preservação e identificação da fonte `MEC-API-0001`. | Governança do SKF |
| 2026-08-05 | Conclusão da extração de estrutura, glossário, regras e requisitos. | Análise documental |
| 2026-08-05 | Conclusão de casos de uso, fluxos, modelo de dados, perfis e integrações. | Análise de engenharia |
| 2026-08-05 | Conclusão da análise de impacto, GAPs, decisões e oportunidades. | Análise arquitetural |
| 2026-08-05 | Consolidação da matriz de rastreabilidade com zero evidências operacionais. | Governança do SKF |
| 2026-08-05 | Registro das notas, ressalvas, premissas e gatilhos de revisão. | Governança do SKF |

## Critério de encerramento das pendências

Uma pendência somente pode mudar de `Aberto` para `Confirmado` quando houver:

1. fonte oficial identificada;
2. conteúdo preservado ou referenciado de forma estável;
3. data e ambiente registrados;
4. análise de impacto concluída;
5. atualização dos artefatos dependentes;
6. rastreabilidade revisada;
7. evidência anexada quando a confirmação depender de comportamento;
8. responsável pela validação identificado.

Pendências não comprovadas devem permanecer abertas, mesmo quando houver expectativa técnica plausível.

## Nota final

O Ciclo 1 produziu um dossiê documental e analítico consistente para a fonte `MEC-API-0001`.

O próximo avanço técnico não é ativar a integração. É obter e preservar o contrato oficial, resolver as pendências `P0`, preparar homologação controlada e produzir as primeiras evidências operacionais.

Até lá:

```text
análise documental: concluída
contrato técnico: incompleto
homologação oficial: pendente
evidência operacional: zero
produção: bloqueada
```
