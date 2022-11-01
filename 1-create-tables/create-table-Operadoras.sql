/* Criando tabela Operadoras */

CREATE TABLE Operadoras (
    REGISTRO_ANS VARCHAR(10) NOT NULL PRIMARY KEY,
    CNPJ VARCHAR(20),
    RAZAO_SOCIAL VARCHAR(200),
    NOME_FANTASIA VARCHAR(200),
    MODALIDADE VARCHAR(100),
    LOGRADOURO VARCHAR(50),
    NUMERO VARCHAR(30),
    COMPLEMENTO VARCHAR(100),
    BAIRRO VARCHAR(50),
    CIDADE VARCHAR(100),
    UF VARCHAR(2),
    CEP VARCHAR(20),
    DDD VARCHAR(2),
    TELEFONE VARCHAR(20),
    FAX VARCHAR(20),
    EMAIL VARCHAR(100),
    REPRESENTANTE VARCHAR(130),
    CARGO_REPRESENTANTE VARCHAR(100),
    DATA_REGISTRO_ANS DATE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;