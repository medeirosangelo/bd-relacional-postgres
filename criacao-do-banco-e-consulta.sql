-- Criar o schema
CREATE SCHEMA IF NOT EXISTS viagens;

-- Tabela de usuários
CREATE TABLE viagens.usuarios (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(50) NOT NULL
);

-- Comentários para a tabela usuarios
COMMENT ON COLUMN viagens.usuarios.id IS 'Identificador único do usuário';
COMMENT ON COLUMN viagens.usuarios.nome IS 'Nome do usuário';
COMMENT ON COLUMN viagens.usuarios.email IS 'Endereço de e-mail do usuário';
COMMENT ON COLUMN viagens.usuarios.data_nascimento IS 'Data de nascimento do usuário';
COMMENT ON COLUMN viagens.usuarios.endereco IS 'Endereço do cliente';

-- Tabela de destinos
CREATE TABLE viagens.destinos (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    descricao VARCHAR(255) NOT NULL
);

-- Comentários para a tabela destinos
COMMENT ON COLUMN viagens.destinos.id IS 'Identificador único do destino';
COMMENT ON COLUMN viagens.destinos.nome IS 'Nome do destino';
COMMENT ON COLUMN viagens.destinos.descricao IS 'Descrição do destino';

-- Tabela de reservas
CREATE TABLE viagens.reservas (
    id INT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_destino INT NOT NULL,
    data DATE NOT NULL,
    status VARCHAR(255) DEFAULT 'pendente',

    -- Chaves estrangeiras
    FOREIGN KEY (id_usuario) REFERENCES viagens.usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_destino) REFERENCES viagens.destinos(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Comentários para a tabela reservas
COMMENT ON COLUMN viagens.reservas.id IS 'Identificador único da reserva';
COMMENT ON COLUMN viagens.reservas.id_usuario IS 'Referência ao usuário que fez a reserva';
COMMENT ON COLUMN viagens.reservas.id_destino IS 'Referência ao destino da reserva';
COMMENT ON COLUMN viagens.reservas.data IS 'Data da reserva';
COMMENT ON COLUMN viagens.reservas.status IS 'Status da reserva (confirmada, pendente, cancelada, etc.)';

-- Inserir usuários
INSERT INTO viagens.usuarios (id, nome, email, data_nascimento, endereco) VALUES
(1, 'João Silva', 'joao@test.com', '1988-05-16', 'Rua A, 123, Cidade X, Estado Y'),
(2, 'Maria Brando', 'maria@test.com', '2000-01-22', 'Rua B, 456, Cidade Y, Estado Z'),
(3, 'Pedro Zoto', 'pedro@test.com', '2001-08-02', 'Rua C, 789, Cidade Z, Estado X');

-- Inserir destinos
INSERT INTO viagens.destinos (id, nome, descricao) VALUES
(1, 'Tepequém', 'Grande vista dos céus e terras de Macunaíma'),
(2, 'Véu de Noiva', 'Grande cachoeira de Roraima'),
(3, 'Garapé do Santa Cecília', 'Garapé tradicional do Cantá');

-- Inserir reservas
INSERT INTO viagens.reservas (id, id_usuario, id_destino, data, status) VALUES
(1, 1, 2, '2025-07-15', 'Confirmada'),
(2, 2, 1, '2025-07-16', 'Pendente'),
(3, 3, 3, '2025-07-17', 'Cancelada');

-- SELECTs --

-- Selecionar todos os registros da tabela "usuários"
SELECT * FROM viagens.usuarios;

-- Selecionar apenas o nome e o email dos usuários
SELECT email, nome FROM viagens.usuarios;

-- Selecionar os usuários que possuem o nome "João Silva"
SELECT * FROM viagens.usuarios WHERE nome = 'João Silva'

-- Selecionar os usuários que nasceram antes de uma determinada data
SELECT * FROM viagens.usuarios WHERE data_nascimento < '2000-01-01'

-- LIKE -> Sem diferenciação entre maiúsculas e minúsculas
-- Usuários cujo nome contém 'Silva'
SELECT * FROM viagens.usuarios WHERE nome LIKE '%Silva%'

-- Usuários curjo nome começa com "João" com uma letra variando no lugar do "_"
SELECT * FROM viagens.usuarios WHERE nome LIKE 'Jo_o%';

-- UPDATE --

-- Atualizar o endereço do usuário com o e-mail específico
UPDATE viagens.usuarios
SET endereco = 'Nova Rua, 123'
WHERE email = 'joao@test.com';

-- DELETE --

-- Excluir todas as reservas com status "Cancelada"
DELETE FROM viagens.reservas WHERE status ILIKE 'cancelada'; -- ILIKE para não diferenciar maiúsculas/minúsculas



