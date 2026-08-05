# Padrão de Identificadores

## Identificação

- Código: `SKF-STD-ID-001`
- Versão: `1.0.0`
- Estado: proposto para a Foundation v1.0

## Objetivo

Garantir referências permanentes e não ambíguas.

## Fontes

Formato recomendado:

```text
{EMISSOR}-{DOMINIO}-{NNNN}
```

Exemplos:

```text
MEC-API-0001
FNDE-PNAE-0001
MP-PA-0001
```

O número é sequencial dentro da combinação emissor e domínio.

## Governança

```text
SKF-0000
SKF-ADR-0001
SKF-STD-NOME-001
```

## Artefatos derivados

| Tipo | Prefixo |
|---|---|
| Regra ou restrição | `RN` |
| Requisito funcional | `RF` |
| Requisito não funcional | `RNF` |
| Caso de uso | `UC` |
| Fluxo | `FL` |
| Gap | `GAP` |
| Oportunidade | `OM` |
| Divergência | `DIV` |

Formato:

```text
{TIPO}-{ID-DA-FONTE}-{NNN}
```

Exemplos:

```text
RF-MEC-API-0001-001
RNF-MEC-API-0001-001
UC-MEC-API-0001-001
DIV-MEC-API-0001-001
```

## Regras

- identificadores não devem ser reutilizados;
- renomear título não altera identificador;
- exclusão lógica não libera o número;
- a fonte principal deve ser identificável no artefato derivado;
- artefatos transversais devem possuir identificador próprio e listar todas as fontes relacionadas;
- zeros à esquerda são obrigatórios conforme o formato.
