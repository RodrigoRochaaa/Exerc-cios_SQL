--Qual o valor médio de pontos positivos por dia?

WITH tb_media_pontos AS(SELECT  DtCriacao,
        SUM(CASE 
        WHEN QtdePontos > 0 then QtdePontos 
        END) as pontos_positivos

FROM transacoes

GROUP BY DtCriacao
)

SELECT avg(pontos_positivos)

FROM tb_media_pontos