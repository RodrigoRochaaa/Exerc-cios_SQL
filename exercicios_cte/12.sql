--Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL

WITH Tb_clientes_janeiro AS(
        SELECT 
        DISTINCT idCliente,
        substr(DtCriacao,1,10) as datas

FROM transacoes

WHERE substr(DtCriacao,1,10) >= '2025-01-01'
AND   substr(DtCriacao,1,10) <= '2025-01-31'
),
    Tb_curso_sql AS(
        SELECT 
        DISTINCT idCliente,
        substr(DtCriacao,1,10) as datas
    FROM transacoes

    WHERE substr(DtCriacao, 1,10) >= '2025-08-25'
    AND substr(DtCriacao, 1,10) < '2025-08-30'               
)

SELECT  COUNT(DISTINCT t1.idCliente) as Clientes_janeiro,
        COUNT(DISTINCT t2.idCliente) as Clientes_janeiro_SQL

FROM Tb_clientes_janeiro as t1

LEFT JOIN Tb_curso_sql as t2
on t1.idCliente = t2.idCliente
