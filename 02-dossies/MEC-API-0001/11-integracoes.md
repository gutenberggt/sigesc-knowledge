# 11 — Integrações

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Estado | Integrações e dependências em revisão |
| Última revisão | 2026-08-05 |

## Estado deste artefato

Este arquivo registra as interfaces externas citadas na cartilha e as dependências técnicas derivadas para uma futura integração do SIGESC/MIG.

A cartilha é uma orientação introdutória. Ela não contém o contrato completo de autenticação, todos os endpoints, os schemas integrais, os escopos de autorização ou os critérios de liberação em produção.

Por isso, este artefato separa:

1. sistemas e interfaces diretamente identificados na fonte;
2. dependências derivadas de engenharia;
3. pontos que precisam de confirmação documental ou operacional.

Nenhum item deste arquivo, isoladamente, autoriza ativação em produção.

## Convenções

- `FD`: informação diretamente sustentada pela fonte;
- `FD / PC`: interface citada, mas com contrato técnico incompleto;
- `DE`: dependência derivada de engenharia;
- `DE / PC`: dependência válida em princípio, mas ainda condicionada ao contrato oficial;
- `PC`: ponto a confirmar.

## Sistemas e interfaces citados

| ID | Sistema ou interface | Finalidade | Mecanismo ou localização | Classificação | Referência |
|---|---|---|---|---|---|
| `INT-MEC-API-0001-001` | Sistema Gestão Presente | Plataforma federal à qual pertence a API apresentada na cartilha. | Sistema institucional do MEC. | `FD` | capa e pp. 1–2 |
| `INT-MEC-API-0001-002` | API CMDE2 — homologação | Disponibilizar ambiente de testes anterior à produção. | `https://api-cmde2.hmg.gestaopresente.mec.gov.br` | `FD` | pp. 2–3 |
| `INT-MEC-API-0001-003` | API CMDE2 — produção | Disponibilizar o ambiente produtivo da integração. | `https://api-cmde2.gestaopresente.mec.gov.br` | `FD` | p. 3 |
| `INT-MEC-API-0001-004` | Swagger UI — homologação | Consultar e testar rotas, parâmetros, payloads, respostas e erros no ambiente de testes. | `https://api-cmde2.hmg.gestaopresente.mec.gov.br/docs` | `FD` | p. 3 |
| `INT-MEC-API-0001-005` | Swagger UI — produção | Consultar a documentação interativa do ambiente produtivo. | `https://api-cmde2.gestaopresente.mec.gov.br/docs` | `FD` | p. 3 |
| `INT-MEC-API-0001-006` | Redocly — homologação | Consultar a documentação técnica estruturada do ambiente de testes. | `https://api-cmde2.hmg.gestaopresente.mec.gov.br/redoc` | `FD` | p. 3 |
| `INT-MEC-API-0001-007` | Redocly — produção | Consultar a documentação técnica estruturada do ambiente produtivo. | `https://api-cmde2.gestaopresente.mec.gov.br/redoc` | `FD` | p. 3 |
| `INT-MEC-API-0001-008` | Rota de autenticação | Gerar o token Bearer usado nas operações protegidas. | Endpoint, método, payload e resposta não são apresentados na cartilha. | `FD / PC` | p. 4 |
| `INT-MEC-API-0001-009` | Cabeçalho de autenticação | Transportar o token nas requisições protegidas. | `Authorization: Bearer {token}` | `FD` | p. 4 |
| `INT-MEC-API-0001-010` | Interface genérica de lotes | Listar lotes, consultar status e consultar erros de processamento. | `/api/v2/lotes`, `/api/v2/lotes/{lote_id}` e `/api/v2/lotes/{lote_id}/erros` | `FD` | p. 5 |
| `INT-MEC-API-0001-011` | Módulo de instituições de ensino | Listar, cadastrar, editar e consultar instituições. | Rotas, métodos, schemas e autorizações não são detalhados na cartilha. | `FD / PC` | p. 6 |
| `INT-MEC-API-0001-012` | Módulo de profissionais da educação | Listar, cadastrar, editar e gerenciar vínculos, funções e formações. | Rotas, métodos, schemas e autorizações não são detalhados na cartilha. | `FD / PC` | p. 6 |
| `INT-MEC-API-0001-013` | Interface por planilhas | Manter compatibilidade com cabeçalhos de planilha em caixa alta. | Cabeçalhos em maiúsculas, distintos dos atributos `snake_case` da API. | `FD` | p. 5 |
| `INT-MEC-API-0001-014` | Canal técnico por e-mail | Receber dúvidas relacionadas à integração, API e comunicações ligadas ao PGP. | `cgge-seb@mec.gov.br` | `FD` | p. 8 |
| `INT-MEC-API-0001-015` | Portal institucional MEC Gestão Presente | Disponibilizar informações institucionais do programa. | `www.gov.br/mec/pt-br/mec-gestao-presente` | `FD` | p. 8 |
| `INT-MEC-API-0001-016` | Fale Conosco do Gestão Presente | Disponibilizar canal institucional de atendimento. | `https://gestaopresente.mec.gov.br` | `FD` | p. 8 |

