# 07 — Casos de uso

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Estado | Casos de uso derivados em revisão |
| Última revisão | 2026-08-05 |

## Estado deste artefato

Os casos de uso abaixo são **derivações de engenharia** fundamentadas nas regras, restrições e requisitos já registrados neste dossiê.

Eles descrevem intenções funcionais e resultados esperados, mas não substituem:

- o contrato OpenAPI;
- os esquemas oficiais de payload e resposta;
- a homologação;
- as regras de autorização;
- a arquitetura oficial do SIGESC/MIG.

Todos permanecem com estado implícito **Proposto**.

## Atores identificados

| ID | Ator | Responsabilidade no contexto do dossiê | Classificação |
|---|---|---|---|
| `ATOR-MEC-API-0001-001` | Equipe técnica de homologação | Preparar testes, executar cenários, analisar respostas, registrar evidências e reportar divergências. | `DE` |
| `ATOR-MEC-API-0001-002` | Componente de integração SIGESC/MIG | Autenticar-se, serializar e validar dados, executar requisições e acompanhar lotes. | `DE` |
| `ATOR-MEC-API-0001-003` | API do Sistema Gestão Presente | Receber requisições, validar payloads, processar operações e retornar resultados. | `DE` |
| `ATOR-MEC-API-0001-004` | Canal oficial de suporte | Receber dúvidas, dificuldades e registros de erro encaminhados pela equipe técnica. | `DE` |

Esses atores representam funções analíticas. Eles não definem perfis de acesso oficiais.

## Catálogo de casos de uso

