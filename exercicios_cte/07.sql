--Qual o dia da semana mais ativo de cada usuário?

WITH tb_interacoes_dia AS( 
    SELECT  idCliente,
        COUNT(IdTransacao) as interacoes_dia,
        strftime('%w', substr(DtCriacao,1,10)) as dia_semana
        
FROM transacoes

GROUP BY IdCliente,strftime('%w', substr(DtCriacao,1,10))
), tb_maior_inter AS( 
    SELECT idCliente,
            dia_semana,
            interacoes_dia,
            ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY interacoes_dia DESC) as maior_interacao

    FROM tb_interacoes_dia
)
    SELECT * 
    
    FROM tb_maior_inter

    WHERE maior_interacao = 1

