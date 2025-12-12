--Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?

WITH Clientes_dia AS(
        SELECT count(DISTINCT idCliente) Clientes_absoluto,
        substr(DtCriacao,1,10) as dias


FROM clientes

WHERE flTwitch == 1

GROUP BY substr(DtCriacao,1,10)
)
  SELECT *,
        SUM(Clientes_absoluto) OVER (ORDER BY dias) as clientes_acum
         
  FROM Clientes_dia