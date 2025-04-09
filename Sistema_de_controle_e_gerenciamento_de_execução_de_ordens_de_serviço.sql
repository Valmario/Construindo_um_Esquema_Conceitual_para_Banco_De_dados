-- Criação do Banco de Dados
CREATE DATABASE OficinaMecanica;

-- Tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255),
    Telefone VARCHAR(15)
);

-- Tabela Veículo
CREATE TABLE Veiculo (
    ID_Veiculo INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(10) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Ano INT NOT NULL,
    ID_Cliente INT NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Mecânico
CREATE TABLE Mecanico (
    ID_Mecanico INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255),
    Especialidade VARCHAR(50)
);

-- Tabela Equipe
CREATE TABLE Equipe (
    ID_Equipe INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Equipe VARCHAR(100) NOT NULL
);

-- Tabela Relacionamento Equipe-Mecânico
CREATE TABLE Equipe_Mecanico (
    ID_Equipe INT NOT NULL,
    ID_Mecanico INT NOT NULL,
    PRIMARY KEY (ID_Equipe, ID_Mecanico),
    FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe),
    FOREIGN KEY (ID_Mecanico) REFERENCES Mecanico(ID_Mecanico)
);

-- Tabela Serviço
CREATE TABLE Servico (
    ID_Servico INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(255) NOT NULL,
    Valor_Mao_de_Obra DECIMAL(10, 2) NOT NULL
);

-- Tabela Peça
CREATE TABLE Peca (
    ID_Peca INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(255) NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL
);

-- Tabela Ordem de Serviço (OS)
CREATE TABLE Ordem_Servico (
    ID_OS INT PRIMARY KEY AUTO_INCREMENT,
    Numero VARCHAR(20) NOT NULL,
    Data_Emissao DATE NOT NULL,
    Data_Conclusao DATE,
    Valor_Total DECIMAL(10, 2),
    Status ENUM('Aberta', 'Em Andamento', 'Concluída', 'Cancelada') NOT NULL,
    ID_Veiculo INT NOT NULL,
    ID_Equipe INT NOT NULL,
    FOREIGN KEY (ID_Veiculo) REFERENCES Veiculo(ID_Veiculo),
    FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe)
);

-- Tabela Relacionamento OS-Serviço
CREATE TABLE OS_Servico (
    ID_OS INT NOT NULL,
    ID_Servico INT NOT NULL,
    PRIMARY KEY (ID_OS, ID_Servico),
    FOREIGN KEY (ID_OS) REFERENCES Ordem_Servico(ID_OS),
    FOREIGN KEY (ID_Servico) REFERENCES Servico(ID_Servico)
);

-- Tabela Relacionamento OS-Peça
CREATE TABLE OS_Peca (
    ID_OS INT NOT NULL,
    ID_Peca INT NOT NULL,
    PRIMARY KEY (ID_OS, ID_Peca),
    FOREIGN KEY (ID_OS) REFERENCES Ordem_Servico(ID_OS),
    FOREIGN KEY (ID_Peca) REFERENCES Peca(ID_Peca)
);
