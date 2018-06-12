\copy corp.customer FROM 'data/table_customer.csv'( FORMAT CSV, DELIMITER(","));
\copy corp.inventory FROM 'data/table_inventory.csv'( FORMAT CSV, DELIMITER(","));
\copy corp.product FROM 'data/table_product.csv'( FORMAT CSV, DELIMITER(","));
\copy corp.sales FROM 'data/table_sales.csv'( FORMAT CSV, DELIMITER(","));
\copy corp.store FROM 'data/table_store.csv'( FORMAT CSV, DELIMITER(","));
