# Dossiê {{DOSSIER_ID}}

<!--
Substitua todos os marcadores no formato {{PLACEHOLDER_NAME}} antes de publicar o dossiê.
Exemplo de identificador canônico: ORG-DOM-0001.
-->

## Identificação

| Campo | Valor |
|---|---|
| Dossiê | `{{DOSSIER_ID}}` |
| Fonte principal | `{{SOURCE_TITLE}}` |
| Órgão relacionado | `{{SOURCE_ORGANIZATION}}` |
| Domínio analisado | `{{ANALYSIS_DOMAIN}}` |
| Tipo de trabalho | Dossiê documental e analítico |
| Ciclo | `{{SKF_CYCLE}}` |
| Estado | `{{DOSSIER_STATUS}}` |
| Homologação oficial | `{{HOMOLOGATION_STATUS}}` |
| Evidências operacionais | `{{EVIDENCE_COUNT}}` |
| Produção | `{{PRODUCTION_STATUS}}` |
| Última revisão | `{{REVIEW_DATE}}` |

## Finalidade

Este dossiê organiza, classifica e relaciona o conhecimento extraído da fonte
`{{DOSSIER_ID}}`, com foco em `{{ANALYSIS_PURPOSE}}`.

O dossiê não substitui contratos oficiais, documentação técnica vigente,
homologação, código-fonte, decisões arquiteturais ou o SIGESC Docs.

## Fonte principal

| Propriedade | Valor |
|---|---|
| Título | `{{SOURCE_TITLE}}` |
| Caminho ou referência estável | `{{SOURCE_REFERENCE}}` |
| Formato | `{{SOURCE_FORMAT}}` |
| Extensão analisada | `{{SOURCE_EXTENT}}` |
| SHA-256 | `{{SOURCE_SHA256_OR_NOT_APPLICABLE}}` |
| Natureza | `{{SOURCE_NATURE}}` |
| Limitação principal | `{{SOURCE_MAIN_LIMITATION}}` |

## Conclusão executiva

`{{EXECUTIVE_CONCLUSION}}`

## Estado consolidado

| Dimensão | Estado | Observação |
|---|---|---|
| Fonte preservada | `{{STATUS}}` | `{{OBSERVATION}}` |
| Extração documental | `{{STATUS}}` | `{{OBSERVATION}}` |
| Derivação analítica | `{{STATUS}}` | `{{OBSERVATION}}` |
| Contrato técnico | `{{STATUS}}` | `{{OBSERVATION}}` |
| Homologação | `{{STATUS}}` | `{{OBSERVATION}}` |
| Evidência operacional | `{{STATUS}}` | `{{OBSERVATION}}` |
| Produção | `{{STATUS}}` | `{{OBSERVATION}}` |

## Classificação das afirmações

| Código | Significado |
|---|---|
| `FD` | Fonte direta: afirmação sustentada explicitamente pela fonte. |
| `DE` | Derivação de engenharia: conclusão analítica construída a partir da fonte. |
| `PA` | Proposta arquitetural: solução sugerida para avaliação. |
| `PC` | Ponto a confirmar: informação dependente de contrato, fonte adicional ou teste. |
| `FD / PC` | Informação presente na fonte, mas tecnicamente incompleta ou temporal. |
| `DE / PC` | Derivação válida em princípio, ainda dependente de confirmação. |

## Inventário quantitativo

| Área | Quantidade |
|---|---:|
| Termos do glossário | `{{COUNT}}` |
| Regras e restrições | `{{COUNT}}` |
| Requisitos funcionais | `{{COUNT}}` |
| Requisitos não funcionais | `{{COUNT}}` |
| Casos de uso | `{{COUNT}}` |
| Fluxos operacionais | `{{COUNT}}` |
| Evidências operacionais | `{{COUNT}}` |

## Artefatos do dossiê

| ID | Artefato | Conteúdo principal | Estado |
|---|---|---|---|
| `ART-{{DOSSIER_ID}}-001` | [Ficha técnica](00-ficha-tecnica.md) | Identificação, origem, integridade, escopo e limitações. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-002` | [Resumo executivo](01-resumo-executivo.md) | Síntese, riscos, restrições e implicações iniciais. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-003` | [Estrutura do documento](02-estrutura-documento.md) | Mapeamento das páginas e seções da fonte. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-004` | [Glossário](03-glossario.md) | Termos, definições, classificações e referências. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-005` | [Regras e restrições](04-regras-e-restricoes.md) | Determinações, condições e limitações extraídas. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-006` | [Requisitos funcionais](05-requisitos-funcionais.md) | Capacidades funcionais derivadas para análise. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-007` | [Requisitos não funcionais](06-requisitos-nao-funcionais.md) | Atributos de qualidade e controles derivados. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-008` | [Casos de uso](07-casos-de-uso.md) | Atores, objetivos, pré-condições e resultados. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-009` | [Fluxos operacionais](08-fluxos-operacionais.md) | Fluxos identificados e sequências derivadas. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-010` | [Modelo de dados](09-modelo-de-dados.md) | Elementos, relações e mapeamentos conceituais. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-011` | [Perfis e permissões](10-perfis-e-permissoes.md) | Atores, autorização e controles de acesso. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-012` | [Integrações](11-integracoes.md) | Sistemas, interfaces, rotas e dependências. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-013` | [Impacto no SIGESC](12-impacto-no-sigesc.md) | Componentes afetados, GAPs, decisões e gates. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-014` | [Oportunidades de melhoria](13-oportunidades-de-melhoria.md) | Melhorias derivadas e propostas priorizadas. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-015` | [Rastreabilidade](14-rastreabilidade.md) | Relações entre fonte, requisitos, testes e evidências. | `{{STATUS}}` |
| `ART-{{DOSSIER_ID}}-016` | [Notas e pendências](15-notas.md) | Ressalvas, premissas, pontos abertos e revisões. | `{{STATUS}}` |

## Bloqueadores críticos

| ID | Bloqueador | Consequência | Condição de resolução |
|---|---|---|---|
| `BLQ-{{DOSSIER_ID}}-001` | `{{BLOCKER}}` | `{{CONSEQUENCE}}` | `{{RESOLUTION_CONDITION}}` |

## Orientação de uso

Este dossiê deve ser utilizado para:

- compreender o conteúdo e os limites da fonte;
- orientar análise, implementação, homologação e decisão;
- preservar rastreabilidade entre afirmações e evidências.

Este dossiê não deve ser utilizado para:

- inventar contratos, credenciais ou valores de segurança;
- apresentar inferências como determinações oficiais;
- autorizar produção sem validações e decisão formal.

## Autoridades documentais

| Assunto | Autoridade |
|---|---|
| Conteúdo da fonte | Original preservado ou referência estável registrada |
| Contrato técnico | Contrato oficial vigente |
| Comportamento operacional | Evidências de homologação |
| Arquitetura do SIGESC | Código-fonte, ADRs e SIGESC Docs |
| Conhecimento em análise | Este dossiê |
| Conhecimento validado | `03-conhecimento-consolidado/`, após promoção formal |

## Próximo avanço formal

`{{NEXT_FORMAL_STEP}}`

## Regra editorial

Nenhuma inferência deve ser apresentada como determinação oficial.

Cada afirmação relevante deve preservar:

```text
classificação + origem + referência + estado de validação
```
