# Padrão de Citações e Fontes

## Identificação

- Código: `SKF-STD-FONTE-001`
- Versão: `1.0.0`
- Estado: proposto para a Foundation v1.0

## Princípio

Toda afirmação relevante deve permitir a identificação de sua origem ou de sua natureza derivada.

## Citação de documento paginado

Formato preferencial:

```text
Fonte: MEC-API-0001, p. 4.
```

Para intervalo:

```text
Fonte: MEC-API-0001, pp. 4–6.
```

## Citação por seção

Quando não houver paginação confiável:

```text
Fonte: MEC-API-0001, seção “Autenticação”.
```

## Citação de contrato técnico

Indicar versão e elemento:

```text
Fonte: MEC-CMDE-OPENAPI-0001, versão 2.1, endpoint POST /api/v2/lotes.
```

## Fontes externas referenciadas por link

Registrar, conforme aplicável:

- título;
- emissor;
- URL;
- data de acesso;
- versão ou data de atualização;
- checksum ou cópia preservada quando necessário.

## Classificação das derivações

Quando o conteúdo não for mera transcrição, utilizar:

- `FD` — fonte direta;
- `DE` — derivação de engenharia;
- `PA` — proposta arquitetural;
- `PC` — ponto a confirmar.

Exemplo:

```text
Classificação: DE
Base: MEC-API-0001, p. 4.
```

## Regras de fidelidade

- preservar a terminologia da fonte;
- não corrigir silenciosamente ambiguidades;
- não atribuir ao emissor decisões internas do SIGESC;
- não transformar recomendação em obrigação;
- não preencher informação ausente por estimativa;
- distinguir comportamento observado de comportamento documentado.

## Referências não portáveis

Marcações específicas de ferramentas de conversa, como `filecite`, IDs temporários ou links locais de sessão, não devem ser publicadas no repositório.

Devem ser substituídas por referências estáveis ao identificador da fonte, página, seção ou evidência.
