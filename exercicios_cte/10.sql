--Como foi a curva de Churn do Curso de SQL?

WITH Tb_primeiro_dia AS ( 
        SELECT substr(DtCriacao, 1,10) as dias_transacao,
                idCliente

        FROM transacoes

        WHERE substr(DtCriacao, 1,10) = '2025-08-25'
),
    tb_manteve AS(
    SELECT  substr(DtCriacao, 1,10) AS dias_transacao,
            idCliente
    
    FROM transacoes

    WHERE substr(DtCriacao, 1,10) >= '2025-08-25'
    AND substr(DtCriacao, 1,10) < '2025-08-30'
)
SELECT count(DISTINCT t1.idCliente) as total_dia,
        t2.dias_transacao,
        1.* count(DISTINCT t1.idCliente)/(select count(DISTINCT idCliente) from Tb_primeiro_dia) as taxa_churn


FROM Tb_primeiro_dia as t1

LEFT JOIN tb_manteve as t2
ON t1.idCliente = t2.idCliente

GROUP BY t2.dias_transacao







