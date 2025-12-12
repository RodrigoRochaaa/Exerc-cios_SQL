--Saldo de pontos acumulado de cada usuário
WITH tb_pontos AS ( 
    SELECT  IdCliente,
            substr(DtCriacao, 1,10) as dia,
            SUM(QtdePontos) as pontos_dia

    FROM transacoes

    GROUP BY IdCliente, substr(DtCriacao, 1,10)
)

    SELECT  idCliente,
            dia,
            pontos_dia,
            SUM(pontos_dia) over(PARTITION BY IdCliente ORDER BY dia) as pontos_usuário_acum
    
    FROM tb_pontos