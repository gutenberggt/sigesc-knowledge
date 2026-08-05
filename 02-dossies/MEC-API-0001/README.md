# Dossiê MEC-API-0001

## Identificação

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Órgão relacionado | Ministério da Educação — MEC |
| Domínio analisado | API do Sistema Gestão Presente / CMDEB |
| Tipo de trabalho | Dossiê documental e analítico |
| Ciclo | Ciclo 1 — Primeiro dossiê SKF |
| Estado | Análise documental concluída; validação técnica pendente |
| Homologação oficial | Não iniciada neste dossiê |
| Evidências operacionais | `0` |
| Produção | Bloqueada |
| Última revisão | 2026-08-05 |

## Finalidade

Este dossiê organiza, classifica e relaciona o conhecimento extraído da fonte `MEC-API-0001`, com foco em:

- ambientes de homologação e produção;
- documentação técnica;
- autenticação Bearer;
- nomenclatura e validação de payloads;
- processamento e acompanhamento de lotes;
- instituições de ensino;
- profissionais da educação;
- evidências, diagnóstico e suporte;
- impactos potenciais sobre a arquitetura SIGESC/MIG.

O dossiê não substitui o contrato OpenAPI, a documentação técnica vigente, a homologação oficial, o código-fonte do SIGESC ou o SIGESC Docs.

## Fonte principal

[`MEC-API-0001-cartilha-uso-api-gestao-presente.pdf`](../../01-fontes/mec/gestao-presente/api/MEC-API-0001/MEC-API-0001-cartilha-uso-api-gestao-presente.pdf)

| Propriedade | Valor |
|---|---|
| Formato | PDF |
| Extensão analisada | 9 páginas físicas |
| SHA-256 | `1e50fc17887352c3eea930d4e72f16679fd080fdc5075cb73980e6a0db2c02ef` |
| Natureza | Cartilha introdutória de uso |
| Limitação principal | Não apresenta o contrato técnico completo da API |

## Conclusão executiva

A fonte confirma elementos importantes para a integração:

- existência de ambientes separados de homologação e produção;
- uso de Swagger UI e Redocly;
- autenticação por token Bearer;
- validade apresentada como atual de 5 minutos;
- reutilização e renovação do token;
- atributos da API em `snake_case`;
- cabeçalhos de planilha em caixa alta;
- pré-validação e retorno HTTP `422`;
- rotas genéricas para listar lotes, consultar status e consultar erros;
- operações de homologação para instituições e profissionais;
- necessidade de registrar observações, erros e divergências.

A arquitetura conhecida do MIG possui fundações compatíveis com integração externa assíncrona, incluindo cliente HTTP centralizado, provider específico, validação, mapeamento, fila, worker, retry, idempotência, auditoria, métricas, scheduler e feature flags.

Esse alinhamento é arquitetural, não contratual.

A ativação oficial permanece bloqueada porque o dossiê não contém contrato completo de autenticação, credenciais, snapshot OpenAPI, contrato de submissão dos lotes, estados oficiais, schemas de erros, contratos integrais dos módulos ou evidências de homologação.

## Estado consolidado

| Dimensão | Estado | Observação |
|---|---|---|
| Fonte preservada | Concluído | Arquivo identificado e verificado por SHA-256. |
| Extração documental | Concluída | Estrutura, termos, regras e restrições catalogados. |
| Derivação analítica | Concluída | Requisitos, casos de uso, fluxos e modelos produzidos. |
| Análise de impacto | Concluída documentalmente | Deve ser reconfirmada contra código e documentação vigentes. |
| Contrato técnico | Incompleto | A cartilha não substitui OpenAPI, Swagger UI ou Redocly vigentes. |
| Autenticação oficial | Pendente | Rota, método, payload, resposta, credencial e ciclo de vida precisam ser confirmados. |
| Homologação | Pendente | Nenhum teste oficial foi registrado neste dossiê. |
| Evidência operacional | Ausente | Total atual: `0`. |
| Divergência comprovada | Ausente | Total atual: `0`, pois não houve teste oficial registrado. |
| Produção | Bloqueada | Depende de contrato, credencial, homologação, evidências e decisão formal. |

## Classificação das afirmações

