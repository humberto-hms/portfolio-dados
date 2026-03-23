# 📊 Dashboard de Performance Comercial

![Status](https://img.shields.io/badge/status-concluído-brightgreen)
![Power BI](https://img.shields.io/badge/Power%20BI-dashboard-yellow)
![Star Schema](https://img.shields.io/badge/modelo-star%20schema-blueviolet)
![CSV](https://img.shields.io/badge/dados-600%20registros-orange)

> Dashboard executivo no Power BI com modelagem Star Schema para análise de vendas, KPIs e forecast de uma empresa do setor de dispositivos médicos e odontológicos.

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

Construir um dashboard no Power BI com modelagem Star Schema que centralize os principais KPIs comerciais e permita ao gestor tomar decisões rápidas e embasadas.

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
└── 📄 analise_performance.sql        ← queries de análise exploratória
```

---

## 🗃️ Dataset

**Arquivo:** `vendas.csv` | **Volume:** 600 registros | **Período:** Jan–Dez 2024

| Coluna | Descrição |
|--------|-----------|
| data | Data da venda |
| vendedor | Nome do vendedor |
| regiao | Cambuci, Paraíso ou Tamboré |
| segmento | Odontologia, Saúde ou Dispositivos Médicos |
| produto | Produto vendido |
| quantidade | Unidades vendidas |
| faturamento | Receita total do pedido |
| margem_pct / margem_valor | Margem percentual e em R$ |
| meta_mensal_vendedor | Meta mensal individual |

---

## 🗂️ Modelagem — Star Schema

O modelo foi construído direto no Power Query, sem necessidade de banco de dados externo.

```
fVendas (tabela fato)
├── id_data       → dCalendario
├── id_vendedor   → dVendedor
├── id_produto    → dProduto
└── id_regiao     → dRegiao
```

| Tabela | Tipo | Conteúdo |
|--------|------|----------|
| fVendas | Fato | Métricas: faturamento, margem, quantidade |
| dCalendario | Dimensão | data, ano, mês, nome do mês |
| dVendedor | Dimensão | vendedor, meta mensal |
| dProduto | Dimensão | produto, segmento |
| dRegiao | Dimensão | região |

---

## ⚙️ Como Reproduzir

1. Abra o **Power BI Desktop**
2. **Obter Dados → Texto/CSV** → selecione `vendas.csv`
3. Clique em **Transformar Dados** para abrir o Power Query
4. Crie as tabelas dimensão via **duplicar consulta → agrupar/remover colunas**
5. Renomeie a consulta original como `fVendas` mantendo apenas métricas e chaves
6. Feche e aplique → crie os relacionamentos na **Vista de Modelo**
7. Adicione as medidas DAX abaixo e monte as páginas

---

## 📐 Medidas DAX

```dax
Faturamento Total = SUM(fVendas[faturamento])

Margem Total = SUM(fVendas[margem_valor])

Margem % = DIVIDE([Margem Total], [Faturamento Total])

Atingimento % = DIVIDE([Faturamento Total], SUM(fVendas[meta_mensal_vendedor]))

Fat. Mês Anterior =
    CALCULATE([Faturamento Total], PREVIOUSMONTH(dCalendario[data]))

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

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![Power Query](https://img.shields.io/badge/Power%20Query-ETL-green)
![DAX](https://img.shields.io/badge/DAX-medidas-blueviolet)
![CSV](https://img.shields.io/badge/CSV-dataset-lightgrey)

---

*Desenvolvido por **Humberto Mendes dos Santos** · [linkedin.com/in/humberto-hms](https://linkedin.com/in/humberto-hms)*
