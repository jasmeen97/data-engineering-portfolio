-- 1) Date Dimension
CREATE TABLE IF NOT EXISTS dim_date (
  date_id      DATE PRIMARY KEY,
  day          TINYINT,       -- 1–31
  month        TINYINT,       -- 1–12
  year         SMALLINT,      -- 2020, 2021, etc.
  weekday      VARCHAR(10),   -- 'Monday', 'Tuesday', etc.
  quarter      TINYINT        -- 1–4
);

-- 2) Store Dimension
CREATE TABLE IF NOT EXISTS dim_store (
  store_id       INT PRIMARY KEY,
  store_type     VARCHAR(20),
  store_size     INT,
  city           VARCHAR(50),
  state          VARCHAR(50),
  -- …any other metadata from store.csv
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3) Fact Table: Daily Sales
CREATE TABLE IF NOT EXISTS fact_sales (
  sale_id        BIGINT AUTO_INCREMENT PRIMARY KEY,
  store_id       INT,
  sale_date      DATE,
  total_sales    DECIMAL(12,2),
  units_sold     INT,
  avg_price      DECIMAL(8,2),  -- optional: total_sales / units_sold
  CONSTRAINT fk_sales_store FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
  CONSTRAINT fk_sales_date  FOREIGN KEY (sale_date) REFERENCES dim_date(date_id)
);

-- 4) Forecast Table
CREATE TABLE IF NOT EXISTS store_forecasts (
  forecast_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
  store_id       INT,
  forecast_date  DATE,
  predicted_sales DECIMAL(12,2),
  generated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_forecast_store FOREIGN KEY (store_id) REFERENCES dim_store(store_id)
);
-- SQL schema definitions
