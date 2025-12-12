--Quais clientes mais perderam pontos por Lover?

SELECT  t1.idCliente,
        SUM(t1.tdePontos) as pts_gastos 

FROM transacoes as t1

LEFT JOIN transacao_produto as t2
ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN  produtos as t3
ON t2.IdProduto = t3.IdProduto

WHERE t3.DescCategoriaProduto = 'lovers'

GROUP BY t1.IdCliente

ORDER BY SUM(t1.tdePontos) ASC

