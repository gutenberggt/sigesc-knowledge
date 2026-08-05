# 05 — Requisitos funcionais

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte principal | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Estado | Requisitos derivados em revisão |
| Última revisão | 2026-08-05 |

## Estado deste artefato

Os requisitos abaixo são **derivações de engenharia** produzidas a partir das regras e restrições catalogadas em `04-regras-e-restricoes.md`.

Eles permanecem neste dossiê enquanto não forem:

1. confrontados com Swagger UI, Redocly e contrato OpenAPI;
2. validados em ambiente de homologação;
3. revisados contra a arquitetura vigente do SIGESC/MIG;
4. aprovados para promoção ao conhecimento consolidado.

Nenhum requisito deste arquivo, isoladamente, autoriza ativação em produção.

## Convenções

- `DE`: derivação de engenharia sustentada pela fonte;
- `DE / PC`: derivação válida em princípio, mas com contrato técnico ainda incompleto;
- `Proposto`: requisito ainda não promovido nem aprovado como requisito corporativo consolidado.

## Requisitos funcionais derivados

| ID | Requisito | Origem | Classificação | Estado |
|---|---|---|---|---|
| `RF-MEC-API-0001-001` | O componente de integração deve obter um token Bearer por meio da rota oficial de autenticação antes de executar operações protegidas. | `REG-MEC-API-0001-011`; `REG-MEC-API-0001-012` | `DE / PC` | Proposto |
| `RF-MEC-API-0001-002` | O componente de integração deve reutilizar o token Bearer enquanto ele permanecer válido, evitando solicitações desnecessárias de novo token. | `REG-MEC-API-0001-015` | `DE` | Proposto |
| `RF-MEC-API-0001-003` | O componente de integração deve renovar automaticamente o token Bearer conforme a regra oficial de expiração e renovação vigente. | `REG-MEC-API-0001-013`; `REG-MEC-API-0001-014` | `DE / PC` | Proposto |
| `RF-MEC-API-0001-004` | O cliente HTTP deve incluir o token no cabeçalho `Authorization` usando o formato `Bearer {token}` em todas as requisições protegidas. | `REG-MEC-API-0001-016` | `DE` | Proposto |
| `RF-MEC-API-0001-005` | A integração deve permitir configuração separada dos ambientes de homologação e produção, incluindo URLs e credenciais próprias. | `REG-MEC-API-0001-002`; `REG-MEC-API-0001-010` | `DE` | Proposto |
| `RF-MEC-API-0001-006` | O mapeador de saída da API deve serializar os nomes dos atributos conforme a convenção `snake_case`. | `REG-MEC-API-0001-017` | `DE` | Proposto |
| `RF-MEC-API-0001-007` | Quando houver geração ou consumo de planilhas do Sistema Gestão Presente, a integração deve tratar os cabeçalhos conforme a convenção em caixa alta. | `REG-MEC-API-0001-018` | `DE` | Proposto |
| `RF-MEC-API-0001-008` | Antes do envio, o sistema deve validar a presença dos campos obrigatórios definidos pelo contrato oficial da operação. | `REG-MEC-API-0001-019`; `REG-MEC-API-0001-020` | `DE` | Proposto |
| `RF-MEC-API-0001-009` | Antes do envio, o sistema deve validar os tipos de dados de acordo com o esquema oficial do payload. | `REG-MEC-API-0001-019`; `REG-MEC-API-0001-020` | `DE` | Proposto |
| `RF-MEC-API-0001-010` | Antes do envio, o sistema deve detectar atributos não reconhecidos pelo contrato oficial da operação. | `REG-MEC-API-0001-019`; `REG-MEC-API-0001-020` | `DE` | Proposto |
| `RF-MEC-API-0001-011` | O cliente deve reconhecer respostas HTTP `422`, extrair seus detalhes de diagnóstico e associá-los aos campos ou regras que impediram o processamento. | `REG-MEC-API-0001-021` | `DE` | Proposto |
| `RF-MEC-API-0001-012` | O componente de integração deve listar os lotes enviados por meio da rota `/api/v2/lotes`. | `REG-MEC-API-0001-022` | `DE` | Proposto |
| `RF-MEC-API-0001-013` | O componente de integração deve consultar o status de um lote por meio da rota `/api/v2/lotes/{lote_id}`. | `REG-MEC-API-0001-023` | `DE` | Proposto |
| `RF-MEC-API-0001-014` | O componente de integração deve consultar os erros de processamento de um lote por meio da rota `/api/v2/lotes/{lote_id}/erros`. | `REG-MEC-API-0001-024` | `DE` | Proposto |
| `RF-MEC-API-0001-015` | O sistema deve persistir o `lote_id` retornado ou identificado pela API e correlacioná-lo à operação local que originou o envio. | `REG-MEC-API-0001-023`; `REG-MEC-API-0001-024` | `DE` | Proposto |
| `RF-MEC-API-0001-016` | O sistema deve registrar o resultado do processamento de cada lote, incluindo status, erros retornados e vínculo com a operação executada. | `REG-MEC-API-0001-023`; `REG-MEC-API-0001-024`; `REG-MEC-API-0001-029` | `DE` | Proposto |
| `RF-MEC-API-0001-017` | A integração deve permitir listar instituições de ensino conforme as rotas e parâmetros definidos no contrato oficial. | `REG-MEC-API-0001-025` | `DE` | Proposto |
| `RF-MEC-API-0001-018` | A integração deve permitir cadastrar instituições de ensino conforme o esquema oficial. | `REG-MEC-API-0001-025` | `DE` | Proposto |
| `RF-MEC-API-0001-019` | A integração deve permitir editar instituições de ensino conforme o esquema e as regras oficiais. | `REG-MEC-API-0001-025` | `DE` | Proposto |
| `RF-MEC-API-0001-020` | Durante a homologação, a integração deve permitir consultar ou filtrar instituições pelo código INEP conforme o parâmetro definido no contrato oficial. | `REG-MEC-API-0001-025`; fonte p. 6 | `DE / PC` | Proposto |
| `RF-MEC-API-0001-021` | A integração deve permitir listar profissionais da educação conforme as rotas e parâmetros definidos no contrato oficial. | `REG-MEC-API-0001-026` | `DE` | Proposto |
| `RF-MEC-API-0001-022` | A integração deve permitir cadastrar profissionais da educação conforme o esquema oficial. | `REG-MEC-API-0001-026` | `DE` | Proposto |
| `RF-MEC-API-0001-023` | A integração deve permitir editar os dados de profissionais da educação conforme o esquema e as regras oficiais. | `REG-MEC-API-0001-026` | `DE` | Proposto |
| `RF-MEC-API-0001-024` | A integração deve permitir adicionar, editar, inativar, reativar e remover vínculos de profissionais conforme o contrato oficial. | `REG-MEC-API-0001-026`; fonte p. 6 | `DE / PC` | Proposto |
| `RF-MEC-API-0001-025` | A integração deve permitir adicionar e editar funções associadas aos profissionais conforme o contrato oficial. | `REG-MEC-API-0001-026`; fonte p. 6 | `DE / PC` | Proposto |
| `RF-MEC-API-0001-026` | A integração deve permitir adicionar, editar e remover formações de profissionais conforme o contrato oficial. | `REG-MEC-API-0001-026`; fonte p. 6 | `DE / PC` | Proposto |
| `RF-MEC-API-0001-027` | Durante a homologação, a integração deve permitir consultar ou filtrar profissionais pelo CPF conforme o parâmetro e o formato definidos no contrato oficial. | `REG-MEC-API-0001-026`; fonte p. 6 | `DE / PC` | Proposto |
| `RF-MEC-API-0001-028` | O processo de homologação deve permitir registrar observações, respostas inesperadas e divergências entre a documentação oficial e o comportamento observado. | `REG-MEC-API-0001-028` | `DE` | Proposto |
| `RF-MEC-API-0001-029` | Quando ocorrer erro, o sistema de evidências deve registrar o código retornado, o payload enviado, a mensagem recebida e a operação executada. | `REG-MEC-API-0001-029` | `DE` | Proposto |
| `RF-MEC-API-0001-030` | O processo de homologação deve permitir testar e registrar o comportamento de filtros, ordenação e paginação conforme os parâmetros oficiais. | `REG-MEC-API-0001-027` | `DE / PC` | Proposto |

