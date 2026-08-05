# 00 — Ficha técnica

## Controle

| Campo | Valor |
|---|---|
| Dossiê | `MEC-API-0001` |
| Estado | Ficha técnica concluída |
| Classificação predominante | `FD` — fonte direta |
| Última revisão | 2026-08-05 |

## Identificação da fonte

| Campo | Valor |
|---|---|
| Identificador | `MEC-API-0001` |
| Título original | Cartilha de Uso da API – Sistema Gestão Presente [nova versão] |
| Órgão emissor | Ministério da Educação — MEC |
| Sistema | Sistema Gestão Presente |
| Natureza | Cartilha técnica oficial de orientação |
| Versão informada | “nova versão”; sem número de versão declarado |
| Data de publicação | Não informada no documento |
| Ano de publicação | Não informado no documento |
| Idioma | Português |
| Formato | PDF |
| Extensão | 9 páginas no arquivo PDF |

## Localização e integridade

| Campo | Valor |
|---|---|
| Caminho canônico | `01-fontes/mec/gestao-presente/api/MEC-API-0001/MEC-API-0001-cartilha-uso-api-gestao-presente.pdf` |
| Dossiê | `02-dossies/MEC-API-0001/` |
| SHA-256 | `1e50fc17887352c3eea930d4e72f16679fd080fdc5075cb73980e6a0db2c02ef` |
| Política de preservação | A fonte original não deve ser editada |

## Finalidade declarada

A cartilha orienta o uso da nova versão da API do Sistema Gestão Presente e propõe que as equipes técnicas:

- testem o funcionamento das rotas;
- validem os novos recursos;
- verifiquem a consistência das respostas;
- avaliem a documentação técnica;
- identifiquem oportunidades de melhoria.

**Classificação:** `FD`

**Referência:** Fonte `MEC-API-0001`, p. 3.

## Escopo declarado

A fonte abrange os ambientes de homologação e produção e apresenta, em caráter introdutório:

- autenticação baseada em token Bearer;
- adoção de `snake_case`;
- pré-validação de payloads;
- rotas genéricas de consulta de lotes;
- módulos inicialmente disponíveis para homologação;
- boas práticas de teste e registro de erros;
- canais oficiais de suporte.

A cartilha informa que a nova versão implementa o Conjunto Mínimo de Dados da Educação Básica — CMDEB, instituído pela Portaria MEC nº 832/2025.

**Classificação:** `FD`

**Referências:** Fonte `MEC-API-0001`, pp. 2–7.

## Ambientes e documentação técnica citados

| Recurso | Homologação | Produção |
|---|---|---|
| Swagger UI | `https://api-cmde2.hmg.gestaopresente.mec.gov.br/docs` | `https://api-cmde2.gestaopresente.mec.gov.br/docs` |
| Redoc | `https://api-cmde2.hmg.gestaopresente.mec.gov.br/redoc` | `https://api-cmde2.gestaopresente.mec.gov.br/redoc` |

**Classificação:** `FD`

**Referência:** Fonte `MEC-API-0001`, p. 3.

## Canais oficiais citados

| Assunto | Canal |
|---|---|
| Integração por API e envio do ofício com a chave PGP | `cgge-seb@mec.gov.br` |
| Informações institucionais | `www.gov.br/mec/pt-br/mec-gestao-presente` |
| Dúvidas sobre envio de dados | Fale Conosco em `https://gestaopresente.mec.gov.br` |

**Classificação:** `FD`

**Referência:** Fonte `MEC-API-0001`, p. 8.

## Autoridade e função documental

O documento possui função de **orientação oficial introdutória**. Ele contextualiza a nova versão e direciona as equipes para a documentação técnica online.

A cartilha não deve ser tratada, isoladamente, como contrato técnico completo da API. Esquemas, parâmetros, payloads, respostas e rotas devem ser confirmados no Swagger, no Redoc e no contrato OpenAPI oficial aplicável.

**Classificação:** `DE` — derivação de engenharia fundamentada no escopo da cartilha.

## Limitações verificadas

1. O documento não informa data ou ano de publicação.
2. O documento não apresenta número formal de versão.
3. A rota utilizada para gerar o token não é identificada na cartilha.
4. A validade do token é descrita como “validade atual: 5 minutos”, exigindo confirmação antes de decisões de produção.
5. A cartilha apresenta somente uma visão resumida das rotas, dos módulos e dos comportamentos da API.
6. Os módulos explicitamente descritos como disponíveis para homologação são:
   - instituições de ensino;
   - profissionais de educação.
7. Os dados enviados ao ambiente de homologação são posteriormente descartados, e a fonte não recomenda o envio de dados reais.

Os itens 1, 2, 3, 6 e 7 são observações `FD`. Os itens 4 e 5 geram cautelas de engenharia `DE` e pontos de confirmação `PC`.

## Critério de uso no dossiê

Esta fonte deve ser utilizada para:

- registrar orientações oficiais de alto nível;
- identificar regras e restrições explicitamente declaradas;
- orientar a preparação dos testes de homologação;
- abrir pontos de confirmação contra a documentação técnica vigente;
- derivar requisitos somente quando a derivação estiver identificada como `DE`.

Ela não autoriza apresentar inferências, propostas do SIGESC ou comportamento observado como determinação oficial do MEC.
