--Quantos clientes tem email cadastrado?

SELECT Count(DISTINCT(IdCliente)) as total_clientes,
        FlEmail


FROM clientes

WHERE FlEmail = 1