# 11 — Integrações

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `{{DOSSIER_ID}}` |
| Artefato | `11-integracoes.md` |
| Estado | `{{STATUS}}` |

## Estado deste artefato

`{{ARTIFACT_STATUS_EXPLANATION}}`

## Convenções

Distinguir interfaces citadas, contratos confirmados, dependências derivadas e
pontos ainda não comprovados.

## Sistemas e interfaces citados

| ID | Sistema ou interface | Finalidade | Mecanismo ou localização | Classificação | Referência |
|---|---|---|---|---|---|
| `INT-{{DOSSIER_ID}}-001` | `{{SYSTEM_OR_INTERFACE}}` | `{{PURPOSE}}` | `{{MECHANISM_OR_LOCATION}}` | `{{FD_DE_PC}}` | `{{REFERENCE}}` |

## Topologia conceitual identificada

```text
{{SYSTEM_A}}
→ {{INTERFACE}}
→ {{SYSTEM_B}}
```

## Catálogo de rotas explicitamente apresentadas

| Operação | Rota | Finalidade | Classificação |
|---|---|---|---|
| `{{OPERATION}}` | `{{ROUTE}}` | `{{PURPOSE}}` | `{{FD_PC}}` |

## Dependências de integração

| ID | Dependência | Necessidade técnica | Classificação | Estado |
|---|---|---|---|---|
| `DEP-{{DOSSIER_ID}}-001` | `{{DEPENDENCY}}` | `{{TECHNICAL_NEED}}` | `{{DE_PA_PC}}` | `{{STATUS}}` |

## Sequência de integração derivada

```text
{{STEP_1}}
→ {{STEP_2}}
→ {{STEP_3}}
```

## Limites entre homologação e produção

| Aspecto | Homologação | Produção |
|---|---|---|
| `{{ASPECT}}` | `{{HOMOLOGATION_RULE}}` | `{{PRODUCTION_RULE}}` |

## Canais oficiais

| Canal | Aplicação | Observação |
|---|---|---|
| `{{CHANNEL}}` | `{{APPLICATION}}` | `{{OBSERVATION}}` |

## Pontos a confirmar

| ID | Ponto a confirmar | Impacto |
|---|---|---|
| `PC-INT-{{DOSSIER_ID}}-001` | `{{POINT_TO_CONFIRM}}` | `{{IMPACT}}` |

## Critério de prontidão

`{{READINESS_CRITERIA}}`

## Regra de promoção

A integração somente pode ser considerada validada após contrato preservado,
autenticação resolvida, implementação rastreada, homologação e evidências.
