-- =========================================
-- myTagx QR Manager
-- Estrutura inicial do banco de dados
-- =========================================

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE clients (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(180) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(30),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE qr_codes (
    id BIGSERIAL PRIMARY KEY,
    client_id BIGINT NOT NULL REFERENCES clients(id),
    code VARCHAR(80) NOT NULL UNIQUE,
    title VARCHAR(180) NOT NULL,
    destination_url TEXT NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE qr_accesses (
    id BIGSERIAL PRIMARY KEY,
    qr_code_id BIGINT NOT NULL REFERENCES qr_codes(id),
    accessed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    user_agent TEXT,
    ip_hash VARCHAR(128)
);

CREATE TABLE settings (
    id BIGSERIAL PRIMARY KEY,
    setting_key VARCHAR(100) NOT NULL UNIQUE,
    setting_value TEXT,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Índices para melhorar consultas e estatísticas

CREATE INDEX idx_clients_active
ON clients(active);

CREATE INDEX idx_qr_codes_client
ON qr_codes(client_id);

CREATE INDEX idx_qr_codes_code
ON qr_codes(code);

CREATE INDEX idx_qr_accesses_qr_code
ON qr_accesses(qr_code_id);

CREATE INDEX idx_qr_accesses_date
ON qr_accesses(accessed_at);
