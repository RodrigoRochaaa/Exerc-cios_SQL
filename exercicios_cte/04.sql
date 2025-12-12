--Clientes mais antigos, tem mais frequência de transação?
WITH cohort AS (
    SELECT
        IdCliente,
        MIN(substr(DtCriacao,1,10)) AS primeira_compra
    FROM transacoes
    GROUP BY IdCliente
),

-- 2) Classificar clientes como antigos ou novos
classificados AS (
    SELECT
        IdCliente,
        CASE
            WHEN primeira_compra < '2025-06-01' THEN 'ANTIGO'
            ELSE 'NOVO'
        END AS tipo_cliente
    FROM cohort
),

-- 3) Filtrar transações somente dos últimos 3 meses do dataset
ultimos_3_meses AS (
    SELECT *
    FROM transacoes
    WHERE substr(DtCriacao,1,10) >= '2025-07-15' 
      AND substr(DtCriacao,1,10) <= '2025-10-15'
)

-- 4) Contar transações por grupo
SELECT 
    t2.tipo_cliente,
    COUNT(t1.IdTransacao) AS total_transacoes_3_meses
FROM ultimos_3_meses as t1
LEFT JOIN classificados as t2
    ON t1.IdCliente = t2.IdCliente
GROUP BY t2.tipo_cliente;




   
    