## Agrupamento funcional

| Grupo | Requisitos |
|---|---|
| Autenticação e ambientes | `RF-MEC-API-0001-001` a `RF-MEC-API-0001-005` |
| Mapeamento e validação | `RF-MEC-API-0001-006` a `RF-MEC-API-0001-011` |
| Lotes e processamento assíncrono | `RF-MEC-API-0001-012` a `RF-MEC-API-0001-016` |
| Instituições de ensino | `RF-MEC-API-0001-017` a `RF-MEC-API-0001-020` |
| Profissionais da educação | `RF-MEC-API-0001-021` a `RF-MEC-API-0001-027` |
| Homologação e evidências | `RF-MEC-API-0001-028` a `RF-MEC-API-0001-030` |

## Dependências de validação

Antes da promoção, devem ser confirmados:

- endpoint, método, payload e resposta da autenticação;
- mecanismo exato de renovação e expiração do token;
- esquemas de instituições e profissionais;
- contratos de vínculos, funções e formações;
- formato e regras de consulta por código INEP e CPF;
- parâmetros de filtros, ordenação e paginação;
- estados e transições oficiais dos lotes;
- comportamento real das respostas HTTP `422`.

## Regra de promoção

A promoção para `03-conhecimento-consolidado/requisitos/` exige rastreabilidade entre:

```text
fonte → regra → requisito → componente → teste → evidência
```

Requisitos não confirmados devem permanecer neste dossiê com estado `Proposto` e, quando aplicável, classificação `DE / PC`.
