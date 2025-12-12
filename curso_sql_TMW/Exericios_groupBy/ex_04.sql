--Quantos produtos são de rpg?

SELECT DescCateogriaProduto,
        COUNT(DescProduto) as total_produtos

FROM produtos

WHERE DescCateogriaProduto == 'rpg'

GROUP BY DescCateogriaProduto