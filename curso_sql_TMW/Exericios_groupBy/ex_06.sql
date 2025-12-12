--Qual dia da semana tem mais pedidos em 2025?

SELECT IdCliente,
        COUNT(IdTransacao) transacoes_ano,
        strftime('%w', substr(DtCriacao,1,10)) as dias_semana

FROM transacoes

WHERE substr(DtCriacao,1,10) >= '2025-01-01'

GROUP BY strftime('%w', substr(DtCriacao,1,10))

ORDER BY 	transacoes_ano DESC