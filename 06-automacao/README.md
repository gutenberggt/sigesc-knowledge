# Automação

Scripts, validadores e templates usados para manter o SIGESC Knowledge Framework (SKF).

## Estrutura

```text
06-automacao/
├── README.md
├── scripts/
│   ├── validate-catalog.ps1
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

## Validador de catálogo

### Arquivo

```text
06-automacao/scripts/validate-catalog.ps1
```

### Objetivo

Verificar se o catálogo mestre `catalogo.csv` respeita o contrato canônico de
metadados, mantém coerência com as fontes e os dossiês do repositório e preserva
a integridade das fontes locais por SHA-256.

### Compatibilidade

- Windows PowerShell 5.1;
- execução a partir de uma cópia local do repositório;
- nenhuma dependência externa além de Git e PowerShell;
- operação somente leitura.

### Contrato do catálogo

O catálogo usa vírgula como delimitador e possui, nesta ordem, as colunas:

```text
id,titulo,orgao,dominio,tipo_fonte,caminho_fonte,caminho_dossie,ano,versao,status,nivel_autoridade,checksum_sha256,observacoes
```

Campos obrigatórios:

- `id`;
- `titulo`;
- `orgao`;
- `dominio`;
- `tipo_fonte`;
- `caminho_fonte`;
- `status`;
- `nivel_autoridade`.

Campos condicionais ou opcionais:

- `caminho_dossie`: opcional; quando informado, deve apontar para
  `02-dossies/<ID>` e o diretório deve existir;
- `ano`: opcional; quando informado, deve conter quatro dígitos;
- `versao`: opcional; quando informada, deve usar token técnico portável;
- `checksum_sha256`: obrigatório para fonte armazenada no repositório e
  opcional para referência HTTP ou HTTPS;
- `observacoes`: opcional.

O contrato inicial não impõe listas fechadas para `tipo_fonte`, `status` e
`nivel_autoridade`. Esses campos devem usar tokens técnicos portáveis em letras
minúsculas, números e hífens.

### Verificações

O validador verifica:

- presença do arquivo de catálogo;
- codificação UTF-8;
- ausência de BOM;
- finais de linha LF;
- cabeçalho exato e ordem das 13 colunas;
- leitura válida do CSV;
- existência de pelo menos um registro;
- preenchimento dos campos obrigatórios;
- ausência de espaços no início ou no fim dos valores;
- formato canônico dos identificadores;
- formato portável de domínio, versão e tokens técnicos;
- uso de barras `/` nos caminhos registrados;
- proteção contra travessia de diretórios;
- resolução dos caminhos dentro da raiz do repositório;
- existência das fontes locais;
- existência dos dossiês informados;
- correspondência entre o identificador, a pasta da fonte, o nome do arquivo e
  o diretório do dossiê;
- formato canônico do SHA-256 em letras minúsculas;
- correspondência entre o checksum registrado e o arquivo local;
- duplicidade de identificadores e caminhos de fontes;
- aviso para checksums repetidos;
- cobertura das pastas permanentes de fontes pelo catálogo mestre.

Quando o cabeçalho não é canônico, as verificações dependentes das colunas são
ignoradas para evitar diagnósticos secundários incorretos.

### Execução

Na raiz do repositório:

```powershell
powershell.exe `
    -NoProfile `
    -ExecutionPolicy Bypass `
    -File "06-automacao\scripts\validate-catalog.ps1" `
    -Root (Get-Location).Path
```

Para validar outro arquivo sem substituir o catálogo mestre:

```powershell
powershell.exe `
    -NoProfile `
    -ExecutionPolicy Bypass `
    -File "06-automacao\scripts\validate-catalog.ps1" `
    -Root (Get-Location).Path `
    -CatalogPath "98-entrada\catalogo-em-revisao.csv"
```

### Códigos de saída

| Código | Significado |
|---:|---|
| `0` | catálogo válido, sem falhas |
| `1` | uma ou mais violações do contrato |
| `2` | erro de execução do validador |

Avisos não alteram o código de sucesso quando não existem falhas.

### Garantias operacionais

- o script não cria, altera, move ou remove conteúdo do repositório;
- o catálogo mestre não é modificado durante a validação;
- cada diagnóstico informa nível, código e descrição;
- o resumo final informa total de verificações, erros, avisos e resultado;
- o arquivo segue a política de final de linha `CRLF` para scripts PowerShell.
