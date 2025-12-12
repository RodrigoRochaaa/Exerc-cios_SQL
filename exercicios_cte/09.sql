--Dos clientes que começaram SQL no primeiro dia, quantos chegaram ao 5o dia?

WITH tb_prim_dia AS(
SELECT DISTINCT idCliente


FROM transacoes

WHERE substr(DtCriacao, 1,10) == '2025-08-25'
)

SELECT COUNT(DISTINCT t1.idCliente),
        substr(t1.DtCriacao, 1,10) as Dias_Curso

FROM transacoes as t1

INNER JOIN tb_prim_dia as t2
on t1.idCliente = t2.idCliente

WHERE substr(t1.DtCriacao, 1,10) >= '2025-08-25'
    AND substr(t1.DtCriacao, 1,10) < '2025-08-30'

GROUP BY substr(t1.DtCriacao, 1,10)
