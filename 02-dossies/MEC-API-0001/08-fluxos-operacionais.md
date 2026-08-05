# 08 — Fluxos operacionais

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Estado | Fluxos derivados em revisão |
| Última revisão | 2026-08-05 |

## Estado deste artefato

Este arquivo separa:

1. sequências operacionais explicitamente identificáveis na cartilha, classificadas como `FD`;
2. fluxos derivados para o SIGESC/MIG, classificados como `DE` ou `DE / PC`.

Os fluxos derivados não substituem o contrato OpenAPI, as regras de autorização, a homologação nem a arquitetura oficial do SIGESC.

## Fluxos identificados na fonte

### Fluxo-fonte A — Preparação da homologação

1. Utilizar o ambiente de homologação antes da produção.
2. Evitar dados reais.
3. Testar o funcionamento das rotas.
4. Validar os novos recursos.
5. Verificar a consistência das respostas.
6. Avaliar a documentação técnica.
7. Identificar oportunidades de melhoria.

**Classificação:** `FD`.

**Referências:** Fonte `MEC-API-0001`, pp. 2–3.

### Fluxo-fonte B — Consulta da documentação técnica

1. Acessar Swagger UI ou Redocly no ambiente aplicável.
2. Localizar a rota da operação.
3. Verificar parâmetros de requisição.
4. Examinar exemplos de payload.
5. Examinar exemplos de resposta.
6. Verificar códigos de erro.
7. Executar o teste conforme o contrato documentado.

**Classificação:** `FD`.

**Referência:** Fonte `MEC-API-0001`, p. 3.

### Fluxo-fonte C — Autenticação Bearer

1. Gerar o token pela rota de autenticação.
2. Reutilizar o token enquanto ele estiver válido.
3. Renovar automaticamente o token conforme o mecanismo disponível.
4. Enviar o valor no cabeçalho `Authorization`.
5. Utilizar o formato `Bearer {token}`.

A cartilha informa validade atual de 5 minutos, mas não apresenta o contrato da rota de autenticação.

**Classificação:** `FD / PC`.

**Referência:** Fonte `MEC-API-0001`, p. 4.

### Fluxo-fonte D — Pré-validação de payload

1. Enviar o payload à API.
2. A API verifica campos obrigatórios.
3. A API verifica tipos de dados.
4. A API verifica atributos inválidos.
5. Quando o payload estiver incorreto, a API retorna HTTP `422`.
6. A equipe utiliza os detalhes retornados para diagnóstico.

**Classificação:** `FD`.

**Referência:** Fonte `MEC-API-0001`, p. 5.

### Fluxo-fonte E — Acompanhamento de lotes

1. Listar lotes em `/api/v2/lotes`.
2. Selecionar ou identificar o `lote_id`.
3. Consultar o status em `/api/v2/lotes/{lote_id}`.
4. Verificar se o processamento ocorreu corretamente.
5. Quando necessário, consultar erros em `/api/v2/lotes/{lote_id}/erros`.
6. Analisar os erros encontrados durante o processamento.

**Classificação:** `FD`.

**Referência:** Fonte `MEC-API-0001`, p. 5.

### Fluxo-fonte F — Testes de instituições de ensino

1. Listar instituições.
2. Consultar instituições por código INEP.
3. Cadastrar uma instituição.
4. Editar uma instituição.
5. Consultar os lotes relacionados às operações.
6. Analisar respostas e erros.

O formato dos parâmetros e dos payloads não é definido na cartilha.

**Classificação:** `FD / PC`.

**Referência:** Fonte `MEC-API-0001`, p. 6.

### Fluxo-fonte G — Testes de profissionais da educação

1. Listar profissionais.
2. Consultar profissionais por CPF.
3. Cadastrar um profissional.
4. Editar os dados do profissional.
5. Adicionar, editar, inativar, reativar ou remover vínculo.
6. Adicionar ou editar função.
7. Adicionar, editar ou remover formação.
8. Consultar os lotes relacionados às operações.
9. Analisar respostas e erros.

Os contratos de profissional, vínculo, função, formação e consulta por CPF não são apresentados na cartilha.

**Classificação:** `FD / PC`.

**Referência:** Fonte `MEC-API-0001`, p. 6.

### Fluxo-fonte H — Diagnóstico e suporte

1. Registrar observações durante os testes.
2. Registrar respostas inesperadas.
3. Registrar divergências entre documentação e comportamento.
4. Em caso de dificuldade, consultar a documentação.
5. Verificar parâmetros e credenciais.
6. Em caso de erro, registrar código, payload, mensagem e operação.
7. Encaminhar a dificuldade pelo canal oficial aplicável.

**Classificação:** `FD`.

**Referências:** Fonte `MEC-API-0001`, pp. 7–8.

## Catálogo de fluxos derivados para o SIGESC/MIG

