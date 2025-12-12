--Lista de pedidos realizados no fim de semana;
SELECT IdTransacao,
        DtCriacao,
        strftime('%w', datetime(substr(DtCriacao, 1, 19))) as dia_semana_number
FROM transacoes

where strftime('%w', datetime(substr(DtCriacao, 1, 19))) in ('6', '0')