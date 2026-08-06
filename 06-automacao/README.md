# Automação

Scripts, validadores e templates usados para manter o SIGESC Knowledge Framework (SKF).

## Estrutura

```text
06-automacao/
├── README.md
├── scripts/
│   └── validate-structure.ps1
└── templates/
```

O diretório `templates/` é reservado para modelos reutilizáveis e somente será versionado quando receber conteúdo.

## Restrições

- não armazenar segredos;
- evitar caminhos absolutos;
- documentar dependências;
- oferecer modo de validação antes de alterações;
- preservar rastreabilidade das mudanças;
- manter os validadores em modo somente leitura;
- retornar códigos de saída adequados para uso local e em integração contínua.

## Validador de estrutura

### Arquivo

```text
06-automacao/scripts/validate-structure.ps1
```

### Objetivo

Verificar se o repositório respeita a estrutura canônica definida em
`00-governance/padroes/estrutura-repositorio.md` e as regras de portabilidade
definidas em `00-governance/padroes/nomenclatura.md`.

### Compatibilidade

- Windows PowerShell 5.1;
- execução a partir de uma cópia local do repositório;
- nenhuma dependência externa além de Git e PowerShell.

### Verificações

O validador verifica:

- presença dos arquivos obrigatórios da raiz;
- presença das camadas canônicas;
- entradas inesperadas no primeiro nível;
- existência de `README.md` nas camadas;
- nomenclatura canônica das pastas de dossiês;
- presença do `README.md` de cada dossiê;
- início, continuidade e duplicidade da sequência numérica dos artefatos;
- identificação case-sensitive das pastas permanentes de fontes;
- presença de arquivos nas pastas identificadas de fontes;
- caminhos rastreados com espaços;
- caminhos rastreados com caracteres não ASCII;
- uso de nomes genéricos proibidos em diretórios rastreados.

### Execução

Na raiz do repositório:

```powershell
powershell.exe `
    -NoProfile `
    -ExecutionPolicy Bypass `
    -File "06-automacao\scripts\validate-structure.ps1" `
    -Root (Get-Location).Path
```

Também é possível informar outro caminho absoluto por meio do parâmetro `-Root`.

### Códigos de saída

| Código | Significado |
|---:|---|
| `0` | estrutura válida, sem falhas |
| `1` | uma ou mais violações estruturais |
| `2` | erro de execução do validador |

Avisos não alteram o código de sucesso quando não existem falhas.

### Garantias operacionais

- o script não cria, altera, move ou remove conteúdo do repositório;
- a saída apresenta cada verificação com código e nível;
- o resumo final informa total de verificações, erros, avisos e resultado;
- o arquivo segue a política de final de linha `CRLF` para scripts PowerShell.
