--Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?

WITH tb_prim_dia AS(
            SELECT idCliente,
                    IdTransacao
            FROM transacoes
            WHERE substr(DtCriacao, 1,10) == '2025-08-25'
),
        tb_curso_completo AS(     
            SELECT  idCliente,
                    count(IdTransacao) as transacao_cliente,
                    substr(DtCriacao, 1,10) as dias_curso
            FROM transacoes

            WHERE substr(DtCriacao, 1,10) >= '2025-08-25'
            AND substr(DtCriacao, 1,10) < '2025-08-30'

            GROUP BY idCliente, substr(DtCriacao, 1,10)
),      Tb_consumo_cliente AS ( 
            SELECT t1.idCliente,
                   t2.transacao_cliente,
                   t2.dias_curso,
                   row_number() over (PARTITION BY t1.idCliente ORDER BY t2.transacao_cliente DESC) as engajamento_aluno

            FROM tb_prim_dia as t1

            INNER JOIN tb_curso_completo as t2
            on t1.idCliente = t2.idCliente
)
            SELECT idCliente,
                   transacao_cliente,
                   dias_curso

            FROM Tb_consumo_cliente
            WHERE engajamento_aluno = 1


    
