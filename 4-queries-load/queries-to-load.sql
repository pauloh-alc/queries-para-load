ALTER DATABASE teste3DB CHARACTER SET latin1;

/* LOAD - Copular tabela Operadoras */

USE teste3DB;
LOAD DATA INFILE '/var/lib/mysql-files/relatorio.csv'
INTO TABLE Operadoras
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 3 ROWS
(
    @REGISTRO_ANS, 
    CNPJ, 
    RAZAO_SOCIAL,
    NOME_FANTASIA, 
    MODALIDADE,
    LOGRADOURO,
    NUMERO,
    COMPLEMENTO,
    BAIRRO,
    CIDADE,
    UF,
    CEP,
    DDD,
    TELEFONE,
    FAX,
    EMAIL,
    REPRESENTANTE,
    CARGO_REPRESENTANTE,
    @DATA_REGISTRO_ANS
)
SET 
DATA_REGISTRO_ANS = str_to_date(@DATA_REGISTRO_ANS, '%d/%m/%Y'),
REGISTRO_ANS = TRIM(LEADING 0 FROM @REGISTRO_ANS);

/* LOAD - Copulando tabela Operacoes*/


/* 2° Trimestre de 2022, isto é, ÚLTIMO trimestre (file -> 2T2022.csv) */
USE teste3DB;
LOAD DATA INFILE '/var/lib/mysql-files/2T2022.csv'
INTO TABLE DespesasUltimoTrimestre2022
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    @DATA,
    @REG_ANS,
    CD_CONTA_CONTABIL,
    DESCRICAO,
    @VL_SALDO_INICIAL, 
    @VL_SALDO_FINAL
)
SET
DATA = str_to_date(@DATA, '%d/%m/%Y'),
VL_SALDO_INICIAL = CAST(REPLACE(@VL_SALDO_INICIAL,',','.') AS DECIMAL(16,2)),
VL_SALDO_FINAL = CAST(REPLACE(@VL_SALDO_FINAL,',','.') AS DECIMAL(16,2)),
REG_ANS = TRIM(LEADING 0 FROM @REG_ANS);


/* Ultimo Ano, isto é, ano de 2021 */
/*
	Vou usar essa query de load para carregar dados dos arquivos:
    1T2021.csv, 2T2021.csv, 3T2021.cs. O file 4T2021.csv vou fazer o 
    load em outra query.
*/
USE teste3DB;
LOAD DATA INFILE '/var/lib/mysql-files/1T2021.csv'
INTO TABLE DespesasUltimoAno2021
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    @DATA,
    @REG_ANS,
    CD_CONTA_CONTABIL,
    DESCRICAO,
    @VL_SALDO_FINAL
)
SET
DATA = str_to_date(@DATA, '%d/%m/%Y'),
VL_SALDO_FINAL = CAST(REPLACE(@VL_SALDO_FINAL,',','.') AS DECIMAL(16,2)),
REG_ANS = TRIM(LEADING 0 FROM @REG_ANS);


/* Load para arquivo 4T2021.csv */
USE teste3DB;
LOAD DATA INFILE '/var/lib/mysql-files/4T2021.csv'
INTO TABLE UltimoTrimestreDe2021 
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    DATA,
    @REG_ANS,
    CD_CONTA_CONTABIL,
    DESCRICAO,
    @VL_SALDO_INICIAL,
    @VL_SALDO_FINAL
)
SET
VL_SALDO_FINAL = CAST(REPLACE(@VL_SALDO_FINAL,',','.') AS DECIMAL(16,2)),
VL_SALDO_INICIAL = CAST(REPLACE(@VL_SALDO_INICIAL,',','.') AS DECIMAL(16,2)),
REG_ANS = TRIM(LEADING 0 FROM @REG_ANS);