| Código | Significado |
|---|---|
| `FD` | Fonte direta: afirmação sustentada explicitamente pela cartilha. |
| `DE` | Derivação de engenharia: conclusão analítica construída a partir da fonte. |
| `PA` | Proposta arquitetural: solução sugerida para avaliação no SIGESC/MIG. |
| `PC` | Ponto a confirmar: informação dependente de contrato, fonte adicional ou teste. |
| `FD / PC` | Informação presente na fonte, mas tecnicamente incompleta ou temporal. |
| `DE / PC` | Derivação válida em princípio, ainda dependente de confirmação. |

## Inventário quantitativo

| Área | Quantidade |
|---|---:|
| Termos do glossário | 42 |
| Regras e restrições | 29 |
| Requisitos funcionais | 30 |
| Requisitos não funcionais | 27 |
| Casos de uso | 20 |
| Fluxos derivados para SIGESC/MIG | 8 |
| Elementos de dados identificados | 20 |
| Mapeamentos conceituais propostos | 16 |
| Atores extraídos ou analisados | 4 |
| Lacunas de autorização | 10 |
| Perfis internos propostos | 8 |
| Permissões internas propostas | 18 |
| Interfaces externas citadas | 16 |
| Dependências de integração | 12 |
| Componentes SIGESC/MIG potencialmente afetados | 18 |
| GAPs técnicos e contratuais | 20 |
| Decisões arquiteturais propostas | 12 |
| Oportunidades de melhoria | 24 |
| Cadeias de rastreabilidade ponta a ponta | 24 |
| Pendências de confirmação consolidadas | 20 |
| Evidências operacionais | 0 |

## Artefatos do dossiê

| ID | Artefato | Conteúdo principal | Estado |
|---|---|---|---|
| `ART-MEC-API-0001-001` | [Ficha técnica](00-ficha-tecnica.md) | Identificação, origem, integridade, escopo e limitações da fonte. | Concluído |
| `ART-MEC-API-0001-002` | [Resumo executivo](01-resumo-executivo.md) | Síntese da cartilha, riscos, restrições e implicações iniciais. | Concluído |
| `ART-MEC-API-0001-003` | [Estrutura do documento](02-estrutura-documento.md) | Mapeamento das páginas e seções da fonte. | Concluído |
| `ART-MEC-API-0001-004` | [Glossário](03-glossario.md) | Termos, definições, classificações e referências. | Concluído |
| `ART-MEC-API-0001-005` | [Regras e restrições](04-regras-e-restricoes.md) | Determinações, condições e limitações extraídas. | Concluído |
| `ART-MEC-API-0001-006` | [Requisitos funcionais](05-requisitos-funcionais.md) | Capacidades funcionais derivadas para análise. | Concluído |
| `ART-MEC-API-0001-007` | [Requisitos não funcionais](06-requisitos-nao-funcionais.md) | Segurança, interoperabilidade, proteção de dados, observabilidade e testes. | Concluído |
| `ART-MEC-API-0001-008` | [Casos de uso](07-casos-de-uso.md) | Atores, objetivos, pré-condições e resultados esperados. | Concluído |
| `ART-MEC-API-0001-009` | [Fluxos operacionais](08-fluxos-operacionais.md) | Fluxos da fonte e sequências derivadas para SIGESC/MIG. | Concluído |
| `ART-MEC-API-0001-010` | [Modelo de dados](09-modelo-de-dados.md) | Elementos identificados, relações e mapeamentos conceituais. | Concluído |
| `ART-MEC-API-0001-011` | [Perfis e permissões](10-perfis-e-permissoes.md) | Atores, lacunas de autorização e RBAC interno proposto. | Concluído |
| `ART-MEC-API-0001-012` | [Integrações](11-integracoes.md) | Ambientes, interfaces, rotas, canais e dependências. | Concluído |
| `ART-MEC-API-0001-013` | [Impacto no SIGESC](12-impacto-no-sigesc.md) | Componentes afetados, GAPs, decisões e gates. | Concluído documentalmente |
| `ART-MEC-API-0001-014` | [Oportunidades de melhoria](13-oportunidades-de-melhoria.md) | Melhorias derivadas e propostas arquiteturais priorizadas. | Concluído |
| `ART-MEC-API-0001-015` | [Rastreabilidade](14-rastreabilidade.md) | Cadeias entre fonte, requisitos, impactos, testes e evidências. | Concluído documentalmente |
| `ART-MEC-API-0001-016` | [Notas e pendências](15-notas.md) | Ressalvas, premissas, pontos abertos e gatilhos de revisão. | Concluído |

