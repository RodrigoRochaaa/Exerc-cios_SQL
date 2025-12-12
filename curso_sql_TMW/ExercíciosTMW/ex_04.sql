--Lista de clientes com 100 a 200 pontos (inclusive ambos);
SELECT IdCliente,
    QtdePontos
FROM clientes
WHERE QtdePontos >= 100
and QtdePontos <= 200