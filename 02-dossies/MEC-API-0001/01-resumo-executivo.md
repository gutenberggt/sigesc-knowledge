# 01 — Resumo executivo

## Visão geral

A fonte `MEC-API-0001` apresenta orientações oficiais introdutórias para a utilização da nova versão da API do Sistema Gestão Presente nos ambientes de homologação e produção.

A nova versão implementa o Conjunto Mínimo de Dados da Educação Básica — CMDEB, instituído pela Portaria MEC nº 832/2025, e incorpora mudanças em autenticação, nomenclatura, validação de payloads, consulta de lotes e documentação técnica.

**Classificação:** `FD`

**Referências:** Fonte `MEC-API-0001`, pp. 2–3.

## Principais determinações da fonte

### 1. Homologação antes da produção

O ambiente de homologação é apresentado como espaço estável para testes prévios à utilização em produção. Os dados enviados nesse ambiente serão posteriormente descartados, e a cartilha não recomenda o envio de dados reais.

**Classificação:** `FD`

**Referência:** Fonte `MEC-API-0001`, p. 2.

### 2. Documentação técnica online

A cartilha direciona desenvolvedores e equipes técnicas para Swagger UI e Redoc, nos ambientes de homologação e produção. Essa documentação contém rotas, parâmetros, exemplos de payload, exemplos de resposta e códigos de erro.

**Classificação:** `FD`

**Referência:** Fonte `MEC-API-0001`, p. 3.

### 3. Autenticação por token Bearer

A nova versão utiliza token Bearer. A cartilha informa validade atual de 5 minutos, renovação automática, reutilização enquanto válido e envio no cabeçalho `Authorization`.

**Classificação:** `FD`

**Referência:** Fonte `MEC-API-0001`, p. 4.

### 4. Padronização de nomenclatura

Os atributos da API adotam `snake_case`. Nas planilhas, os cabeçalhos permanecem em caixa alta.

**Classificação:** `FD`

**Referência:** Fonte `MEC-API-0001`, p. 4.

### 5. Pré-validação de payloads

Antes do processamento, a API verifica campos obrigatórios, tipos de dados e atributos inválidos. Payloads incorretos retornam HTTP `422` com detalhes para diagnóstico.

**Classificação:** `FD`

**Referência:** Fonte `MEC-API-0001`, p. 5.

### 6. Consulta genérica de lotes

A cartilha apresenta três rotas genéricas:

| Finalidade | Endpoint |
|---|---|
| Listar lotes | `/api/v2/lotes` |
| Consultar o status de um lote | `/api/v2/lotes/{lote_id}` |
| Consultar erros de um lote | `/api/v2/lotes/{lote_id}/erros` |

**Classificação:** `FD`

**Referência:** Fonte `MEC-API-0001`, p. 5.

### 7. Módulos disponíveis para homologação

A cartilha descreve dois módulos disponíveis para testes:

- instituições de ensino: listar, cadastrar e editar;
- profissionais de educação: listar, cadastrar, editar, gerenciar vínculos e gerenciar formações.

**Classificação:** `FD`

**Referência:** Fonte `MEC-API-0001`, p. 6.

### 8. Registro de testes e erros

Durante a homologação, as equipes devem registrar observações, respostas inesperadas e divergências entre documentação e comportamento. Em caso de erro, devem anotar o código retornado, o payload enviado, a mensagem recebida e a operação executada.

**Classificação:** `FD`

**Referência:** Fonte `MEC-API-0001`, p. 7.

## Principais impactos de engenharia

1. O cliente de integração precisa centralizar a obtenção, reutilização e renovação automática do token Bearer.
2. O mapeamento de dados precisa distinguir nomes internos, atributos `snake_case` da API e cabeçalhos em caixa alta das planilhas.
3. Erros de pré-validação HTTP `422` devem ser tratados separadamente de falhas de processamento do lote.
4. O fluxo de envio deve acompanhar o ciclo assíncrono do lote: criação ou envio, consulta de status e consulta de erros.
5. A homologação deve utilizar dados sintéticos ou anonimizados, sem envio de dados reais.
6. Testes de contrato devem comparar a documentação oficial com o comportamento observado da API.
7. Evidências de homologação devem registrar requisição, resposta, operação, ambiente e correlação, sem expor credenciais ou dados pessoais.

**Classificação:** `DE` — derivações de engenharia fundamentadas nas orientações da fonte.

## Pontos a confirmar

| ID | Ponto | Motivo |
|---|---|---|
| `PC-MEC-API-0001-001` | Rota, payload e resposta da autenticação | A cartilha menciona a rota de autenticação, mas não apresenta seu contrato. |
| `PC-MEC-API-0001-002` | Regra vigente de expiração e renovação do token | A validade é descrita como “atual: 5 minutos”. |
| `PC-MEC-API-0001-003` | Esquemas completos de requisição e resposta | A cartilha remete ao Swagger e ao Redoc. |
| `PC-MEC-API-0001-004` | Parâmetros de filtro, ordenação e paginação | A fonte recomenda testá-los, mas não define seus contratos. |
| `PC-MEC-API-0001-005` | Conjunto completo de módulos e rotas disponíveis | A cartilha descreve apenas módulos disponíveis para homologação naquele contexto. |
| `PC-MEC-API-0001-006` | Processo operacional de credenciamento e uso da chave PGP | A fonte informa o canal de contato, mas não detalha o procedimento técnico completo. |
| `PC-MEC-API-0001-007` | Política de versionamento e compatibilidade da API | Não há regra de versionamento ou de descontinuação na cartilha. |

**Classificação:** `PC`.

## Conclusão executiva

A cartilha confirma a direção técnica da nova versão e fornece orientações suficientes para preparar a homologação, estruturar o cliente de autenticação, modelar o acompanhamento de lotes e organizar os testes.

Entretanto, ela não constitui, isoladamente, o contrato técnico completo da integração. A implementação do provider oficial e qualquer ativação em produção dependem da validação do Swagger, do Redoc, do contrato OpenAPI aplicável, das credenciais e dos resultados de homologação.

**Classificação:** `DE`.

## Estado da análise

- síntese da cartilha: concluída;
- contrato técnico completo: pendente;
- homologação oficial: pendente;
- provider oficial de produção: não autorizado por esta fonte isoladamente.