| ID | Caso de uso | Ator principal | Objetivo | Origem | Classificação |
|---|---|---|---|---|---|
| `UC-MEC-API-0001-001` | Selecionar ambiente de integração | Equipe técnica de homologação | Executar a integração no ambiente correto, com URL e credenciais correspondentes. | `RF-MEC-API-0001-005`; `RNF-MEC-API-0001-003`; `RNF-MEC-API-0001-010` | `DE` |
| `UC-MEC-API-0001-002` | Obter e reutilizar token Bearer | Componente de integração SIGESC/MIG | Autenticar requisições protegidas e reutilizar o token enquanto válido. | `RF-MEC-API-0001-001` a `RF-MEC-API-0001-004` | `DE / PC` |
| `UC-MEC-API-0001-003` | Preparar e validar payload | Componente de integração SIGESC/MIG | Serializar dados em `snake_case` e detectar inconsistências antes do envio. | `RF-MEC-API-0001-006`; `RF-MEC-API-0001-008` a `RF-MEC-API-0001-010` | `DE / PC` |
| `UC-MEC-API-0001-004` | Tratar resposta HTTP `422` | Componente de integração SIGESC/MIG | Extrair e registrar detalhes de pré-validação retornados pela API. | `RF-MEC-API-0001-011`; `RNF-MEC-API-0001-009`; `RNF-MEC-API-0001-021` | `DE` |
| `UC-MEC-API-0001-005` | Listar lotes enviados | Componente de integração SIGESC/MIG | Consultar os lotes disponíveis na rota genérica de listagem. | `RF-MEC-API-0001-012` | `DE` |
| `UC-MEC-API-0001-006` | Consultar status de lote | Componente de integração SIGESC/MIG | Acompanhar o processamento de um lote pelo `lote_id`. | `RF-MEC-API-0001-013`; `RF-MEC-API-0001-015`; `RF-MEC-API-0001-016` | `DE` |
| `UC-MEC-API-0001-007` | Consultar erros de lote | Componente de integração SIGESC/MIG | Recuperar e correlacionar os erros encontrados no processamento. | `RF-MEC-API-0001-014` a `RF-MEC-API-0001-016` | `DE` |
| `UC-MEC-API-0001-008` | Listar instituições de ensino | Equipe técnica de homologação | Consultar instituições conforme as rotas e parâmetros oficiais. | `RF-MEC-API-0001-017`; `REG-MEC-API-0001-025` | `DE` |
| `UC-MEC-API-0001-009` | Cadastrar instituição de ensino | Equipe técnica de homologação | Enviar um cadastro de instituição conforme o esquema oficial. | `RF-MEC-API-0001-018`; `REG-MEC-API-0001-025` | `DE` |
| `UC-MEC-API-0001-010` | Editar instituição de ensino | Equipe técnica de homologação | Alterar dados de uma instituição conforme as regras oficiais. | `RF-MEC-API-0001-019`; `REG-MEC-API-0001-025` | `DE` |
| `UC-MEC-API-0001-011` | Listar profissionais da educação | Equipe técnica de homologação | Consultar profissionais conforme as rotas e parâmetros oficiais. | `RF-MEC-API-0001-021`; `REG-MEC-API-0001-026` | `DE` |
| `UC-MEC-API-0001-012` | Cadastrar profissional da educação | Equipe técnica de homologação | Enviar um cadastro de profissional conforme o esquema oficial. | `RF-MEC-API-0001-022`; `REG-MEC-API-0001-026` | `DE` |
| `UC-MEC-API-0001-013` | Editar profissional da educação | Equipe técnica de homologação | Alterar dados de um profissional conforme as regras oficiais. | `RF-MEC-API-0001-023`; `REG-MEC-API-0001-026` | `DE` |
| `UC-MEC-API-0001-014` | Gerenciar vínculos de profissional | Equipe técnica de homologação | Adicionar, editar, inativar, reativar ou remover vínculos. | `RF-MEC-API-0001-024`; fonte p. 6 | `DE / PC` |
| `UC-MEC-API-0001-015` | Gerenciar funções de profissional | Equipe técnica de homologação | Adicionar ou editar funções associadas ao profissional. | `RF-MEC-API-0001-025`; fonte p. 6 | `DE / PC` |
| `UC-MEC-API-0001-016` | Gerenciar formações de profissional | Equipe técnica de homologação | Adicionar, editar ou remover formações do profissional. | `RF-MEC-API-0001-026`; fonte p. 6 | `DE / PC` |
| `UC-MEC-API-0001-017` | Testar filtros, ordenação e paginação | Equipe técnica de homologação | Verificar o comportamento dos mecanismos de consulta definidos pela documentação oficial. | `RF-MEC-API-0001-020`; `RF-MEC-API-0001-027`; `RF-MEC-API-0001-030` | `DE / PC` |
| `UC-MEC-API-0001-018` | Registrar evidência de homologação | Equipe técnica de homologação | Preservar operação, entrada controlada, resposta e observações do teste. | `RF-MEC-API-0001-028`; `RNF-MEC-API-0001-018`; `RNF-MEC-API-0001-022` | `DE` |
| `UC-MEC-API-0001-019` | Registrar e reproduzir erro | Equipe técnica de homologação | Documentar código, payload controlado, mensagem e operação para diagnóstico. | `RF-MEC-API-0001-029`; `RNF-MEC-API-0001-019`; `REG-MEC-API-0001-029` | `DE` |
| `UC-MEC-API-0001-020` | Encaminhar dificuldade ao suporte oficial | Equipe técnica de homologação | Reportar uma dificuldade após verificar documentação, parâmetros e credenciais. | `REG-MEC-API-0001-010`; fonte pp. 7–8 | `DE` |

## Especificação resumida

### `UC-MEC-API-0001-001` — Selecionar ambiente de integração

**Pré-condições**

- configuração de homologação ou produção disponível;
- URLs e credenciais segregadas;
- produção não selecionada durante testes sem autorização.

**Fluxo principal**

1. A equipe seleciona o ambiente.
2. O sistema carrega URL, credenciais e parâmetros correspondentes.
3. O ambiente ativo é identificado nos registros operacionais.
4. A operação prossegue sem misturar configurações.

**Resultado esperado**

A integração executa no ambiente selecionado, com rastreabilidade da configuração aplicada.