| ID | Fluxo | Objetivo | Casos de uso | Classificação | Estado |
|---|---|---|---|---|---|
| `FLX-MEC-API-0001-001` | Preparar sessão de homologação | Garantir ambiente, configuração, massa controlada e identificação do teste. | `UC-MEC-API-0001-001`; `UC-MEC-API-0001-018` | `DE` | Proposto |
| `FLX-MEC-API-0001-002` | Resolver contrato da operação | Obter no Swagger, Redocly ou OpenAPI o contrato necessário antes da execução. | `UC-MEC-API-0001-003`; `UC-MEC-API-0001-017` | `DE / PC` | Proposto |
| `FLX-MEC-API-0001-003` | Autenticar requisição | Obter, reutilizar ou renovar token e montar o cabeçalho protegido. | `UC-MEC-API-0001-002` | `DE / PC` | Proposto |
| `FLX-MEC-API-0001-004` | Preparar, validar e enviar payload | Mapear dados, validar contrato, enviar requisição e tratar pré-validação. | `UC-MEC-API-0001-003`; `UC-MEC-API-0001-004` | `DE / PC` | Proposto |
| `FLX-MEC-API-0001-005` | Acompanhar lote assíncrono | Correlacionar `lote_id`, consultar status, consultar erros e registrar resultado. | `UC-MEC-API-0001-005` a `UC-MEC-API-0001-007` | `DE / PC` | Proposto |
| `FLX-MEC-API-0001-006` | Homologar operações de instituições | Executar listagem, cadastro, edição e consultas previstas para instituições. | `UC-MEC-API-0001-008` a `UC-MEC-API-0001-010`; `UC-MEC-API-0001-017` | `DE / PC` | Proposto |
| `FLX-MEC-API-0001-007` | Homologar operações de profissionais | Executar operações de profissional, vínculo, função, formação e consulta. | `UC-MEC-API-0001-011` a `UC-MEC-API-0001-017` | `DE / PC` | Proposto |
| `FLX-MEC-API-0001-008` | Registrar evidência e escalar dificuldade | Preservar diagnóstico sanitizado, registrar divergência e usar o suporte oficial. | `UC-MEC-API-0001-018` a `UC-MEC-API-0001-020` | `DE` | Proposto |

## Fluxos derivados detalhados

### `FLX-MEC-API-0001-001` — Preparar sessão de homologação

**Entrada**

- cenário de teste identificado;
- ambiente de homologação disponível;
- massa sintética ou anonimizada;
- responsável técnico definido.

**Sequência**

1. Confirmar que a árvore de configuração aponta para homologação.
2. Carregar URL e credenciais próprias do ambiente.
3. Bloquear o uso de configuração de produção.
4. Selecionar o cenário e os requisitos rastreados.
5. Preparar dados sem informações pessoais reais.
6. Registrar data, ambiente, responsável e identificador da execução.
7. Autorizar o início do teste.

**Saída**

Sessão de homologação identificada e apta à execução.

**Falhas previstas**

- configuração de produção selecionada;
- credencial ausente;
- massa de dados inadequada;
- cenário sem contrato suficiente.

### `FLX-MEC-API-0001-002` — Resolver contrato da operação

**Entrada**

- operação pretendida;
- ambiente selecionado.

**Sequência**

1. Localizar a operação no Swagger UI, Redocly ou OpenAPI.
2. Confirmar método HTTP e endpoint.
3. Confirmar parâmetros.
4. Confirmar esquema do payload.
5. Confirmar esquema da resposta.
6. Confirmar códigos de erro.
7. Registrar a versão ou referência consultada.
8. Interromper a execução quando o contrato estiver ausente ou ambíguo.

**Saída**

Contrato técnico identificado para o cenário, ou ponto de confirmação aberto.

### `FLX-MEC-API-0001-003` — Autenticar requisição

**Entrada**

- ambiente configurado;
- credenciais disponíveis;
- contrato de autenticação confirmado.

**Sequência**

1. Verificar se há token ainda válido.
2. Reutilizar o token quando aplicável.
3. Quando necessário, solicitar ou renovar o token.
4. Registrar apenas metadados não sensíveis da autenticação.
5. Montar `Authorization: Bearer {token}`.
6. Prosseguir para a operação protegida.
7. Em falha de autenticação, interromper o fluxo e registrar diagnóstico sanitizado.

**Saída**

Cabeçalho de autenticação válido para a requisição.

**Ponto pendente**

Rota, payload, resposta, validade e renovação precisam de confirmação oficial.

### `FLX-MEC-API-0001-004` — Preparar, validar e enviar payload

**Entrada**

- contrato resolvido;
- dados de entrada controlados;
- autenticação válida.

**Sequência**