## Bloqueadores críticos

| ID | Bloqueador | Consequência | Condição de resolução |
|---|---|---|---|
| `BLQ-MEC-API-0001-001` | Contrato oficial de autenticação ausente. | Impede implementar e testar o cliente oficial de autenticação. | Obter endpoint, método, payload, resposta e erros oficiais. |
| `BLQ-MEC-API-0001-002` | Credencial oficial de homologação indisponível neste dossiê. | Impede executar testes autenticados reais. | Receber credencial e validar armazenamento, escopo e revogação. |
| `BLQ-MEC-API-0001-003` | Snapshot OpenAPI oficial não preservado. | Impede versionamento confiável de DTOs, schemas e testes. | Preservar contrato por ambiente, data, versão e hash. |
| `BLQ-MEC-API-0001-004` | Contrato de submissão de lotes incompleto. | Impede fechar o fluxo assíncrono de ponta a ponta. | Confirmar rota, método, payload, resposta e idempotência. |
| `BLQ-MEC-API-0001-005` | Estados e erros oficiais de lote não confirmados. | Impede tradução segura, terminalidade, retry e diagnóstico. | Obter enum, transições e schemas oficiais. |
| `BLQ-MEC-API-0001-006` | Contratos de instituições e profissionais incompletos. | Impede implementar os módulos funcionais citados. | Obter rotas, schemas, parâmetros e regras de autorização. |
| `BLQ-MEC-API-0001-007` | Homologação oficial sem evidências. | Impede comprovar compatibilidade entre documentação e comportamento. | Executar cenários controlados e preservar evidências sanitizadas. |
| `BLQ-MEC-API-0001-008` | Gate de produção não satisfeito. | Provider oficial e scheduler produtivo devem permanecer desabilitados. | Aprovar contrato, segurança, RBAC, testes, evidências, monitoramento e decisão `go/no-go`. |

## Orientação de uso

Este dossiê deve ser utilizado para:

- compreender o conteúdo e os limites da cartilha;
- preparar perguntas técnicas;
- planejar obtenção de contratos complementares;
- orientar revisão de arquitetura;
- estruturar homologação;
- manter rastreabilidade das decisões.

Este dossiê não deve ser utilizado para:

- inventar credenciais ou valores de segurança;
- enviar dados reais ao ambiente de homologação;
- assumir schemas não documentados;
- equiparar estados locais e externos sem contrato;
- declarar o provider oficial pronto;
- autorizar produção.

## Autoridades documentais

| Assunto | Autoridade |
|---|---|
| Conteúdo da cartilha | PDF preservado em `01-fontes/` |
| Contrato da API | OpenAPI, Swagger UI e Redocly oficiais vigentes |
| Comportamento da API | Evidências de homologação no ambiente oficial |
| Arquitetura do SIGESC/MIG | Código-fonte, ADRs e SIGESC Docs |
| Decisões arquiteturais | Mecanismo oficial de decisões do SIGESC |
| Conhecimento em análise | Este dossiê |
| Conhecimento validado | `03-conhecimento-consolidado/`, após promoção formal |

## Próximo avanço formal

O próximo avanço técnico deve seguir esta sequência:

```text
obter contrato oficial
→ preservar versão e hash
→ resolver autenticação e credenciais
→ adaptar provider e contratos específicos
→ executar homologação controlada
→ registrar evidências
→ revisar GAPs e decisões
→ executar gate go/no-go
```

A etapa seguinte do Ciclo 1 é a auditoria final de consistência do dossiê. Ela deve verificar referências, identificadores, marcadores pendentes, integridade dos arquivos e estado Git antes da abertura de pull request.

## Regra editorial

Nenhuma inferência deve ser apresentada como determinação oficial.

Cada afirmação relevante deve preservar:

```text
classificação + origem + referência + estado de validação
```

A promoção de conteúdo para conhecimento consolidado exige:

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
