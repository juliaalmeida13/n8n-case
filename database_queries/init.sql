CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tabela de Clientes
CREATE TABLE clients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL
);

-- Tabela de Contratos
CREATE TABLE contracts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_id UUID NOT NULL,
    start_date DATE NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE
);

-- Tabela de Leituras Energéticas
CREATE TABLE energy_readings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    contract_id UUID NOT NULL,
    reading_date DATE NOT NULL,
    consumption DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (contract_id) REFERENCES contracts(id) ON DELETE CASCADE
);

GRANT ALL ON TABLE contracts TO n8nuser;
GRANT ALL ON TABLE clients TO n8nuser;
GRANT ALL ON TABLE energy_readings TO n8nuser;

/*
--- JUSTIFICATIVA DAS DECISÕES ---

Criei 3 tabelas baseadas nas informações fornecidas no pdf
do case enviado.

Todas as 3 tabelas utilizam id (UUID) como chave primária
- A tabela 'contracts' tem uma chave estrangeira que referencia a tabela 'clients'. Isso
possibilita a exclusão em cascata, ou seja, se um cliente for excluído, todos os contratos
relacionados a ele também serão excluídos.
- A tabela 'energy_readings' tem uma chave estrangeira que referencia a tabela 'contracts'. Isso
possibilita a exclusão em cascata, da mesma forma como foi mencionado acima para a tabela 'contracts'.
/* 
