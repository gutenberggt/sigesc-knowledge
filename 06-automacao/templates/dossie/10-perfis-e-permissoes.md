# 10 — Perfis e permissões

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `{{DOSSIER_ID}}` |
| Artefato | `10-perfis-e-permissoes.md` |
| Estado | `{{STATUS}}` |

## Estado deste artefato

`{{ARTIFACT_STATUS_EXPLANATION}}`

## Convenções

Separar atores identificados na fonte, lacunas de autorização e propostas
internas de perfis ou permissões.

## Atores e responsabilidades identificados na fonte

| ID | Perfil ou ator | Responsabilidade identificável | Permissão ou limitação conhecida | Classificação | Referência |
|---|---|---|---|---|---|
| `ATO-{{DOSSIER_ID}}-001` | `{{ACTOR_OR_PROFILE}}` | `{{RESPONSIBILITY}}` | `{{KNOWN_PERMISSION_OR_LIMIT}}` | `{{FD_DE_PC}}` | `{{REFERENCE}}` |

## Lacunas de autorização

| ID | Questão pendente | Impacto |
|---|---|---|
| `AUT-PC-{{DOSSIER_ID}}-001` | `{{AUTHORIZATION_QUESTION}}` | `{{IMPACT}}` |

## Perfis internos propostos para o SIGESC/MIG

| ID | Perfil proposto | Responsabilidade | Limite principal | Classificação | Estado |
|---|---|---|---|---|---|
| `PER-{{DOSSIER_ID}}-001` | `{{PROPOSED_PROFILE}}` | `{{RESPONSIBILITY}}` | `{{MAIN_LIMIT}}` | `PA` | `{{STATUS}}` |

## Catálogo de permissões propostas

| ID | Permissão proposta | Aplicação | Restrições mínimas | Classificação | Estado |
|---|---|---|---|---|---|
| `ACL-{{DOSSIER_ID}}-001` | `{{PROPOSED_PERMISSION}}` | `{{APPLICATION}}` | `{{MINIMUM_RESTRICTIONS}}` | `PA` | `{{STATUS}}` |

## Matriz interna proposta

| Permissão | `{{PROFILE_1}}` | `{{PROFILE_2}}` |
|---|---:|---:|
| `ACL-{{DOSSIER_ID}}-001` | `{{ALLOW_DENY}}` | `{{ALLOW_DENY}}` |

## Princípios de controle de acesso propostos

- menor privilégio;
- segregação de funções;
- auditoria de operações sensíveis;
- negação por padrão.

## Critérios mínimos para ativação em produção

- `{{PRODUCTION_ACCESS_CRITERION}}`

## Dependências de validação

- `{{VALIDATION_DEPENDENCY}}`

## Regra de promoção

Perfis e permissões somente podem ser promovidos após decisão arquitetural,
implementação, testes de autorização e evidências aprovadas.
