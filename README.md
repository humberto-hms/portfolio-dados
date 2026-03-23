# 📊 Dashboard de Performance Comercial

![Status](https://img.shields.io/badge/status-concluído-brightgreen)
![SQL](https://img.shields.io/badge/SQL-análise-blue)
![Power BI](https://img.shields.io/badge/Power%20BI-dashboard-yellow)
![CSV](https://img.shields.io/badge/dados-600%20registros-orange)

> Análise comercial completa com SQL + dashboard executivo no Power BI para uma empresa do setor de dispositivos médicos e odontológicos.

---

## 📸 Preview do Dashboard

| Visão Executiva | Performance de Vendedores |
|---|---|
| ![Visão Executiva](images/visao_executiva.png) | ![Vendedores](images/performance_vendedores.png) |

| Análise de Produtos | Forecast |
|---|---|
| ![Produtos](images/analise_produtos.png) | ![Forecast](images/forecast.png) |

---

## 🧩 Contexto do Negócio

Uma empresa do setor de dispositivos médicos e odontológicos precisa monitorar o desempenho de sua equipe comercial. O time de liderança precisa responder rapidamente a perguntas como:

- Quem está batendo a meta e quem está ficando para trás?
- Qual região e segmento está puxando o resultado?
- Como está a margem por produto?
- O que o forecast aponta para os próximos meses?

---

## 🎯 Objetivo

Construir um pipeline de análise em SQL + dashboard no Power BI que centralize os principais KPIs comerciais e permita ao gestor tomar decisões rápidas e embasadas.

---

## 📁 Estrutura do Repositório

```
📁 dashboard-performance-comercial/
├── 📁 images/                        ← prints do dashboard
│   ├── visao_executiva.png
│   ├── performance_vendedores.png
│   ├── analise_produtos.png
│   └── forecast.png
├── 📄 README.md
├── 📄 vendas.csv                     ← dataset com 600 registros
├── 📄 create_table.sql               ← script de criação da tabela
└── 📄 analise_performance.sql        ← queries de análise
```

---

## 🗃️ Dataset

**Arquivo:** `vendas.csv` | **Volume:** 600 registros | **Período:** Jan–Dez 2024

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| data | DATE | Data da venda |
| ano / mes / mes_nome | INT / VARCHAR | Dimensões de tempo |
| vendedor | VARCHAR | Nome do vendedor |
| regiao | VARCHAR | Cambuci, Paraíso ou Tamboré |
| segmento | VARCHAR | Odontologia, Saúde ou Dispositivos Médicos |
| produto | VARCHAR | Produto vendido |
| quantidade | INT | Unidades vendidas |
| preco_unitario | NUMERIC | Preço praticado |
| faturamento | NUMERIC | Receita total do pedido |
| margem_pct | NUMERIC | Margem percentual |
| margem_valor | NUMERIC | Margem em R$ |
| meta_mensal_vendedor | NUMERIC | Meta mensal individual |

---

## 🔍 Análises SQL

Arquivo: `analise_performance.sql`

| # | Query | Descrição |
|---|-------|-----------|
| 1 | Visão Geral Mensal | Faturamento, margem e total de pedidos por mês |
| 2 | Meta vs. Realizado | Atingimento de meta por vendedor com status (Atingiu / Próximo / Abaixo) |
| 3 | Ranking de Produtos | Top produtos por faturamento e margem |
| 4 | Performance por Região | Faturamento e margem segmentados por região |
| 5 | Forecast (Média Móvel 3M) | Projeção com variação mês a mês |
| 6 | Top 3 Vendedores | Ranking anual dos melhores vendedores |

---

## ⚙️ Como Reproduzir

1. Abra o **Power BI Desktop**
2. **Obter Dados → Texto/CSV** → selecione `vendas.csv`
3. Clique em **Transformar Dados** e verifique os tipos de coluna
4. Importe as medidas DAX abaixo e monte as páginas

---

## 📐 Medidas DAX

```dax
Faturamento Total = SUM(vendas[faturamento])

Margem Total = SUM(vendas[margem_valor])

Margem % = DIVIDE([Margem Total], [Faturamento Total])

Atingimento % = DIVIDE([Faturamento Total], SUM(vendas[meta_mensal_vendedor]))

Fat. Mês Anterior = 
    CALCULATE([Faturamento Total], PREVIOUSMONTH(vendas[data]))

Crescimento MoM = 
    DIVIDE([Faturamento Total] - [Fat. Mês Anterior], [Fat. Mês Anterior])
```

---

## 💡 Principais Insights

- **Desfibrilador Portátil** e **Monitor Cardíaco** lideram o faturamento com as maiores margens absolutas
- Região **Cambuci** concentra o maior volume de vendas de Dispositivos Médicos
- Forecast de média móvel indica **tendência de crescimento** no segundo semestre
- Dois vendedores ficaram abaixo de 80% da meta em pelo menos 3 meses consecutivos

---

## 🛠️ Tecnologias

![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![CSV](https://img.shields.io/badge/CSV-dataset-lightgrey)

---

*Desenvolvido por **Humberto Mendes dos Santos** · [linkedin.com/in/humberto-hms](https://linkedin.com/in/humberto-hms)*
