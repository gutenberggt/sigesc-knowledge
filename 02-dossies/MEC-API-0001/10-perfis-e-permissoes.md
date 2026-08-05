# 10 — Perfis e permissões

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Estado | Perfis analíticos em revisão |
| Última revisão | 2026-08-05 |

## Estado deste artefato

A cartilha descreve atividades de autenticação, homologação, consulta de documentação, execução de operações, análise de erros e contato com o suporte oficial.

Entretanto, ela **não apresenta**:

- catálogo oficial de perfis;
- matriz RBAC;
- escopos de token;
- regras de autorização por endpoint;
- segregação formal entre leitura e escrita;
- processo de concessão, revisão ou revogação de acesso;
- permissões específicas para homologação e produção.

Por isso, este arquivo separa:

1. atores e responsabilidades identificáveis na fonte;
2. limitações de autorização ainda pendentes;
3. perfis internos propostos para o SIGESC/MIG;
4. permissões propostas, todas classificadas como `PA`.

Nenhuma permissão proposta neste artefato autoriza acesso real ao MEC ou ativação em produção.

## Convenções

- `FD`: ator ou responsabilidade diretamente sustentado pela fonte;
- `FD / PC`: ator inferido do fluxo, mas sem definição formal de perfil ou permissão;
- `PA`: proposta arquitetural para o SIGESC/MIG;
- `Proposto`: ainda não aprovado como controle corporativo consolidado.

## Atores e responsabilidades identificados na fonte

| ID | Perfil ou ator | Responsabilidade identificável | Permissão ou limitação conhecida | Classificação | Referência |
|---|---|---|---|---|---|
| `ATO-MEC-API-0001-001` | Equipe técnica de homologação | Testar rotas, validar recursos, avaliar respostas, registrar observações e identificar divergências. | A cartilha orienta a execução dos testes, mas não define credenciais, escopos ou autorização formal. | `FD / PC` | pp. 2–3 e 6–7 |
| `ATO-MEC-API-0001-002` | Sistema integrador | Enviar requisições autenticadas, payloads e consultas de acompanhamento. | Deve usar token Bearer, porém os escopos e permissões associados ao token não são informados. | `FD / PC` | pp. 4–6 |
| `ATO-MEC-API-0001-003` | API do Sistema Gestão Presente | Validar requisições, retornar HTTP `422`, processar operações e disponibilizar lotes e erros. | As regras internas de autorização da API não são apresentadas. | `FD` | pp. 3–6 |
| `ATO-MEC-API-0001-004` | Canal técnico oficial do MEC | Receber dúvidas e dificuldades relacionadas à integração e à API. | Não concede automaticamente acesso, credencial ou autorização de produção. | `FD` | pp. 7–8 |

## Lacunas de autorização

Permanecem como pontos a confirmar:

| ID | Questão pendente | Impacto |
|---|---|---|
| `AUT-PC-MEC-API-0001-001` | Qual é o contrato exato da rota de autenticação? | Impede definir o fluxo técnico definitivo de obtenção do token. |
| `AUT-PC-MEC-API-0001-002` | O token possui escopos, perfis ou claims de autorização? | Impede mapear permissões por operação. |
| `AUT-PC-MEC-API-0001-003` | Quais perfis podem listar, cadastrar e editar instituições? | Impede consolidar a matriz de acesso do módulo. |
| `AUT-PC-MEC-API-0001-004` | Quais perfis podem listar, cadastrar e editar profissionais? | Impede consolidar a matriz de acesso do módulo. |
| `AUT-PC-MEC-API-0001-005` | Quais perfis podem gerenciar vínculos, funções e formações? | Impede separar privilégios administrativos e operacionais. |
| `AUT-PC-MEC-API-0001-006` | Há permissões distintas entre homologação e produção? | Impede definir promoção segura entre ambientes. |
| `AUT-PC-MEC-API-0001-007` | Como ocorre concessão, rotação e revogação de credenciais? | Impede fechar o ciclo de gestão de acesso. |
| `AUT-PC-MEC-API-0001-008` | Há restrição por ente, rede, instituição, tenant ou código INEP? | Impede definir o escopo de dados acessível. |
| `AUT-PC-MEC-API-0001-009` | Quais operações são permitidas por endpoint e método HTTP? | Impede vincular autorização ao contrato completo. |
| `AUT-PC-MEC-API-0001-010` | Existe trilha oficial de auditoria de acesso e alteração? | Impede avaliar a cobertura de responsabilização externa. |

**Classificação:** `PC`.

## Perfis internos propostos para o SIGESC/MIG

