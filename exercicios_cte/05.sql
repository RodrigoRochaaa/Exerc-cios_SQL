--Quantidade de transações Acumuladas ao longo do tempo?

WITH transacao_dia AS( 
SELECT idCliente,
        COUNT(IdTransacao) qtde_transacao,
        substr(DtCriacao,1,10) as dias

FROM transacoes

GROUP BY substr(DtCriacao,1,10)

ORDER BY substr(DtCriacao,1,10) ASC
)

SELECT  *,
        SUM(qtde_transacao) over (PARTITION BY IdCliente ORDER BY dias ASC) as transacoes_acumuladas

FROM transacao_dia