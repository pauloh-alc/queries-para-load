/*

1° Query analítica:

Quais as 10 operadoras que mais tiveram despesas com "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR"
no último trimestre do ano? 

Pelo que interpretei -> devo copular a tabela DespesasUltimoTrismestre2022 com o último arquivo de 
2T2022.csv. Em seguida, devo executar essa query analítica abaixo.

*/

SELECT Operadoras.REGISTRO_ANS, Operadoras.RAZAO_SOCIAL, SUM(DespesasUltimoTrimestre2022.VL_SALDO_FINAL) AS 'SOMA'
FROM Operadoras INNER JOIN DespesasUltimoTrimestre2022 ON
Operadoras.REGISTRO_ANS = DespesasUltimoTrimestre2022.REG_ANS
WHERE DespesasUltimoTrimestre2022.DESCRICAO LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
GROUP BY DespesasUltimoTrimestre2022.REG_ANS
ORDER BY SUM(DespesasUltimoTrimestre2022.VL_SALDO_FINAL) DESC
LIMIT 10;

/*

2° Query analítica:

Quais as 10 operadoras que mais tiveram despesas com "EVENTOS/SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR"
no último ano?

Pelo que interpretei -> devo copular a tabela DespesasUltimoAno2021 com todos os arquivos de 2021, isto é, o
último ano. Os arquivos que vão copular a tabela são: 1T2021.csv, 2T2021.csv, 3T2021.csv.

Como o arquivo 4T2021.csv apresenta uma coluna a mais que os outros 3 arquivos, decidi
coloca-lo em uma tabela diferente.
*/


(SELECT Operadoras.REGISTRO_ANS, Operadoras.RAZAO_SOCIAL, sum(DespesasUltimoAno2021.VL_SALDO_FINAL) AS 'SOMA'
FROM Operadoras INNER JOIN DespesasUltimoAno2021 ON
Operadoras.REGISTRO_ANS = DespesasUltimoAno2021.REG_ANS
WHERE DespesasUltimoAno2021.DESCRICAO LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
GROUP BY DespesasUltimoAno2021.REG_ANS
ORDER BY SUM(DespesasUltimoAno2021.VL_SALDO_FINAL) ASC
LIMIT 0,10
)
UNION
(SELECT Operadoras.REGISTRO_ANS, Operadoras.RAZAO_SOCIAL, sum(UltimoTrimestreDe2021.VL_SALDO_FINAL) AS 'SOMA'
FROM Operadoras INNER JOIN UltimoTrimestreDe2021 ON
Operadoras.REGISTRO_ANS = UltimoTrimestreDe2021.REG_ANS
WHERE UltimoTrimestreDe2021.DESCRICAO LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
GROUP BY UltimoTrimestreDe2021.REG_ANS
ORDER BY SUM(UltimoTrimestreDe2021.VL_SALDO_FINAL) ASC
LIMIT 0,10
)
LIMIT 10;