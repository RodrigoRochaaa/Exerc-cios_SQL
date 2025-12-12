--Listar todas as transações adicionando uma coluna nova sinalizando 
--“alto”, “médio” e “baixo” para o valor dos pontos [<10 ; <500; >=500]

SELECT IdTransacao,
        SUM(QtdePontos),
        case when SUM(QtdePontos) < 10 then baixo
        when SUM(QtdePontos) < 500 then médio
        else alto
        end as nivel_transacao

FROM transacoes

GROUP BY IdTransacao