## Topologia conceitual identificada

```text
Equipe técnica
├── consulta Swagger UI e Redocly
├── executa testes no ambiente de homologação
├── registra evidências e divergências
└── aciona canais oficiais quando necessário

SIGESC/MIG
├── autentica-se pela rota oficial
├── envia Authorization: Bearer {token}
├── envia e consulta operações da API
├── acompanha lotes e erros
└── preserva correlação e evidências

API CMDE2
├── valida payloads
├── retorna HTTP 422 em falhas de pré-validação
├── processa operações
└── disponibiliza lotes, status e erros
```

A organização gráfica acima é uma derivação analítica; as interfaces e relações básicas são sustentadas pela fonte.

**Classificação:** `DE`.

## Catálogo de rotas explicitamente apresentadas

| Operação | Rota | Finalidade | Classificação |
|---|---|---|---|
| Listar lotes | `/api/v2/lotes` | Obter a relação de lotes disponíveis. | `FD` |
| Consultar lote | `/api/v2/lotes/{lote_id}` | Obter o status ou resultado conhecido de um lote. | `FD` |
| Consultar erros do lote | `/api/v2/lotes/{lote_id}/erros` | Obter erros encontrados durante o processamento. | `FD` |

A cartilha não apresenta a rota de submissão de lote nem os endpoints completos dos módulos de instituições e profissionais.

## Dependências de integração

| ID | Dependência | Necessidade técnica | Classificação | Estado |
|---|---|---|---|---|
| `DEP-MEC-API-0001-001` | Configuração segregada por ambiente | Manter URLs, credenciais, habilitação e documentação separadas entre homologação e produção. | `DE` | Proposto |
| `DEP-MEC-API-0001-002` | Contrato oficial de autenticação | Confirmar endpoint, método, payload, resposta e erros antes da implementação definitiva. | `DE / PC` | Pendente |
| `DEP-MEC-API-0001-003` | Gestão segura de credenciais | Referenciar segredos fora do código, dos payloads e das evidências. | `DE` | Proposto |
| `DEP-MEC-API-0001-004` | Gerenciamento do ciclo de vida do token | Reutilizar token válido e aplicar renovação conforme o comportamento oficial. | `DE / PC` | Pendente |
| `DEP-MEC-API-0001-005` | Contratos versionados de payload e resposta | Validar cada operação contra schemas correspondentes ao ambiente e à versão. | `DE / PC` | Pendente |
| `DEP-MEC-API-0001-006` | Mapeamento para `snake_case` | Serializar corretamente os atributos enviados pela API. | `DE` | Proposto |
| `DEP-MEC-API-0001-007` | Mapeamento de planilhas em caixa alta | Preservar compatibilidade com cabeçalhos de planilha sem misturá-los aos atributos da API. | `DE` | Proposto |
| `DEP-MEC-API-0001-008` | Tratamento estruturado de HTTP `422` | Preservar código e detalhes de pré-validação em formato utilizável para diagnóstico. | `DE / PC` | Pendente |
| `DEP-MEC-API-0001-009` | Correlação de lotes | Relacionar `lote_id`, operação local, ambiente, tenant e evidências. | `DE` | Proposto |
| `DEP-MEC-API-0001-010` | Política de acompanhamento de lotes | Definir estados, intervalos de consulta, limites e critérios de encerramento. | `DE / PC` | Pendente |
| `DEP-MEC-API-0001-011` | Proteção de dados em homologação | Utilizar massa sintética ou anonimizada e sanitizar evidências. | `DE` | Proposto |
| `DEP-MEC-API-0001-012` | Registro e encaminhamento de evidências | Preservar diagnóstico, divergências e referências de contato com o suporte oficial. | `DE` | Proposto |

## Sequência de integração derivada

```text
1. Selecionar ambiente
2. Resolver o contrato técnico da operação
3. Obter ou reutilizar token
4. Mapear e validar payload
5. Enviar requisição
6. Tratar resposta imediata
7. Correlacionar lote, quando aplicável
8. Consultar status
9. Consultar erros, quando necessário
10. Registrar evidência
11. Comparar documentação e comportamento
12. Escalar dificuldade pelo canal oficial
```