| ID | Perfil proposto | Responsabilidade | Limite principal | Classificação | Estado |
|---|---|---|---|---|---|
| `PER-MEC-API-0001-001` | Administrador MIG | Configurar ambientes, políticas internas, feature flags e vínculos de responsabilidade. | Não deve visualizar segredos em texto aberto nem executar produção sem aprovação. | `PA` | Proposto |
| `PER-MEC-API-0001-002` | Gestor de credenciais | Cadastrar referências de segredo, coordenar rotação e revogação e validar disponibilidade por ambiente. | Não deve alterar dados educacionais ou aprovar sozinho a ativação em produção. | `PA` | Proposto |
| `PER-MEC-API-0001-003` | Operador de homologação | Executar cenários autorizados, consultar respostas e registrar evidências com massa controlada. | Sem acesso a dados reais e sem permissão de produção. | `PA` | Proposto |
| `PER-MEC-API-0001-004` | Analista de integração | Revisar contratos, mapeamentos, payloads, respostas, erros e divergências. | Não deve manipular segredos nem ativar execução produtiva. | `PA` | Proposto |
| `PER-MEC-API-0001-005` | Auditor de integração | Consultar configurações não sensíveis, eventos, evidências, correlações e histórico de decisões. | Perfil somente leitura, sem envio, edição ou gestão de credenciais. | `PA` | Proposto |
| `PER-MEC-API-0001-006` | Suporte técnico interno | Analisar falhas, preparar diagnóstico sanitizado e acompanhar chamados oficiais. | Não deve acessar token em texto aberto nem alterar dados de negócio. | `PA` | Proposto |
| `PER-MEC-API-0001-007` | Operador de produção | Executar e acompanhar operações produtivas previamente autorizadas. | Deve permanecer desabilitado até homologação, credenciais e aprovação formal. | `PA` | Proposto |
| `PER-MEC-API-0001-008` | Serviço automatizado MIG | Autenticar-se, validar payloads, enviar operações, acompanhar lotes e produzir eventos técnicos. | Atua apenas no tenant, ambiente, operação e janela explicitamente habilitados. | `PA` | Proposto |

## Catálogo de permissões propostas

| ID | Permissão proposta | Aplicação | Restrições mínimas | Classificação | Estado |
|---|---|---|---|---|---|
| `ACL-MEC-API-0001-001` | Consultar configuração de ambiente | Visualizar URLs, estado e metadados não sensíveis. | Não expor credenciais ou tokens. | `PA` | Proposto |
| `ACL-MEC-API-0001-002` | Alterar configuração de homologação | Atualizar URLs, parâmetros e habilitação de testes. | Exigir auditoria da alteração. | `PA` | Proposto |
| `ACL-MEC-API-0001-003` | Alterar configuração de produção | Atualizar parâmetros produtivos. | Exigir aprovação formal e segregação de função. | `PA` | Proposto |
| `ACL-MEC-API-0001-004` | Gerenciar referência de credencial | Criar, atualizar, rotacionar ou revogar referência de segredo. | Segredo fora do código e dos registros de negócio. | `PA` | Proposto |
| `ACL-MEC-API-0001-005` | Consultar contrato técnico | Acessar Swagger, Redocly, OpenAPI e referências capturadas. | Registrar versão ou hash consultado. | `PA` | Proposto |
| `ACL-MEC-API-0001-006` | Executar pré-validação local | Validar obrigatoriedade, tipos e atributos. | Usar o schema correspondente ao ambiente e à versão. | `PA` | Proposto |
| `ACL-MEC-API-0001-007` | Executar operação em homologação | Enviar requisições de teste. | Massa sintética ou anonimizada; produção bloqueada. | `PA` | Proposto |
| `ACL-MEC-API-0001-008` | Executar operação em produção | Enviar requisições produtivas autorizadas. | Homologação concluída, credencial válida, tenant habilitado e aprovação formal. | `PA` | Proposto |
| `ACL-MEC-API-0001-009` | Consultar lotes | Listar lotes e consultar status. | Respeitar ambiente, tenant e correlação autorizados. | `PA` | Proposto |
| `ACL-MEC-API-0001-010` | Consultar erros de lote | Recuperar erros de processamento. | Proteger dados pessoais e registrar acesso. | `PA` | Proposto |
| `ACL-MEC-API-0001-011` | Operar instituições em homologação | Listar, cadastrar e editar instituições em cenários controlados. | Dependente do contrato e da autorização oficial. | `PA` | Proposto |
| `ACL-MEC-API-0001-012` | Operar profissionais em homologação | Listar, cadastrar e editar profissionais em cenários controlados. | Dependente do contrato e da autorização oficial. | `PA` | Proposto |
| `ACL-MEC-API-0001-013` | Gerenciar relações profissionais em homologação | Operar vínculos, funções e formações. | Dependente do contrato e da autorização oficial. | `PA` | Proposto |
| `ACL-MEC-API-0001-014` | Registrar evidência | Criar evidência sanitizada de teste, resposta, erro ou divergência. | Remover token, credencial e dados pessoais desnecessários. | `PA` | Proposto |
| `ACL-MEC-API-0001-015` | Consultar evidência e auditoria | Ler histórico de operações, eventos e decisões. | Somente dados autorizados e sanitizados. | `PA` | Proposto |
| `ACL-MEC-API-0001-016` | Preparar encaminhamento ao suporte oficial | Produzir diagnóstico e vincular protocolo. | Revisão prévia para evitar exposição de segredos e dados pessoais. | `PA` | Proposto |
| `ACL-MEC-API-0001-017` | Habilitar serviço automatizado | Ativar execução por tenant, ambiente, operação e janela. | Fail-closed; padrão desabilitado. | `PA` | Proposto |
| `ACL-MEC-API-0001-018` | Revogar execução e acesso | Desabilitar automação, referência de credencial ou perfil interno. | Registrar motivo, responsável e instante da revogação. | `PA` | Proposto |

