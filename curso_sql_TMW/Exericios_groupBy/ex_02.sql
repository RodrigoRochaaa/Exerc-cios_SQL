--Qual cliente juntou mais pontos positivos em 2025-05?

SELECT  IdCliente,
        SUM(CASE 
            WHEN QtdePontos > 0 then QtdePontos
            END) as pontos_positivos

FROM transacoes

WHERE strftime('%Y-%m', substr(DtCriacao, 1,10)) == '2025-05'

GROUP BY IdCliente

ORDER BY SUM(CASE 
            WHEN QtdePontos > 0 then QtdePontos ELSE 0
            END) DESC

limit 1


