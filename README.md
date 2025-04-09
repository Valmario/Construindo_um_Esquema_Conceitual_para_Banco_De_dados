# 📘 Modelo Conceitual – Sistema de Oficina Mecânica

## 🧩 Visão Geral do Projeto

Este repositório apresenta o modelo conceitual de um sistema de **controle e gerenciamento de ordens de serviço (OS)** para uma **oficina mecânica**. O objetivo principal é estruturar as entidades, atributos e relacionamentos necessários para registrar e acompanhar os atendimentos prestados a clientes e seus veículos, além da gestão de equipes, serviços e peças.

> ![Construindo um Esquema Conceitual para Banco de Dados](https://github.com/Valmario/Construindo_um_Esquema_Conceitual_para_Banco_De_dados/blob/main/BD.jpg)

---

## 🧱 Modelo Conceitual

### 🔹 Entidades e Atributos

#### **1. Cliente**
Representa os clientes que contratam os serviços da oficina.
- `ID_Cliente` (PK)
- `Nome`
- `Endereço`
- `Telefone`

#### **2. Veículo**
Representa os veículos dos clientes.
- `ID_Veiculo` (PK)
- `Placa`
- `Modelo`
- `Ano`
- `ID_Cliente` (FK)

#### **3. Mecânico**
Funcionário responsável pela execução dos serviços.
- `ID_Mecanico` (PK)
- `Nome`
- `Endereço`
- `Especialidade`

#### **4. Equipe**
Grupos de mecânicos responsáveis por executar ordens de serviço.
- `ID_Equipe` (PK)
- `Nome_Equipe`

#### **5. Serviço**
Tipos de serviços oferecidos pela oficina.
- `ID_Servico` (PK)
- `Descricao`
- `Valor_Mao_de_Obra`

#### **6. Peça**
Peças utilizadas durante os reparos e manutenções.
- `ID_Peca` (PK)
- `Descricao`
- `Valor`

#### **7. Ordem de Serviço (OS)**
Registro das solicitações de serviços executadas.
- `ID_OS` (PK)
- `Numero`
- `Data_Emissao`
- `Data_Conclusao`
- `Valor_Total`
- `Status` (`Aberta`, `Em Andamento`, `Concluída`, `Cancelada`)
- `ID_Veiculo` (FK)
- `ID_Equipe` (FK)

---

### 🔗 Relacionamentos

- **Cliente (1:N) Veículo** – Um cliente pode possuir vários veículos.
- **Veículo (1:N) Ordem de Serviço** – Um veículo pode ter várias ordens de serviço.
- **Equipe (1:N) Ordem de Serviço** – Uma equipe pode atuar em várias OS.
- **Mecânico (N:M) Equipe** – Um mecânico pode participar de várias equipes e vice-versa.
- **Serviço (N:M) Ordem de Serviço** – Uma OS pode conter vários serviços e um serviço pode estar em várias OS.
- **Peça (N:M) Ordem de Serviço** – Uma OS pode utilizar várias peças e uma peça pode ser usada em várias OS.

---

## 💾 Estrutura SQL do Banco de Dados

```sql
-- Criação do banco
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

-- Relacionamento Equipe-Mecânico
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

-- Tabela Ordem de Serviço
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

-- Relacionamento OS-Serviço
CREATE TABLE OS_Servico (
    ID_OS INT NOT NULL,
    ID_Servico INT NOT NULL,
    PRIMARY KEY (ID_OS, ID_Servico),
    FOREIGN KEY (ID_OS) REFERENCES Ordem_Servico(ID_OS),
    FOREIGN KEY (ID_Servico) REFERENCES Servico(ID_Servico)
);

-- Relacionamento OS-Peça
CREATE TABLE OS_Peca (
    ID_OS INT NOT NULL,
    ID_Peca INT NOT NULL,
    PRIMARY KEY (ID_OS, ID_Peca),
    FOREIGN KEY (ID_OS) REFERENCES Ordem_Servico(ID_OS),
    FOREIGN KEY (ID_Peca) REFERENCES Peca(ID_Peca)
);
```

---

## 📌 Considerações Finais

Este modelo conceitual foi projetado para oferecer **organização, rastreabilidade e eficiência** no gerenciamento de serviços prestados por oficinas mecânicas. Ele pode ser expandido futuramente com funcionalidades como controle de estoque, faturamento, agendamentos e dashboards gerenciais.
