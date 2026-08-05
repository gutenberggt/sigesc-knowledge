# 02 — Estrutura do documento

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Fonte | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Estado | Estrutura mapeada |
| Última revisão | 2026-08-05 |

## Paginação

O arquivo possui **9 páginas físicas em PDF**. A capa não apresenta número editorial; a numeração impressa começa no sumário e vai de 1 a 8.

Para evitar ambiguidade, este dossiê usa:

- **página PDF**: posição física no arquivo;
- **página editorial**: número impresso no rodapé da cartilha.

**Classificação:** `FD`.

## Mapa das páginas

| Página PDF | Página editorial | Conteúdo principal | Finalidade |
|---:|---:|---|---|
| 1 | — | Capa | Identificar a cartilha e a nova versão da API do Sistema Gestão Presente. |
| 2 | 1 | Sumário | Apresentar as 12 seções e suas páginas editoriais. |
| 3 | 2 | `1. Apresentação` | Contextualizar a nova versão, o CMDEB, as melhorias estruturais e o ambiente de homologação. |
| 4 | 3 | `2. Objetivo desta Cartilha`; `3. Documentação Oficial da API` | Definir os objetivos dos testes e indicar Swagger UI e Redocly para homologação e produção. |
| 5 | 4 | `4. Novo Mecanismo de Autenticação`; `5. Padronização de Nomenclatura` | Descrever token Bearer, renovação e reutilização; apresentar `snake_case` e cabeçalhos de planilhas em caixa alta. |
| 6 | 5 | `6. Pré-Validação de Dados`; `7. Rotas Genéricas para Consulta de Lotes` | Explicar validação prévia, HTTP `422` e as três rotas genéricas de consulta de lotes. |
| 7 | 6 | `8. Módulos Disponíveis para Homologação`; `8.1 Instituições de Ensino`; `8.2 Profissionais de Educação` | Listar operações e exemplos de testes para instituições e profissionais. |
| 8 | 7 | `9. Boas Práticas Durante os Testes`; `10. Em Caso de Dificuldades`; `11. Em Caso de Erros`; `12. Considerações Finais` | Orientar homologação, diagnóstico, registro de erros, suporte e feedback técnico. |
| 9 | 8 | Canais oficiais de contato | Informar os canais para integração por API, chave PGP, informações institucionais e dúvidas sobre envio de dados. |

**Classificação:** `FD`.

**Referência:** Fonte `MEC-API-0001`, páginas PDF 1–9.

## Mapa das seções

| Seção | Página editorial | Página PDF | Conteúdo |
|---|---:|---:|---|
| Sumário | 1 | 2 | Relação das seções da cartilha. |
| `1. Apresentação` | 2 | 3 | Nova versão, CMDEB, principais evoluções e homologação. |
| `2. Objetivo desta Cartilha` | 3 | 4 | Objetivos de teste, validação, avaliação e identificação de melhorias. |
| `3. Documentação Oficial da API` | 3 | 4 | Conteúdo da documentação e endereços de Swagger UI e Redocly. |
| `4. Novo Mecanismo de Autenticação` | 4 | 5 | Token Bearer, validade atual, renovação, reutilização e cabeçalho. |
| `5. Padronização de Nomenclatura` | 4 | 5 | Transição de `camelCase` para `snake_case` e convenção das planilhas. |
| `6. Pré-Validação de Dados` | 5 | 6 | Campos obrigatórios, tipos, atributos inválidos e resposta HTTP `422`. |
| `7. Rotas Genéricas para Consulta de Lotes` | 5 | 6 | Listagem, consulta de status e consulta de erros de lotes. |
| `8. Módulos Disponíveis para Homologação` | 6 | 7 | Introdução aos módulos liberados para testes. |
| `8.1 Instituições de Ensino` | 6 | 7 | Listagem, cadastro, edição e testes por código INEP e lotes. |
| `8.2 Profissionais de Educação` | 6 | 7 | Cadastro, edição, vínculos, funções, formações e testes por CPF. |
| `9. Boas Práticas Durante os Testes` | 7 | 8 | Registro de observações, divergências, filtros, ordenação e paginação. |
| `10. Em Caso de Dificuldades` | 7 | 8 | Consulta à documentação, parâmetros, credenciais e Fale Conosco. |
| `11. Em Caso de Erros` | 7 | 8 | Registro de código, payload, mensagem e operação. |
| `12. Considerações Finais` | 7 | 8 | Importância da homologação e do feedback das equipes técnicas. |
| Canais oficiais | 8 | 9 | E-mail de integração e PGP, site institucional e Fale Conosco. |

**Classificação:** `FD`.

**Referência:** Fonte `MEC-API-0001`, sumário e páginas editoriais 2–8.

## Organização temática

A sequência documental pode ser agrupada em quatro blocos:

1. **Contexto e finalidade** — apresentação e objetivos;
2. **Contrato introdutório de integração** — documentação, autenticação, nomenclatura, validação e lotes;
3. **Escopo inicial de homologação** — instituições de ensino e profissionais de educação;
4. **Operação assistida** — boas práticas, diagnóstico, erros, considerações finais e canais oficiais.

Esse agrupamento não aparece como divisão formal na cartilha; ele foi criado para facilitar a análise do dossiê.

**Classificação:** `DE`.

## Relação com os demais artefatos

| Conteúdo desta estrutura | Artefato de aprofundamento |
|---|---|
| Termos e conceitos | `03-glossario.md` |
| Determinações e limitações | `04-regras-e-restricoes.md` |
| Capacidades esperadas | `05-requisitos-funcionais.md` |
| Segurança, interoperabilidade e operação | `06-requisitos-nao-funcionais.md` |
| Ações de homologação | `07-casos-de-uso.md` |
| Autenticação, envio e acompanhamento | `08-fluxos-operacionais.md` |
| Payloads, lotes e entidades | `09-modelo-de-dados.md` |
| Atores e acessos | `10-perfis-e-permissoes.md` |
| Swagger, Redocly, API e suporte | `11-integracoes.md` |
| GAPs e efeitos arquiteturais | `12-impacto-no-sigesc.md` |

**Classificação:** `DE`.

## Limite deste mapa

Este arquivo registra a organização e a localização do conteúdo. Ele não substitui o contrato OpenAPI, não completa esquemas ausentes e não transforma exemplos de teste em autorização de produção.
