--Qual cliente fez mais transações no ano de 2024?

SELECT  IdCliente,
        COUNT(IdTransacao) as transacao_cliente,
        strftime('%Y-%m', substr(DtCriacao, 1,10)) as data_mes 

FROM transacoes

WHERE strftime('%Y-%m', substr(DtCriacao, 1,10)) >= '2024-01' 
and strftime('%Y-%m', substr(DtCriacao, 1,10)) <= '2024-12'

GROUP BY IdCliente

ORDER BY COUNT(IdTransacao) DESC
LIMIT 5

