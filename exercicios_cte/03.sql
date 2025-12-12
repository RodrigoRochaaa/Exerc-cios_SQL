--Do início ao fim do nosso curso (2025/08/25 a 2025/08/29), quantos clientes assinaram a lista de presença?

WITH tb_agregacao AS ( 
    SELECT  t1.IdCliente,
            t1.IdTransacao, 
            substr(t1.DtCriacao, 1,10) dias_transacao,
            t2.IdProduto

    FROM transacoes as t1

    LEFT JOIN transacao_produto as t2
    ON t1.IdTransacao = t2.IdTransacao


    WHERE substr(t1.DtCriacao, 1,10) >= "2025-08-25"
    AND substr(t1.DtCriacao, 1,10) < "2025-08-30"
)

  SELECT COUNT(DISTINCT IdCliente) as lista_presenca,
        DescNomeProduto
 
  FROM tb_agregacao as t1

  left join produtos as t2
  on t1.idProduto = t2.IdProduto 

  WHERE DescNomeProduto = "Lista de presença" 




