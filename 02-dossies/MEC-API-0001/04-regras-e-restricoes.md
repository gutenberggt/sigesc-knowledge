# 04 — Regras e restrições

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Estado | Regras e restrições identificadas |
| Última revisão | 2026-08-05 |

## Critério de classificação

Este artefato registra determinações, condições operacionais e limitações explicitamente apresentadas pela fonte.

- `FD`: afirmação diretamente sustentada pela cartilha;
- `FD / PC`: afirmação presente na cartilha, mas dependente de confirmação técnica complementar;
- `DE`: derivação de engenharia, não apresentada como determinação oficial.

## Regras e restrições da fonte

| ID | Regra ou restrição | Natureza | Classificação | Referência |
|---|---|---|---|---|
| `REG-MEC-API-0001-001` | A nova versão da API implementa o Conjunto Mínimo de Dados da Educação Básica — CMDEB, instituído pela Portaria MEC nº 832/2025. | Contexto normativo declarado | `FD` | p. 2 |
| `REG-MEC-API-0001-002` | O ambiente de homologação deve ser utilizado para testes antes do uso em produção. | Restrição operacional | `FD` | p. 2 |
| `REG-MEC-API-0001-003` | Os dados enviados ao ambiente de homologação serão posteriormente descartados. | Regra do ambiente | `FD` | p. 2 |
| `REG-MEC-API-0001-004` | A cartilha não recomenda o envio de dados reais ao ambiente de homologação. | Restrição de dados | `FD` | p. 2 |
| `REG-MEC-API-0001-005` | As equipes técnicas devem testar o funcionamento das rotas. | Orientação de homologação | `FD` | p. 3 |
| `REG-MEC-API-0001-006` | As equipes técnicas devem validar os novos recursos disponibilizados. | Orientação de homologação | `FD` | p. 3 |
| `REG-MEC-API-0001-007` | As equipes técnicas devem verificar a consistência das respostas da API. | Orientação de homologação | `FD` | p. 3 |
| `REG-MEC-API-0001-008` | As equipes técnicas devem avaliar a documentação técnica disponibilizada. | Orientação de homologação | `FD` | p. 3 |
| `REG-MEC-API-0001-009` | As equipes técnicas devem identificar oportunidades de melhoria durante os testes. | Orientação de homologação | `FD` | p. 3 |
| `REG-MEC-API-0001-010` | Swagger UI e Redocly devem ser consultados para rotas, parâmetros, exemplos de payload, exemplos de resposta e códigos de erro. | Referência técnica oficial | `FD` | p. 3 |
| `REG-MEC-API-0001-011` | A autenticação da nova versão utiliza token Bearer. | Regra de autenticação | `FD` | p. 4 |
| `REG-MEC-API-0001-012` | O token Bearer é gerado por uma rota de autenticação, cujo contrato não é apresentado na cartilha. | Regra incompleta | `FD / PC` | p. 4 |
| `REG-MEC-API-0001-013` | A validade informada para o token é de 5 minutos, descrita pela fonte como validade atual. | Restrição temporal sujeita a confirmação | `FD / PC` | p. 4 |
| `REG-MEC-API-0001-014` | O token possui renovação automática. | Regra de autenticação | `FD` | p. 4 |
| `REG-MEC-API-0001-015` | O token deve ser reutilizado enquanto permanecer válido. | Regra de autenticação | `FD` | p. 4 |
| `REG-MEC-API-0001-016` | O token deve ser enviado no cabeçalho `Authorization` no formato `Bearer {token}`. | Regra de requisição | `FD` | p. 4 |
| `REG-MEC-API-0001-017` | Os atributos da nova versão da API adotam a convenção `snake_case`. | Regra de nomenclatura | `FD` | p. 4 |
| `REG-MEC-API-0001-018` | Os cabeçalhos das planilhas permanecem em caixa alta. | Regra de nomenclatura | `FD` | p. 4 |
| `REG-MEC-API-0001-019` | A API realiza pré-validação dos dados antes do processamento. | Regra de processamento | `FD` | p. 5 |
| `REG-MEC-API-0001-020` | A pré-validação verifica campos obrigatórios, tipos de dados e atributos inválidos. | Regra de validação | `FD` | p. 5 |
| `REG-MEC-API-0001-021` | Payloads incorretos retornam HTTP `422` com detalhes para diagnóstico. | Regra de erro de validação | `FD` | p. 5 |
| `REG-MEC-API-0001-022` | A listagem de lotes utiliza a rota `/api/v2/lotes`. | Regra de consulta | `FD` | p. 5 |
| `REG-MEC-API-0001-023` | A consulta do status de um lote utiliza a rota `/api/v2/lotes/{lote_id}`. | Regra de consulta | `FD` | p. 5 |
| `REG-MEC-API-0001-024` | A consulta dos erros de um lote utiliza a rota `/api/v2/lotes/{lote_id}/erros`. | Regra de consulta | `FD` | p. 5 |
| `REG-MEC-API-0001-025` | O módulo de instituições de ensino disponibilizado para homologação permite listar, cadastrar e editar registros. | Escopo funcional declarado | `FD` | p. 6 |
| `REG-MEC-API-0001-026` | O módulo de profissionais de educação disponibilizado para homologação permite listar, cadastrar, editar, gerenciar vínculos e gerenciar formações. | Escopo funcional declarado | `FD` | p. 6 |
| `REG-MEC-API-0001-027` | Os testes devem avaliar filtros, ordenação e paginação, embora seus parâmetros não sejam definidos na cartilha. | Orientação tecnicamente incompleta | `FD / PC` | p. 7 |
| `REG-MEC-API-0001-028` | Durante a homologação, devem ser registradas observações, respostas inesperadas e divergências entre documentação e comportamento. | Regra de evidência | `FD` | p. 7 |
| `REG-MEC-API-0001-029` | Em caso de erro, devem ser registrados o código retornado, o payload enviado, a mensagem recebida e a operação executada. | Regra de diagnóstico | `FD` | p. 7 |

## Restrições analíticas

### Contrato técnico incompleto

A cartilha não apresenta integralmente:

- rota, payload e resposta da autenticação;
- esquemas completos de requisição e resposta;
- parâmetros de filtros, ordenação e paginação;
- formatos e validações de código INEP e CPF;
- esquemas de vínculos, funções e formações;
- política de versionamento e compatibilidade;
- procedimento técnico completo relacionado à chave PGP.

Esses elementos devem permanecer como `PC` até validação em Swagger UI, Redocly, contrato OpenAPI, credenciais ou orientação oficial complementar.

### Escopo dos módulos

A cartilha descreve instituições de ensino e profissionais de educação como módulos disponíveis para homologação naquele contexto. Isso não comprova que sejam os únicos módulos existentes ou que o mesmo escopo permaneça vigente em produção.

**Classificação:** `DE`, fundamentada no caráter introdutório e temporal da fonte.

### Limite de autorização

A cartilha orienta preparação e execução de testes, mas não constitui, isoladamente, autorização para ativar o provider oficial em produção.

**Classificação:** `DE`.

## Relação com os próximos artefatos

As regras deste arquivo serão utilizadas como origem para:

- requisitos funcionais em `05-requisitos-funcionais.md`;
- requisitos não funcionais em `06-requisitos-nao-funcionais.md`;
- casos de uso em `07-casos-de-uso.md`;
- fluxos operacionais em `08-fluxos-operacionais.md`;
- matriz de rastreabilidade em `14-rastreabilidade.md`.

A derivação deverá preservar o identificador da regra de origem.