## Matriz interna proposta

Legenda:

- `A`: autorizado pela proposta;
- `R`: somente leitura;
- `—`: não autorizado;
- `C`: condicionado a aprovação adicional.

| Permissão | Admin. MIG | Gestor credenciais | Operador HMG | Analista | Auditor | Suporte | Operador PROD | Serviço MIG |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Consultar configuração | `A` | `R` | `R` | `R` | `R` | `R` | `R` | `R` |
| Alterar homologação | `A` | `—` | `—` | `—` | `—` | `—` | `—` | `—` |
| Alterar produção | `C` | `—` | `—` | `—` | `—` | `—` | `C` | `—` |
| Gerenciar credencial | `—` | `A` | `—` | `—` | `—` | `—` | `—` | `—` |
| Consultar contrato | `A` | `R` | `R` | `A` | `R` | `R` | `R` | `R` |
| Executar homologação | `—` | `—` | `A` | `C` | `—` | `—` | `—` | `A` |
| Executar produção | `—` | `—` | `—` | `—` | `—` | `—` | `C` | `C` |
| Consultar lotes e erros | `R` | `—` | `A` | `A` | `R` | `R` | `A` | `A` |
| Operar instituições | `—` | `—` | `A` | `C` | `—` | `—` | `C` | `C` |
| Operar profissionais | `—` | `—` | `A` | `C` | `—` | `—` | `C` | `C` |
| Registrar evidência | `R` | `—` | `A` | `A` | `—` | `A` | `A` | `A` |
| Consultar auditoria | `R` | `R` | `R` | `R` | `A` | `R` | `R` | `—` |
| Escalar suporte | `—` | `—` | `C` | `A` | `—` | `A` | `C` | `—` |
| Habilitar automação | `C` | `—` | `—` | `—` | `—` | `—` | `C` | `—` |
| Revogar acesso | `C` | `C` | `—` | `—` | `—` | `—` | `—` | `—` |

**Classificação:** `PA`.

## Princípios de controle de acesso propostos

1. **Menor privilégio:** cada perfil recebe apenas as capacidades necessárias.
2. **Segregação de função:** configuração, credencial, execução e auditoria não devem ficar concentradas em um único perfil.
3. **Fail-closed:** ausência de configuração, credencial, escopo ou aprovação deve bloquear a operação.
4. **Separação por ambiente:** permissão de homologação não implica permissão de produção.
5. **Separação por tenant:** uma autorização não deve permitir acesso a outro tenant.
6. **Proteção de segredo:** token e credencial não devem aparecer em logs, evidências ou interfaces comuns.
7. **Rastreabilidade:** concessão, uso, alteração e revogação devem produzir eventos auditáveis.
8. **Revisão periódica:** acessos devem ser reavaliados após mudança de função, credencial, contrato ou ambiente.
9. **Produção bloqueada por padrão:** o perfil e o serviço produtivos permanecem desabilitados até aprovação formal.
10. **Contrato externo soberano:** permissões internas não ampliam o que o MEC efetivamente autoriza.

**Classificação:** `PA`.

## Critérios mínimos para ativação em produção

A permissão produtiva somente poderá ser considerada quando houver:

- contrato oficial completo;
- credenciais produtivas emitidas e armazenadas de forma segura;
- autorização formal do ente competente;
- homologação concluída com evidências;
- matriz de acesso aprovada;
- tenant e operações explicitamente habilitados;
- trilha de auditoria disponível;
- procedimento de revogação testado;
- responsável operacional identificado;
- plano de resposta a falhas.

**Classificação:** `PA`.

## Dependências de validação

Antes de consolidar este artefato, precisam ser confirmados:

- perfis oficiais reconhecidos pelo MEC;
- claims e escopos do token;
- autorização por rota e método;
- restrição por ente, rede, instituição ou tenant;
- diferenças entre homologação e produção;
- processo oficial de concessão e revogação;
- requisitos de auditoria;
- responsabilidades do PGP e dos canais institucionais quando aplicáveis.

## Regra de promoção

A promoção de perfis e permissões exige rastreabilidade entre:

```text
fonte → ator → requisito → perfil → permissão → controle → teste → evidência
```

Perfis e permissões classificados como `PA` devem permanecer neste dossiê até aprovação arquitetural e validação contra o contrato oficial.
