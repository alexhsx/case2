SELECT *
FROM `db_vendas`.`tabela1`;
SELECT m.marca, l.linha, tb.qtd
FROM `db_vendas`.`tabela2` tb 
join `db_vendas`.`marca` m on tb.idMarca = m.id_marca
join `db_vendas`.`linha` l on tb.idMarca = l.id_linha;

SELECT l.linha, tb.mes, tb.ano, tb.qtd
FROM `db_vendas`.`tabela3` tb
join `db_vendas`.`linha` l on tb.idMarca = l.id_linha;
SELECT m.marca, tb.mes, tb.ano, tb.qtd
FROM `db_vendas`.`tabela4` tb
join `db_vendas`.`marca` m on tb.idMarca = m.id_marca;