### `UC-MEC-API-0001-002` — Obter e reutilizar token Bearer

**Pré-condições**

- ambiente configurado;
- credenciais válidas;
- contrato da rota de autenticação disponível.

**Fluxo principal**

1. O componente verifica se existe token ainda válido.
2. Quando válido, reutiliza o token.
3. Quando ausente ou expirado, solicita ou renova o token.
4. Envia o token em `Authorization: Bearer {token}`.
5. Oculta o valor do token em logs e evidências.

**Resultado esperado**

A requisição protegida é autenticada sem exposição da credencial.

**Ponto pendente**

Endpoint, payload, resposta, expiração e renovação devem ser confirmados no contrato oficial.

### `UC-MEC-API-0001-003` — Preparar e validar payload

**Pré-condições**

- operação selecionada;
- esquema oficial disponível;
- dados de entrada controlados.

**Fluxo principal**

1. O componente mapeia os dados locais.
2. Serializa os atributos em `snake_case`.
3. Verifica campos obrigatórios.
4. Verifica tipos de dados.
5. Rejeita atributos não reconhecidos.
6. Libera o payload válido para envio.

**Resultado esperado**

Somente payload compatível com o contrato segue para a API.

### `UC-MEC-API-0001-004` — Tratar resposta HTTP `422`

**Pré-condições**

- requisição enviada;
- API retorna HTTP `422`.

**Fluxo principal**

1. O cliente preserva o código HTTP.
2. Extrai os detalhes da resposta.
3. Associa os detalhes aos campos ou regras afetados.
4. Registra o diagnóstico sem expor dados pessoais ou credenciais.
5. Distingue a falha de pré-validação de erro posterior de lote.

**Resultado esperado**

A equipe recebe diagnóstico utilizável para corrigir o payload.

### `UC-MEC-API-0001-005` — Listar lotes enviados

**Pré-condições**

- autenticação válida;
- ambiente selecionado.

**Fluxo principal**

1. O componente chama `/api/v2/lotes`.
2. Recebe a listagem.
3. Preserva os identificadores e estados retornados.
4. Relaciona, quando possível, os lotes às operações locais.

**Resultado esperado**

A equipe visualiza os lotes retornados pela API.

### `UC-MEC-API-0001-006` — Consultar status de lote

**Pré-condições**

- `lote_id` conhecido;
- autenticação válida.

**Fluxo principal**

1. O componente chama `/api/v2/lotes/{lote_id}`.
2. Preserva o status retornado.
3. Atualiza o acompanhamento local.
4. Mantém correlação com a operação de origem.

**Resultado esperado**

O estado conhecido do processamento fica disponível para acompanhamento.

### `UC-MEC-API-0001-007` — Consultar erros de lote

**Pré-condições**

- `lote_id` conhecido;
- autenticação válida.

**Fluxo principal**

1. O componente chama `/api/v2/lotes/{lote_id}/erros`.
2. Recupera os erros retornados.
3. Correlaciona os erros ao lote e à operação local.
4. Disponibiliza diagnóstico para análise.

**Resultado esperado**

Os erros de processamento ficam registrados e rastreáveis.

### `UC-MEC-API-0001-008` a `UC-MEC-API-0001-010` — Instituições de ensino

**Pré-condições comuns**

- módulo disponível no ambiente;
- autenticação válida;
- contrato oficial da operação disponível;
- massa de homologação sem dados reais.

**Fluxos principais**

- listar instituições;
- cadastrar instituição válida;
- editar instituição existente;
- consultar por código INEP quando o parâmetro oficial estiver confirmado.

**Resultados esperados**

As operações são executadas e registradas conforme o contrato oficial e o cenário de homologação.

### `UC-MEC-API-0001-011` a `UC-MEC-API-0001-016` — Profissionais da educação

**Pré-condições comuns**

- módulo disponível no ambiente;
- autenticação válida;
- contratos de profissional, vínculo, função e formação disponíveis;
- massa de homologação controlada.

