# 08 — Fluxos operacionais

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `{{DOSSIER_ID}}` |
| Artefato | `08-fluxos-operacionais.md` |
| Estado | `{{STATUS}}` |

## Estado deste artefato

`{{ARTIFACT_STATUS_EXPLANATION}}`

## Fluxos identificados na fonte

- `{{SOURCE_FLOW}}` — `FD`

## Catálogo de fluxos derivados para o SIGESC/MIG

| ID | Fluxo | Objetivo | Casos de uso | Classificação | Estado |
|---|---|---|---|---|---|
| `FLX-{{DOSSIER_ID}}-001` | `{{FLOW}}` | `{{OBJECTIVE}}` | `UC-{{DOSSIER_ID}}-001` | `{{DE_PA_PC}}` | `{{STATUS}}` |

## Fluxos derivados detalhados

### `FLX-{{DOSSIER_ID}}-001` — `{{FLOW}}`

```text
{{STEP_1}}
→ {{STEP_2}}
→ {{STEP_3}}
```

## Estados analíticos propostos

- `{{ANALYTICAL_STATE}}` — `PA`

## Controles transversais

- `{{TRANSVERSAL_CONTROL}}`

## Dependências de validação

- `{{VALIDATION_DEPENDENCY}}`

## Regra de promoção

Fluxos devem preservar origem, estados, transições, erros, controles, testes e
evidências antes de serem tratados como comportamento validado.
