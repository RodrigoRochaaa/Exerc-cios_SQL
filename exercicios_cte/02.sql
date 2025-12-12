--Quais clientes assinaram a lista de presença no dia 2025/08/25?
WITH tb_lista_presenca AS( 
    SELECT  t1.IdTransacao,            
            t2.DescNomeProduto

    FROM transacao_produto as t1

    LEFT JOIN produtos as t2
    ON t1.IdProduto = t2.IdProduto

    WHERE t2.DescNomeProduto = "Lista de presença"
),
--Todos os clientes que assinaram na data 2025/08/25
 tb_presenca_dia AS ( 
    SELECT DISTINCT(t1.IdCliente),
            t2.DescNomeProduto,
            substr(t1.DtCriacao,1,10) AS data
   
    FROM transacoes as t1

    INNER JOIN tb_lista_presenca as t2
    ON t1.IdTransacao = t2.IdTransacao

    WHERE substr(t1.DtCriacao,1,10) = "2025-08-25"
 )
--Quantidade de clientes que assinaram
 SELECT COUNT(IdCliente) 
 
 FROM tb_presenca_dia
