-- ============================================================================
-- Base de Datos: Ventas_Tech_DB
-- Entorno: Microsoft SQL Server / Azure SQL
-- Propósito: Script DDL/DML basado en el modelo relacional exacto del diagrama
-- ============================================================================

-- Paso 1: Crear y usar la base de datos
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Ventas_Tech_DB')
BEGIN
    CREATE DATABASE Ventas_Tech_DB;
END
GO

USE Ventas_Tech_DB;
GO

-- ============================================================================
-- DROP TABLES (Orden inverso de dependencias para no violar Foreign Keys)
-- ============================================================================
DROP TABLE IF EXISTS Ventas;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Territorio;
GO

-- ============================================================================
-- CREATE TABLES (Definición del Esquema según el diagrama)
-- ============================================================================

-- Tabla: Territorio
CREATE TABLE Territorio (
    id_territorio INT NOT NULL,
    Localidad VARCHAR(50) NULL,
    Provincia VARCHAR(50) NULL,
    Región VARCHAR(50) NULL,
    CONSTRAINT PK_Territorio PRIMARY KEY (id_territorio)
);

-- Tabla: Productos
CREATE TABLE Productos (
    id_producto INT NOT NULL,
    Categoría VARCHAR(50) NULL,
    Descripción VARCHAR(100) NULL,
    Costo DECIMAL(10,2) NULL,
    Precio DECIMAL(10,2) NULL,
    CONSTRAINT PK_Productos PRIMARY KEY (id_producto)
);

-- Tabla: Clientes
CREATE TABLE Clientes (
    id_cliente INT NOT NULL,
    id_territorio INT NULL,
    Fecha_Registro DATE NULL,
    Email VARCHAR(50) NULL,
    Nombre_cliente VARCHAR(50) NULL,
    [Tipo de cliente] VARCHAR(5) NULL,
    CONSTRAINT PK_Clientes PRIMARY KEY (id_cliente),
    CONSTRAINT FK_Clientes_Territorio FOREIGN KEY (id_territorio) REFERENCES Territorio(id_territorio)
);

-- Tabla: Ventas
CREATE TABLE Ventas (
    id_venta INT NOT NULL,
    id_producto INT NULL,
    id_cliente INT NULL,
    Canal VARCHAR(50) NULL,
    Fecha_venta DATE NULL,
    Total_venta DECIMAL(10,2) NULL,
    CONSTRAINT PK_Ventas PRIMARY KEY (id_venta),
    CONSTRAINT FK_Ventas_Productos FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    CONSTRAINT FK_Ventas_Clientes FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);
GO

-- ============================================================================
-- INSERT DATA (Carga Inicial DML coherente con el diagrama)
-- ============================================================================

-- 1. Insertar Territorios
INSERT INTO Territorio (id_territorio, Localidad, Provincia, Región) VALUES
(1, 'CABA', 'Buenos Aires', 'Centro'),
(2, 'Rosario', 'Santa Fe', 'Centro'),
(3, 'Mendoza', 'Mendoza', 'Cuyo'),
(4, 'Córdoba', 'Córdoba', 'Centro');

-- 2. Insertar Productos
INSERT INTO Productos (id_producto, Categoría, Descripción, Costo, Precio) VALUES
(1, 'Computación', 'Laptop Pro 15', 800.00, 1200.00),
(2, 'Accesorios', 'Mouse Inalámbrico', 15.00, 28.00),
(3, 'Computación', 'Monitor 4K 27"', 300.00, 450.00),
(4, 'Audio', 'Auriculares BT Pro', 70.00, 120.00),
(5, 'Almacenamiento', 'SSD Externo 1TB', 80.00, 130.00),
(6, 'Accesorios', 'Teclado Mecánico', 50.00, 95.00);

-- 3. Insertar Clientes
INSERT INTO Clientes (id_cliente, id_territorio, Fecha_Registro, Email, Nombre_cliente, [Tipo de cliente]) VALUES
(1, 1, '2025-01-05', 'maria@mail.com', 'María López', 'B2C'),
(2, 4, '2025-01-10', 'carlos@mail.com', 'Carlos Ruiz', 'B2B'),
(3, 2, '2025-02-01', 'ana@mail.com', 'Ana Gómez', 'B2C'),
(4, 3, '2025-02-15', 'pedro@mail.com', 'Pedro Sanz', 'B2C'),
(5, 1, '2025-03-01', 'laura@mail.com', 'Laura Torres', 'B2B');

-- 4. Insertar Ventas
INSERT INTO Ventas (id_venta, id_producto, id_cliente, Canal, Fecha_venta, Total_venta) VALUES
(1,  1, 1, 'Online', '2026-03-05', 2400.00),
(2,  2, 2, 'Físico', '2026-03-06', 140.00),
(3,  3, 3, 'Online', '2026-03-07', 450.00),
(4,  4, 1, 'Físico', '2026-03-08', 240.00),
(5,  5, 4, 'Online', '2026-03-10', 390.00),
(6,  6, 2, 'Online', '2026-03-11', 380.00),
(7,  1, 5, 'Físico', '2026-03-12', 1200.00),
(8,  2, 3, 'Online', '2026-03-13', 224.00),
(9,  4, 4, 'Físico', '2026-03-14', 120.00),
(10, 3, 5, 'Online', '2026-03-15', 900.00);
GO

-- ============================================================================
-- VERIFICACIÓN DE DATOS (Consultas de Validación)
-- ============================================================================
SELECT * FROM Territorio;
SELECT * FROM Productos;
SELECT * FROM Clientes;
SELECT * FROM Ventas;
GO