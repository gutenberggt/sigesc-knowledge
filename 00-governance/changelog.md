# Changelog do SKF

Todas as mudanças relevantes da governança e da estrutura do SIGESC Knowledge Framework serão registradas neste arquivo.

## [1.1.0] — 2026-08-05

### Adicionado

- primeiro dossiê analítico completo do SKF para a fonte `MEC-API-0001`;
- artefatos `00-ficha-tecnica.md` a `15-notas.md`;
- catálogo de 451 identificadores distribuídos em 27 namespaces;
- matrizes de requisitos, casos de uso, fluxos, dados, permissões, integrações, impactos, oportunidades e rastreabilidade;
- 20 pontos canônicos de confirmação, 20 GAPs e 24 oportunidades de melhoria.

### Alterado

- `02-dossies/MEC-API-0001/README.md` consolidado como visão geral do dossiê;
- `knowledge-index.md` atualizado para refletir a conclusão do dossiê;
- roadmap do Ciclo 1 marcado como concluído.

### Corrigido

- colisão de identificadores `PC-MEC-API-0001`;
- estados editoriais remanescentes dos artefatos;
- validação de estrutura, UTF-8, links locais, sequências e duplicidades.

### Validação

- auditoria final: `PASS`;
- checksum da fonte: válido;
- arquivos do dossiê: 17;
- links locais verificados: 17;
- identificadores duplicados: 0;
- evidências operacionais: 0;
- produção: bloqueada.

### Integração

- PR #3 mesclada na `main`;
- merge commit: `43a56db092a88b7e0cfb04785781b893b7fd365a`.

## [1.0.0] — 2026-08-05

### Adicionado

- documento fundador `SKF-0000`;
- estrutura canônica do repositório;
- separação entre fontes, dossiês, conhecimento consolidado, rastreabilidade e evidências;
- catálogo mestre `catalogo.csv`;
- padrão de estrutura;
- padrão de nomenclatura;
- padrão de identificadores;
- padrão de citações e fontes;
- normalização UTF-8 e finais de linha;
- catalogação da fonte `MEC-API-0001`.

### Migrado

- `01-mec` para `01-fontes/mec`;
- `inventario.csv` para inventário histórico datado;
- cartilha do Sistema Gestão Presente para caminho identificado e portável.

### Removido

- placeholders antigos e vazios substituídos pelos padrões formais.