**Fluxos principais**

- listar, cadastrar e editar profissional;
- consultar por CPF quando o parâmetro oficial estiver confirmado;
- adicionar, editar, inativar, reativar ou remover vínculo;
- adicionar ou editar função;
- adicionar, editar ou remover formação.

**Resultados esperados**

Cada operação produz resposta e evidência correlacionadas ao cenário executado.

### `UC-MEC-API-0001-017` — Testar filtros, ordenação e paginação

**Pré-condições**

- documentação dos parâmetros disponível;
- conjunto de dados de teste suficiente.

**Fluxo principal**

1. A equipe define os parâmetros do cenário.
2. Executa consultas com filtros.
3. Executa consultas com ordenação.
4. Executa consultas com paginação.
5. Compara o comportamento observado com a documentação.
6. Registra divergências.

**Resultado esperado**

O comportamento dos mecanismos de consulta fica comprovado ou marcado como divergente.

### `UC-MEC-API-0001-018` — Registrar evidência de homologação

**Pré-condições**

- cenário de teste identificado;
- massa de dados controlada.

**Fluxo principal**

1. A equipe registra ambiente e operação.
2. Registra entrada sanitizada.
3. Registra código e resposta recebidos.
4. Registra resultado esperado e observado.
5. Anota divergências e observações.
6. Vincula a evidência ao cenário.

**Resultado esperado**

O teste pode ser auditado e reproduzido sem exposição indevida de dados.

### `UC-MEC-API-0001-019` — Registrar e reproduzir erro

**Pré-condições**

- erro ocorrido durante a homologação.

**Fluxo principal**

1. A equipe registra o código retornado.
2. Preserva versão sanitizada do payload.
3. Registra a mensagem recebida.
4. Identifica a operação executada.
5. Registra ambiente e correlação.
6. Tenta reproduzir o cenário de forma controlada.

**Resultado esperado**

O erro possui evidência suficiente para diagnóstico e encaminhamento.

### `UC-MEC-API-0001-020` — Encaminhar dificuldade ao suporte oficial

**Pré-condições**

- documentação consultada;
- parâmetros e credenciais verificados;
- evidência da dificuldade preparada.

**Fluxo principal**

1. A equipe organiza a descrição do problema.
2. Anexa dados técnicos sanitizados.
3. Usa o canal oficial aplicável.
4. Registra o protocolo ou a referência do contato.
5. Vincula a resposta recebida ao caso de homologação.

**Resultado esperado**

A dificuldade é encaminhada de forma rastreável ao canal oficial.

## Relação entre casos de uso e homologação

| Fase | Casos de uso |
|---|---|
| Preparação | `UC-MEC-API-0001-001` a `UC-MEC-API-0001-003` |
| Tratamento de validação | `UC-MEC-API-0001-004` |
| Acompanhamento de lotes | `UC-MEC-API-0001-005` a `UC-MEC-API-0001-007` |
| Instituições | `UC-MEC-API-0001-008` a `UC-MEC-API-0001-010` |
| Profissionais | `UC-MEC-API-0001-011` a `UC-MEC-API-0001-016` |
| Consultas avançadas | `UC-MEC-API-0001-017` |
| Evidência e suporte | `UC-MEC-API-0001-018` a `UC-MEC-API-0001-020` |

## Pontos pendentes

Os seguintes elementos precisam de confirmação antes da consolidação:

- contrato da autenticação;
- formatos e esquemas de instituições e profissionais;
- contratos de vínculos, funções e formações;
- formato dos filtros por código INEP e CPF;
- parâmetros de ordenação e paginação;
- estados oficiais dos lotes;
- regras de autorização para cada operação.

## Regra de promoção

A promoção dos casos de uso exige rastreabilidade entre:

```text
fonte → regra → requisito → caso de uso → teste → evidência
```

Casos dependentes de contrato incompleto devem permanecer classificados como `DE / PC`.