**Classificação:** `DE / PC`, pois partes da sequência dependem de contratos ainda ausentes na cartilha.

## Limites entre homologação e produção

| Aspecto | Homologação | Produção |
|---|---|---|
| Finalidade | Testar rotas, recursos, respostas e documentação. | Executar operações produtivas autorizadas. |
| Dados | Não utilizar dados reais. | Depende de autorização, contrato e controles oficiais. |
| Credenciais | Próprias do ambiente de testes. | Próprias do ambiente produtivo. |
| Ativação no SIGESC/MIG | Controlada, auditável e restrita a cenários de teste. | Bloqueada até homologação e aprovação formal. |
| Evidências | Devem registrar comportamento e divergências. | Devem preservar auditoria operacional sem expor segredos. |

A cartilha não define o procedimento completo de promoção entre ambientes.

## Canais oficiais

| Canal | Aplicação | Observação |
|---|---|---|
| `cgge-seb@mec.gov.br` | Integração, API e comunicações relacionadas ao PGP. | Encaminhar diagnóstico sanitizado e contexto suficiente. |
| Portal MEC Gestão Presente | Consulta institucional. | Não substitui o contrato técnico da API. |
| Fale Conosco | Atendimento institucional. | Registrar protocolo ou referência quando houver. |

## Pontos a confirmar

| ID | Ponto a confirmar | Impacto |
|---|---|---|
| `PC-INT-MEC-API-0001-001` | Endpoint e método da autenticação. | Bloqueia a implementação definitiva do cliente de autenticação. |
| `PC-INT-MEC-API-0001-002` | Payload e resposta da autenticação. | Bloqueia a modelagem do token e o tratamento de erros. |
| `PC-INT-MEC-API-0001-003` | Regra exata de validade e renovação do token. | Bloqueia o ciclo de vida definitivo da credencial temporária. |
| `PC-INT-MEC-API-0001-004` | Processo de emissão e gestão das credenciais de homologação. | Bloqueia testes autenticados reais. |
| `PC-INT-MEC-API-0001-005` | Processo de emissão e gestão das credenciais de produção. | Bloqueia qualquer ativação produtiva. |
| `PC-INT-MEC-API-0001-006` | Contrato e rota de submissão de lotes. | Impede completar o fluxo assíncrono de ponta a ponta. |
| `PC-INT-MEC-API-0001-007` | Estados oficiais e transições dos lotes. | Impede definir acompanhamento e encerramento definitivos. |
| `PC-INT-MEC-API-0001-008` | Schema dos erros de processamento do lote. | Impede normalizar diagnóstico e correção. |
| `PC-INT-MEC-API-0001-009` | Schema detalhado das respostas HTTP `422`. | Impede normalizar completamente a pré-validação. |
| `PC-INT-MEC-API-0001-010` | Endpoints e schemas de instituições de ensino. | Impede implementar listagem, cadastro e edição. |
| `PC-INT-MEC-API-0001-011` | Endpoints e schemas de profissionais da educação. | Impede implementar listagem, cadastro e edição. |
| `PC-INT-MEC-API-0001-012` | Endpoints e schemas de vínculos, funções e formações. | Impede implementar as relações profissionais. |
| `PC-INT-MEC-API-0001-013` | Parâmetros de consulta por código INEP e CPF. | Impede consolidar filtros e validações. |
| `PC-INT-MEC-API-0001-014` | Parâmetros de ordenação e paginação. | Impede consolidar o comportamento das consultas. |
| `PC-INT-MEC-API-0001-015` | Perfis, escopos e autorização por rota. | Impede fechar a matriz de acesso externo. |
| `PC-INT-MEC-API-0001-016` | Política de versionamento e compatibilidade da API. | Impede definir estratégia segura de atualização do cliente. |

## Critério de prontidão

A integração somente poderá ser considerada pronta para homologação real quando houver:

- credencial válida de homologação;
- contrato oficial da autenticação;
- schemas e endpoints necessários ao cenário;
- massa de testes não real;
- correlação e auditoria habilitadas;
- proteção de segredos;
- procedimento de registro de evidências.

A prontidão para produção exige, adicionalmente:

- homologação concluída;
- credencial produtiva;
- autorização formal;
- matriz de acesso validada;
- operações e tenants explicitamente habilitados;
- procedimento de revogação;
- monitoramento e resposta a falhas.

**Classificação:** `DE / PC`.

## Regra de promoção

A promoção deste artefato exige rastreabilidade entre:

```text
fonte → interface → contrato → dependência → implementação → teste → evidência
```

Dependências classificadas como `DE / PC` e pontos `PC` devem permanecer no dossiê até confirmação oficial.
