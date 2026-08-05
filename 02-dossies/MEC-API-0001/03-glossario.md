# 03 — Glossário

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Estado | Glossário analítico em elaboração |
| Última revisão | 2026-08-05 |

## Critério editorial

As definições abaixo registram o significado ou o uso dos termos **dentro da fonte analisada**. Não pretendem substituir definições normativas, padrões técnicos externos ou o contrato OpenAPI.

Quando a cartilha apenas cita um termo sem defini-lo tecnicamente, essa limitação é explicitada.

## Termos

| ID | Termo | Definição ou uso na fonte | Classificação | Referência |
|---|---|---|---|---|
| `GLO-MEC-API-0001-001` | API do Sistema Gestão Presente | Interface utilizada pelas redes de ensino para enviar, consultar e validar dados no Sistema Gestão Presente. A cartilha orienta seu uso nos ambientes de homologação e produção. | `FD` | pp. 2–7 |
| `GLO-MEC-API-0001-002` | Nova versão | Versão da API que implementa o CMDEB e incorpora mudanças em autenticação, rotas de lotes, nomenclatura, pré-validação e documentação técnica. | `FD` | p. 2 |
| `GLO-MEC-API-0001-003` | CMDEB | Sigla de **Conjunto Mínimo de Dados da Educação Básica**, instituído pela Portaria MEC nº 832/2025 e implementado pela nova versão da API. | `FD` | p. 2 |
| `GLO-MEC-API-0001-004` | Ambiente de homologação | Ambiente estável destinado a testes antes da produção. Os dados enviados nele serão descartados posteriormente, e a cartilha não recomenda dados reais. | `FD` | p. 2 |
| `GLO-MEC-API-0001-005` | Ambiente de produção | Ambiente de utilização efetiva da API, apresentado em contraste com a homologação. | `FD` | pp. 2–3 |
| `GLO-MEC-API-0001-006` | Documentação oficial da API | Documentação online que apresenta rotas, parâmetros de requisição, exemplos de payload, exemplos de resposta e códigos de erro. | `FD` | p. 3 |
| `GLO-MEC-API-0001-007` | Swagger UI | Modo interativo da documentação, utilizado para visualizar e testar diretamente as rotas da API. | `FD` | p. 3 |
| `GLO-MEC-API-0001-008` | Redocly | Modo de leitura organizado da documentação, destinado ao entendimento das rotas. | `FD` | p. 3 |
| `GLO-MEC-API-0001-009` | Rota | Caminho operacional da API utilizado para executar uma ação ou consultar um recurso. A fonte apresenta rotas de autenticação e de lotes. | `FD` | pp. 3–5 |
| `GLO-MEC-API-0001-010` | Parâmetro de requisição | Informação utilizada em uma requisição e documentada nas interfaces oficiais. A fonte recomenda verificar se os parâmetros usados estão corretos. | `FD` | pp. 3 e 7 |
| `GLO-MEC-API-0001-011` | Payload | Conjunto de dados enviado em uma requisição. A API realiza sua pré-validação antes do processamento. | `FD` | pp. 3, 5 e 7 |
| `GLO-MEC-API-0001-012` | Resposta da API | Retorno produzido pela API. A cartilha orienta verificar sua consistência e registrar respostas inesperadas. | `FD` | pp. 3 e 7 |
| `GLO-MEC-API-0001-013` | Código de erro | Código retornado quando ocorre falha. Deve ser registrado junto com payload, mensagem e operação. | `FD` | pp. 3 e 7 |
| `GLO-MEC-API-0001-014` | Token Bearer | Token usado pela nova versão para autenticar as requisições. A cartilha informa validade atual de 5 minutos, renovação automática e reutilização enquanto válido. | `FD` | p. 4 |
| `GLO-MEC-API-0001-015` | Rota de autenticação | Rota citada como responsável por gerar o token Bearer. Seu endpoint, payload e resposta não são apresentados na cartilha. | `FD` / `PC` | p. 4 |
| `GLO-MEC-API-0001-016` | Cabeçalho `Authorization` | Cabeçalho da requisição no qual o token deve ser enviado no formato `Authorization: Bearer {token}`. | `FD` | p. 4 |
| `GLO-MEC-API-0001-017` | `camelCase` | Convenção usada na versão anterior, exemplificada por `formaOrganizacaoTurma`. | `FD` | p. 4 |
| `GLO-MEC-API-0001-018` | `snake_case` | Convenção adotada pela nova versão para os nomes dos atributos, exemplificada por `forma_organizacao_turma`. | `FD` | p. 4 |
| `GLO-MEC-API-0001-019` | Cabeçalhos em caixa alta | Convenção mantida nas planilhas do sistema, exemplificada por `FORMA_ORGANIZACAO_TURMA`. | `FD` | p. 4 |
| `GLO-MEC-API-0001-020` | Pré-validação de dados | Validação automática realizada antes do processamento do payload, abrangendo campos obrigatórios, tipos de dados e atributos inválidos. | `FD` | p. 5 |
| `GLO-MEC-API-0001-021` | Campo obrigatório | Campo cuja ausência torna o payload incorreto segundo a pré-validação. | `FD` | p. 5 |
| `GLO-MEC-API-0001-022` | Tipo de dado | Tipo esperado para um campo. O envio de tipo incorreto é apresentado como cenário de teste de validação. | `FD` | p. 5 |
| `GLO-MEC-API-0001-023` | Atributo inválido | Atributo não reconhecido pela API e identificado durante a pré-validação. | `FD` | p. 5 |
| `GLO-MEC-API-0001-024` | HTTP `422` | Código de status retornado quando o payload está incorreto; o corpo da resposta inclui detalhes para diagnóstico. | `FD` | p. 5 |
| `GLO-MEC-API-0001-025` | Lote | Unidade de envio de dados que pode ser listada, acompanhada quanto ao processamento e consultada quanto a erros. | `FD` | pp. 5–6 |
| `GLO-MEC-API-0001-026` | `lote_id` | Identificador variável usado nas rotas de consulta de status e de erros de um lote específico. | `FD` | p. 5 |
| `GLO-MEC-API-0001-027` | Listagem de lotes | Operação que permite visualizar todos os lotes enviados por meio de `/api/v2/lotes`. | `FD` | p. 5 |
| `GLO-MEC-API-0001-028` | Status do lote | Informação consultada para verificar se determinado lote foi processado corretamente. | `FD` | p. 5 |
| `GLO-MEC-API-0001-029` | Erros do lote | Erros encontrados durante o processamento e consultados em `/api/v2/lotes/{lote_id}/erros`. | `FD` | p. 5 |
| `GLO-MEC-API-0001-030` | Módulo | Agrupamento de operações da API disponibilizado para homologação. A cartilha apresenta módulos de instituições e profissionais. | `FD` | p. 6 |
| `GLO-MEC-API-0001-031` | Instituição de ensino | Entidade da rede para a qual o módulo permite listar, cadastrar e editar registros. | `FD` | p. 6 |
| `GLO-MEC-API-0001-032` | Código INEP | Valor citado como filtro para listar instituições de ensino durante os testes. A cartilha não detalha seu formato. | `FD` / `PC` | p. 6 |
| `GLO-MEC-API-0001-033` | Profissional da educação | Entidade cujo módulo permite listar, cadastrar, editar dados e gerenciar vínculos e formações. | `FD` | p. 6 |
| `GLO-MEC-API-0001-034` | CPF | Valor citado como critério para consultar profissionais durante os testes. A cartilha não define formato ou validações. | `FD` / `PC` | p. 6 |
| `GLO-MEC-API-0001-035` | Vínculo | Relação de um profissional que pode ser adicionada, editada, inativada, reativada ou removida conforme os exemplos de teste. A fonte não apresenta seu esquema. | `FD` / `PC` | p. 6 |
| `GLO-MEC-API-0001-036` | Função | Informação associada ao profissional que pode ser adicionada ou editada nos exemplos de teste. A fonte não apresenta seu esquema. | `FD` / `PC` | p. 6 |
| `GLO-MEC-API-0001-037` | Formação | Informação do profissional que pode ser adicionada, editada ou removida. A fonte não apresenta seu esquema. | `FD` / `PC` | p. 6 |
| `GLO-MEC-API-0001-038` | Filtro, ordenação e paginação | Recursos cujo funcionamento deve ser avaliado durante a homologação. Seus parâmetros não são especificados na cartilha. | `FD` / `PC` | p. 7 |
| `GLO-MEC-API-0001-039` | Credencial de acesso | Elemento de acesso cuja validade deve ser confirmada quando houver dificuldades nos testes. A fonte não detalha seu formato. | `FD` / `PC` | p. 7 |
| `GLO-MEC-API-0001-040` | Fale Conosco | Canal oficial indicado para chamados, dificuldades e dúvidas sobre o envio de dados pelo Sistema Gestão Presente. | `FD` | pp. 7–8 |
| `GLO-MEC-API-0001-041` | Chave PGP | Chave citada no contexto do envio de ofício para integração por API. A cartilha não define sua natureza, geração, formato ou uso técnico. | `FD` / `PC` | p. 8 |
| `GLO-MEC-API-0001-042` | Integração | Conexão operacional entre as redes de ensino e o Sistema Gestão Presente, cuja correção deve ser verificada na homologação. | `FD` | p. 7 |

## Termos que exigem contrato complementar

Os seguintes termos aparecem na cartilha, mas permanecem tecnicamente incompletos sem Swagger, Redocly, contrato OpenAPI, credenciais ou orientação oficial adicional:

- rota de autenticação;
- código INEP;
- CPF;
- vínculo;
- função;
- formação;
- filtros, ordenação e paginação;
- credenciais de acesso;
- chave PGP.

**Classificação:** `PC`.

## Limite de promoção

Este glossário permanece no dossiê. Seus termos somente devem ser promovidos para `03-conhecimento-consolidado/glossario/` após revisão transversal, eliminação de ambiguidades e validação contra fontes técnicas complementares.
