--Lista de transações com o produto “Resgatar Ponei”;

SELECT t1.IdTransacao,
        t2.DescCateogriaProduto,
        t2.DescProduto

from transacao_produto as t1

left join produtos as t2
on t1.IdProduto = t2.IdProduto

where t2.DescProduto = "Resgatar Ponei"