1. Mapear os dados locais para o modelo externo.
2. Serializar atributos em `snake_case`.
3. Validar campos obrigatórios.
4. Validar tipos de dados.
5. Rejeitar atributos não reconhecidos.
6. Sanitizar a cópia destinada à evidência.
7. Enviar a requisição.
8. Preservar código HTTP e resposta.
9. Quando houver HTTP `422`, extrair detalhes e devolver o cenário para correção.
10. Quando houver aceitação para processamento, prosseguir para correlação e acompanhamento.

**Saída**

Requisição validada e resposta inicial registrada.

### `FLX-MEC-API-0001-005` — Acompanhar lote assíncrono

**Entrada**

- operação enviada;
- `lote_id` disponível ou lote localizável.

**Sequência**

1. Persistir o `lote_id`.
2. Correlacionar o lote à operação local.
3. Consultar `/api/v2/lotes/{lote_id}`.
4. Registrar o status retornado.
5. Enquanto o estado não for terminal, repetir a consulta segundo política operacional aprovada.
6. Quando houver falha ou indicação de erro, consultar `/api/v2/lotes/{lote_id}/erros`.
7. Registrar erros e resultado final.
8. Encerrar o acompanhamento sem presumir sucesso pelo simples aceite inicial.

**Saída**

Resultado conhecido e rastreável do lote.

**Pontos pendentes**

Estados oficiais, transições, intervalos de consulta e limites de repetição não são definidos pela cartilha.

### `FLX-MEC-API-0001-006` — Homologar operações de instituições

**Entrada**

- módulo disponível;
- contratos resolvidos;
- massa controlada;
- autenticação válida.

**Sequência**

1. Executar listagem de instituições.
2. Testar consulta por código INEP quando o parâmetro estiver confirmado.
3. Executar cadastro válido.
4. Executar edição válida.
5. Executar cenários inválidos previstos no contrato.
6. Correlacionar lotes quando aplicável.
7. Comparar resultado observado com a documentação.
8. Registrar evidências e divergências.

**Saída**

Cobertura de homologação das operações de instituições.

### `FLX-MEC-API-0001-007` — Homologar operações de profissionais

**Entrada**

- módulo disponível;
- contratos de profissional, vínculo, função e formação resolvidos;
- massa controlada;
- autenticação válida.

**Sequência**

1. Executar listagem de profissionais.
2. Testar consulta por CPF quando o parâmetro estiver confirmado.
3. Executar cadastro e edição.
4. Executar operações de vínculo.
5. Executar operações de função.
6. Executar operações de formação.
7. Executar cenários inválidos previstos no contrato.
8. Correlacionar lotes quando aplicável.
9. Comparar resultado observado com a documentação.
10. Registrar evidências e divergências.

**Saída**

Cobertura de homologação das operações de profissionais.

### `FLX-MEC-API-0001-008` — Registrar evidência e escalar dificuldade

**Entrada**

- execução concluída ou interrompida;
- resposta, erro ou divergência disponível.

**Sequência**

1. Identificar cenário, ambiente e operação.
2. Registrar código HTTP e mensagem recebida.
3. Preservar payload sanitizado quando necessário.
4. Registrar resultado esperado e observado.
5. Registrar correlação e `lote_id`, quando existentes.
6. Remover tokens, credenciais e dados pessoais desnecessários.
7. Tentar reprodução controlada.
8. Consultar novamente documentação, parâmetros e credenciais.
9. Quando a dificuldade persistir, encaminhar ao canal oficial.
10. Vincular protocolo e resposta ao cenário.

**Saída**

Evidência auditável e, quando aplicável, solicitação de suporte rastreável.

## Estados analíticos propostos

Para organizar o acompanhamento interno, o SIGESC/MIG poderá utilizar estados analíticos como:

```text
PREPARING
READY
AUTHENTICATING
VALIDATING
SENDING
ACCEPTED
TRACKING
SUCCEEDED
FAILED
BLOCKED
```

Esses nomes não são estados oficiais da API. Sua adoção depende de decisão arquitetural.

**Classificação:** `PA`.

## Controles transversais

Todos os fluxos derivados devem:

- identificar o ambiente;
- preservar correlação;
- impedir exposição de token e credenciais;
- evitar dados reais em homologação;
- distinguir HTTP `422` de erro posterior de lote;
- registrar divergência entre documentação e comportamento;
- manter produção bloqueada enquanto as dependências oficiais não forem satisfeitas.

**Classificação:** `DE`.

## Dependências de validação

Permanecem pendentes:

- contrato da autenticação;
- esquemas das operações;
- regras de autorização;
- estados e transições dos lotes;
- política de repetição de consultas;
- parâmetros de filtros, ordenação e paginação;
- formatos de código INEP e CPF;
- contratos de vínculos, funções e formações.

## Regra de promoção

A promoção dos fluxos exige rastreabilidade entre:

```text
fonte → regra → requisito → caso de uso → fluxo → teste → evidência
```

Fluxos dependentes de contrato incompleto devem permanecer classificados como `DE / PC`.
