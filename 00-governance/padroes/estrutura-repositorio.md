# Padrão de Estrutura do Repositório

## Identificação

- Código: `SKF-STD-ESTRUTURA-001`
- Versão: `1.0.0`
- Estado: proposto para a Foundation v1.0

## Objetivo

Definir as responsabilidades e os limites de cada diretório do SKF.

## Estrutura canônica

```text
SIGESC Knowledge/
├── README.md
├── knowledge-index.md
├── catalogo.csv
├── LICENSE
├── NOTICE.md
├── .gitignore
├── .gitattributes
├── 00-governance/
├── 01-fontes/
├── 02-dossies/
├── 03-conhecimento-consolidado/
├── 04-rastreabilidade/
├── 05-evidencias/
├── 06-automacao/
├── 98-entrada/
└── 99-arquivo/
```

## Regras por camada

### Fontes

- armazenar apenas originais preservados ou referências controladas;
- organizar por emissor, domínio e identificador;
- registrar checksum no catálogo quando o arquivo estiver no repositório;
- não armazenar análises junto ao original.

### Dossiês

- usar uma pasta por identificador principal;
- manter o `README.md` como porta de entrada;
- numerar artefatos internos quando houver sequência definida;
- permitir hipóteses e pontos pendentes, desde que identificados.

### Conhecimento consolidado

- receber apenas conteúdo revisado;
- evitar cópia integral dos dossiês;
- resolver duplicidades e conflitos;
- declarar validade e fontes.

### Rastreabilidade

- manter relações, não cópias de documentos;
- utilizar identificadores estáveis;
- apontar para componentes, testes e evidências por referência.

### Evidências

- preservar contexto, data, ambiente e resultado;
- não publicar dados sensíveis;
- separar evidência técnica de interpretação.

### Entrada

- uso temporário;
- nenhum arquivo deve permanecer sem responsável e destino;
- materiais rejeitados devem ser removidos ou arquivados justificadamente.

### Arquivo

- preservar histórico;
- registrar motivo de arquivamento;
- não utilizar conteúdo arquivado como referência vigente sem ressalva.

## Proibições

- criar pastas globais apenas por extensão, como `imagens` ou `videos`, quando o material pertence a uma fonte específica;
- duplicar a arquitetura oficial do SIGESC;
- guardar segredos ou dados pessoais;
- introduzir nova camada principal sem decisão de governança;
- usar diretórios genéricos como `diversos`, `temporario` ou `outros` sem justificativa e prazo de revisão.
