WITH tb_transacoes AS(        
                SELECT 
                IdTransacao,
                IdCliente,
                QtdePontos,
                datetime(substr(DtCriacao,1,19)) as DtCriacao,
                julianday('now') - julianday(substr(DtCriacao,1,10)) as diffDate,
                CAST(strftime('%H', substr(DtCriacao,1,19)) AS INTEGER)  AS dtHora
        FROM transacoes
),

tb_cliente AS( 
        SELECT  idCliente,
                datetime(substr(DtCriacao,1,19)) as DtCriacao,
                julianday('now') -  julianday(substr(DtCriacao,1,10)) as idade_base
        
        FROM clientes
   
),

tb_sumario_transacoes AS( 
        SELECT  IdCliente,
                COUNT(IdTransacao) AS qtdeTransacoes,
                COUNT(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS D56,
                COUNT(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS D28,
                COUNT(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS D14,
                COUNT(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS D7,
                SUM(qtdePontos) as saldoPontos,
                MIN(diffDate) as ultima_transacao,
                
                SUM(CASE WHEN qtdePontos > 0 THEN qtdePontos ELSE 0 END) AS qtde_pontos_pos_vida,
                SUM(CASE WHEN qtdePontos > 0 AND diffDate <=56 THEN qtdePontos ELSE 0 END) AS  Qtde_pontos_pos_56,
                SUM(CASE WHEN qtdePontos > 0 AND diffDate <=28 THEN qtdePontos ELSE 0 END) AS  Qtde_pontos_pos_28,
                SUM(CASE WHEN qtdePontos > 0 AND diffDate <=14 THEN qtdePontos ELSE 0 END) AS  Qtde_pontos_pos_14,
                SUM(CASE WHEN qtdePontos  > 0  AND diffDate <=7 THEN qtdePontos ELSE 0 END) AS Qtde_pontos_pos_7,

                SUM(CASE WHEN qtdePontos < 0 THEN qtdePontos ELSE 0 END) AS qtde_pontos_neg_vida,
                SUM(CASE WHEN qtdePontos < 0 AND diffDate <=56 THEN qtdePontos ELSE 0 END)AS  Qtde_pontos_neg_56,
                SUM(CASE WHEN qtdePontos < 0 AND diffDate <=28 THEN qtdePontos ELSE 0 END)AS  Qtde_pontos_neg_28,
                SUM(CASE WHEN qtdePontos < 0 AND diffDate <=14 THEN qtdePontos ELSE 0 END)AS  Qtde_pontos_neg_14,
               SUM(CASE WHEN qtdePontos  < 0  AND diffDate <=7 THEN qtdePontos ELSE 0 END)AS Qtde_pontos_neg_7
        FROM tb_transacoes

        GROUP BY IdCliente
),

        tb_transacao_produtos AS( 
        SELECT t1.*,
                t3.DescNomeProduto,
                t3.DescCategoriaProduto
        FROM tb_transacoes as t1

        LEFT JOIN transacao_produto as t2
        ON t1.IdTransacao = t2.IdTransacao

        LEFT JOIN produtos as t3
        ON t2.IdProduto = t3.IdProduto
),

tb_cliente_produto AS( 
        SELECT idCliente,
        DescNomeProduto,
        COUNT(*) as qtdeVida,
        COUNT(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS qtde56,
        COUNT(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS qtde28,
        COUNT(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS qtde14,
        COUNT(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS qtde7

        FROM tb_transacao_produtos

        GROUP BY idCliente, DescNomeProduto
),

tb_cliente_produto_rn AS ( 

        SELECT  *,
        row_number() OVER(PARTITION BY idCliente ORDER BY qtdeVida DESC) AS rnvida,
        row_number() OVER(PARTITION BY idCliente ORDER BY qtde56 DESC) AS rn56,
        row_number() OVER(PARTITION BY idCliente ORDER BY qtde28 DESC) AS rn28,
        row_number() OVER(PARTITION BY idCliente ORDER BY qtde14 DESC) AS rn14,
        row_number() OVER(PARTITION BY idCliente ORDER BY qtde7 DESC) AS rn7
        

        FROM tb_cliente_produto
),

Tb_transacoes_dia_semana AS ( 
        SELECT IdCliente,
                COUNT(IdTransacao) AS qtde_transacoes_d28,
                strftime('%w', DtCriacao) as Dias_semana
        
        FROM tb_transacoes

        WHERE diffDate <= 28

        GROUP BY idCliente, Dias_semana

),
Tb_engajamento_semana_d28 AS (
        SELECT  idCliente,
                ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY qtde_transacoes_d28) as maior_engajamento,
                CASE Dias_semana
                    WHEN '0' THEN 'Domingo'
                    WHEN '1' THEN 'Segunda'
                    WHEN '2' THEN 'Terça'
                    WHEN '3' THEN 'Quarta'
                    WHEN '4' THEN 'Quinta'
                    WHEN '5' THEN 'Sexta'
                    WHEN '6' THEN 'Sábado'
                    END AS dia_semana

                
        
        FROM Tb_transacoes_dia_semana
),      

tb_cliente_periodo AS( 

        SELECT  idCliente,
                CASE 
                WHEN dtHora BETWEEN 7 AND 12 THEN 'Manhã'
                WHEN dtHora BETWEEN 13 AND 18 THEN 'Tarde'
                WHEN dtHora BETWEEN 19 AND 23 THEN 'Noite'
                ELSE 'Madrugada'
                END AS periodo,
                Count(*) AS QTDE_transacao

        FROM tb_transacoes

        WHERE diffDate <= 28

        GROUP BY 1,2
),

tb_fav_periodo AS(
                SELECT  *,
                        ROW_NUMBER() OVER(PARTITION BY idCliente ORDER BY QTDE_transacao) as fav_dia_Cliente
        
        FROM tb_cliente_periodo
),

tb_join AS( 
        SELECT t1.*,
                t2.idade_base,
                t3.DescNomeProduto as Produto_vida,
                t4.DescNomeProduto as Produto_56,
                t5.DescNomeProduto as Produto_28,
                t6.DescNomeProduto as Produto_14,
                t7.DescNomeProduto as Produto_7,
                COALESCE(t8.dia_semana, -1) as Dia_semana_maior_engaja_28,
                t9.periodo

        FROM tb_sumario_transacoes as t1

        LEFT JOIN tb_cliente as t2
        ON t1.idCliente = t2.idCliente

        LEFT JOIN tb_cliente_produto_rn AS t3
        ON t1.idCliente = t3.idCliente
        AND t3.rnvida = 1

        LEFT JOIN tb_cliente_produto_rn AS t4
        ON t1.idCliente = t4.idCliente
        AND t4.rn56 = 1

        LEFT JOIN tb_cliente_produto_rn AS t5
        ON t1.idCliente = t5.idCliente
        AND t5.rn28 = 1

        LEFT JOIN tb_cliente_produto_rn AS t6
        ON t1.idCliente = t6.idCliente
        AND t6.rn14 = 1

        LEFT JOIN tb_cliente_produto_rn AS t7
        ON t1.idCliente = t7.idCliente
        AND t7.rn7 = 1

        LEFT JOIN Tb_engajamento_semana_d28 as t8
        ON t1.idCliente = t8.idCliente
        AND t8.maior_engajamento = 1

        LEFT JOIN tb_fav_periodo as t9
        ON t1.idCliente = t9.idCliente
        AND t9.fav_dia_Cliente = 1
)

SELECT *,
        1. * Qtde_pontos_pos_28/ qtde_pontos_pos_vida as engajamento_28_vida

FROM tb_join