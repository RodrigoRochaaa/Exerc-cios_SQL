--Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?

WITH tb_prim_dia AS(
            SELECT DISTINCT idCliente
            FROM transacoes
            WHERE substr(DtCriacao, 1,10) == '2025-08-25'
),
tb_dias_totais AS(
            SELECT DISTINCT idCliente,
                    substr(DtCriacao, 1,10) as Dias_Curso
            FROM transacoes as t1
            WHERE substr(DtCriacao, 1,10) >= '2025-08-25'
            AND substr(DtCriacao, 1,10) < '2025-08-30'
),
Dias_clientes AS ( 
            SELECT  t1.idCliente,
                    COUNT(t2.Dias_Curso) as QTDE_DIAS,
                    t2.Dias_Curso

            FROM tb_prim_dia as t1

            LEFT JOIN tb_dias_totais as t2
            on t1.idCliente = t2.idCliente

            GROUP BY t1.idCliente
)
            
            SELECT AVG(QTDE_DIAS)

            FROM Dias_clientes



