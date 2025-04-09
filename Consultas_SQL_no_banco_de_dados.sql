-- Persistência de Dados para Testes

-- Inserindo Clientes
INSERT INTO Cliente (Nome, Endereco, Telefone) VALUES 
('João Silva', 'Rua A, 123', '11987654321'),
('Maria Oliveira', 'Rua B, 456', '11965432189');

-- Inserindo Veículos
INSERT INTO Veiculo (Placa, Modelo, Ano, ID_Cliente) VALUES 
('ABC1234', 'Gol', 2015, 1),
('DEF5678', 'Onix', 2019, 2);

-- Inserindo Mecânicos
INSERT INTO Mecanico (Nome, Endereco, Especialidade) VALUES 
('Carlos Santos', 'Rua C, 789', 'Suspensão'),
('Fernanda Lima', 'Rua D, 101', 'Freios');

-- Inserindo Equipes
INSERT INTO Equipe (Nome_Equipe) VALUES 
('Equipe A'),
('Equipe B');

-- Relacionando Mecânicos às Equipes
INSERT INTO Equipe_Mecanico (ID_Equipe, ID_Mecanico) VALUES 
(1, 1), 
(2, 2);

-- Inserindo Serviços
INSERT INTO Servico (Descricao, Valor_Mao_de_Obra) VALUES 
('Troca de óleo', 50.00),
('Revisão completa', 200.00);

-- Inserindo Peças
INSERT INTO Peca (Descricao, Valor) VALUES 
('Filtro de óleo', 30.00),
('Velas de ignição', 120.00);

-- Inserindo Ordens de Serviço
INSERT INTO Ordem_Servico (Numero, Data_Emissao, Data_Conclusao, Valor_Total, Status, ID_Veiculo, ID_Equipe) VALUES 
('OS001', '2025-01-10', '2025-01-15', 300.00, 'Concluída', 1, 1),
('OS002', '2025-01-20', NULL, NULL, 'Em Andamento', 2, 2);

-- Relacionando Serviços às OS
INSERT INTO OS_Servico (ID_OS, ID_Servico) VALUES 
(1, 1),
(1, 2);

-- Relacionando Peças às OS
INSERT INTO OS_Peca (ID_OS, ID_Peca) VALUES 
(1, 1),
(1, 2);

-- Consultas Complexas com Diferentes Cláusulas

-- 1. Recuperações Simples
-- Recuperar todos os clientes
SELECT * FROM Cliente;

-- Listar todas as ordens de serviço
SELECT * FROM Ordem_Servico;

-- 2. Filtros com WHERE
-- Recuperar mecânicos especializados em freios
SELECT * 
FROM Mecanico
WHERE Especialidade = 'Freios';

-- Listar ordens de serviço com status 'Concluída'
SELECT * 
FROM Ordem_Servico
WHERE Status = 'Concluída';

-- 3. Atributos Derivados
-- Calcular o valor total da mão de obra e peças de cada OS
SELECT OS.Numero, 
       SUM(S.Valor_Mao_de_Obra + P.Valor) AS Valor_Total_Calculado
FROM Ordem_Servico OS
LEFT JOIN OS_Servico OSS ON OS.ID_OS = OSS.ID_OS
LEFT JOIN Servico S ON OSS.ID_Servico = S.ID_Servico
LEFT JOIN OS_Peca OSP ON OS.ID_OS = OSP.ID_OS
LEFT JOIN Peca P ON OSP.ID_Peca = P.ID_Peca
GROUP BY OS.Numero;

-- 4. Ordenação com ORDER BY
-- Listar clientes ordenados pelo nome
SELECT * 
FROM Cliente
ORDER BY Nome ASC;

-- Listar ordens de serviço em ordem decrescente de data de emissão
SELECT * 
FROM Ordem_Servico
ORDER BY Data_Emissao DESC;

-- 5. Filtros em Grupos (HAVING)
-- Listar equipes que têm mais de 1 mecânico associado
SELECT E.Nome_Equipe, COUNT(EM.ID_Mecanico) AS Total_Mecanicos
FROM Equipe E
JOIN Equipe_Mecanico EM ON E.ID_Equipe = EM.ID_Equipe
GROUP BY E.Nome_Equipe
HAVING COUNT(EM.ID_Mecanico) > 1;

-- 6. Junções entre Tabelas
-- Listar ordens de serviço com dados de clientes e veículos
SELECT OS.Numero AS Numero_OS, C.Nome AS Cliente, V.Modelo AS Veiculo, OS.Status
FROM Ordem_Servico OS
JOIN Veiculo V ON OS.ID_Veiculo = V.ID_Veiculo
JOIN Cliente C ON V.ID_Cliente = C.ID_Cliente;

-- Listar todos os mecânicos e as equipes às quais pertencem
SELECT M.Nome AS Mecânico, E.Nome_Equipe AS Equipe
FROM Mecanico M
JOIN Equipe_Mecanico EM ON M.ID_Mecanico = EM.ID_Mecanico
JOIN Equipe E ON EM.ID_Equipe = E.ID_Equipe;
