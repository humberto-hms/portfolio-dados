# 📊 Projeto 1 — Dashboard de Performance Comercial

## Contexto do Negócio

Uma empresa do setor de dispositivos médicos e odontológicos precisa monitorar o desempenho de sua equipe comercial em tempo real. O time de liderança precisa responder rapidamente a perguntas como:

- Quem está batendo a meta e quem está ficando para trás?
- Qual região e segmento está puxando o resultado?
- Como está a margem por produto?
- O que o forecast aponta para os próximos meses?

## Objetivo do Projeto

Construir um dashboard no Power BI que centralize os principais KPIs comerciais e permita ao gestor tomar decisões rápidas e embasadas.

## Dataset

**Arquivo:** `vendas.csv`  
**Volume:** 600 registros | Jan–Dez 2024  
**Colunas:**

| Coluna | Descrição |
|--------|-----------|
| data | Data da venda |
| ano / mes / mes_nome | Dimensões de tempo |
| vendedor | Nome do vendedor |
| regiao | Cambuci, Paraíso ou Tamboré |
| segmento | Odontologia, Saúde ou Dispositivos Médicos |
| produto | Produto vendido |
| quantidade | Unidades vendidas |
| preco_unitario | Preço praticado |
| faturamento | Receita total do pedido |
| margem_pct | Margem percentual |
| margem_valor | Margem em R$ |
| meta_mensal_vendedor | Meta mensal individual |

## Análises SQL

Arquivo: `analise_performance.sql`

1. Faturamento e margem por mês
2. Meta vs. realizado por vendedor
3. Ranking de produtos por faturamento e margem
4. Performance por região e segmento
5. Forecast com média móvel de 3 meses
6. Top 3 vendedores do ano

## Como Montar o Dashboard no Power BI

### Passo 1 — Importar o dataset
- Abra o Power BI Desktop
- Clique em **Obter Dados → Texto/CSV**
- Selecione o arquivo `vendas.csv`
- Clique em **Transformar Dados** e verifique os tipos de cada coluna

### Passo 2 — Criar as medidas DAX principais

```dax
// Faturamento Total
Faturamento Total = SUM(vendas[faturamento])

// Margem Total
Margem Total = SUM(vendas[margem_valor])

// Margem %
Margem % = DIVIDE([Margem Total], [Faturamento Total])

// Meta Total
Meta Total = SUM(vendas[meta_mensal_vendedor])

// Atingimento de Meta
Atingimento % = DIVIDE([Faturamento Total], [Meta Total])

// Faturamento Mês Anterior
Fat. Mês Anterior = 
    CALCULATE([Faturamento Total], PREVIOUSMONTH(vendas[data]))

// Crescimento MoM
Crescimento MoM = 
    DIVIDE([Faturamento Total] - [Fat. Mês Anterior], [Fat. Mês Anterior])
```

### Passo 3 — Estrutura de páginas sugerida

**Página 1 — Visão Executiva**
- Cards: Faturamento Total | Margem % | Atingimento de Meta | Crescimento MoM
- Gráfico de linhas: Faturamento por mês vs. Meta
- Gráfico de barras: Faturamento por Região

**Página 2 — Performance de Vendedores**
- Tabela: Vendedor | Realizado | Meta | Atingimento % | Status
- Gráfico de barras horizontal: Ranking de vendedores
- Segmentação por mês

**Página 3 — Análise de Produtos**
- Gráfico de barras: Top produtos por faturamento
- Scatter plot: Faturamento vs. Margem por produto
- Segmentação por Segmento

**Página 4 — Forecast**
- Gráfico de linhas com linha de tendência
- Tabela: Mês | Realizado | Média Móvel 3M | Variação

### Passo 4 — Filtros globais recomendados
- Ano
- Mês
- Vendedor
- Região
- Segmento

## Insights Esperados

- Identificar vendedores abaixo da meta para ação corretiva
- Entender quais produtos têm melhor relação faturamento/margem
- Monitorar regiões com queda ou crescimento de receita
- Antecipar tendências com o forecast de média móvel

---
*Projeto desenvolvido por Humberto Mendes | [linkedin.com/in/humberto-hms](https://linkedin.com/in/humberto-hms)*
