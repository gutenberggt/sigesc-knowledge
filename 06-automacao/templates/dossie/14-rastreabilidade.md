# 14 — Rastreabilidade

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `{{DOSSIER_ID}}` |
| Artefato | `14-rastreabilidade.md` |
| Estado | `{{STATUS}}` |

## Objetivo

Relacionar origem, regras, requisitos, fluxos, dados, integrações, impactos,
testes, evidências e decisões por identificadores estáveis.

## Limites

Este arquivo mantém relações e estados de comprovação; não duplica documentos,
código ou evidências.

## Convenções

- referências ausentes devem permanecer explícitas;
- relações propostas devem ser classificadas;
- nenhum teste deve ser marcado como executado sem evidência.

## Cobertura dos artefatos

| ID | Artefato | Identificadores cobertos | Quantidade | Papel na rastreabilidade |
|---|---|---|---:|---|
| `COV-{{DOSSIER_ID}}-001` | `{{ARTIFACT}}` | `{{IDENTIFIERS}}` | `{{COUNT}}` | `{{ROLE}}` |

## Matriz de rastreabilidade ponta a ponta

| ID | Tema e origem | Regra e requisito | Caso de uso e fluxo | Dado, integração ou controle | Impacto, GAP e decisão | Teste e evidência | Classificação | Estado |
|---|---|---|---|---|---|---|---|---|
| `TRC-{{DOSSIER_ID}}-001` | `{{THEME_AND_ORIGIN}}` | `{{RULE_AND_REQUIREMENT}}` | `{{USE_CASE_AND_FLOW}}` | `{{DATA_INTEGRATION_CONTROL}}` | `{{IMPACT_GAP_DECISION}}` | `{{TEST_AND_EVIDENCE}}` | `{{FD_DE_PA_PC}}` | `{{STATUS}}` |

## Matriz de estados de comprovação

| Nível | Significado | Situação atual |
|---|---|---|
| Documental | Sustentado por fonte preservada | `{{STATUS}}` |
| Contratual | Confirmado por contrato oficial | `{{STATUS}}` |
| Implementado | Rastreado no código | `{{STATUS}}` |
| Testado | Cenário executado | `{{STATUS}}` |
| Evidenciado | Evidência aprovada | `{{STATUS}}` |

## Lacunas de rastreabilidade ainda abertas

- `{{TRACEABILITY_GAP}}`

## Regras de manutenção

- atualizar relações quando identificadores mudarem;
- preservar referências estáveis;
- registrar testes e evidências somente após execução;
- revisar cadeias antes de promover conhecimento.

## Regra de promoção

A promoção exige cadeia suficiente entre fonte, regra, requisito, implementação,
teste, evidência e decisão.
