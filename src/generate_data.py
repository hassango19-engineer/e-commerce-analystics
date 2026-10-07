from pathlib import Path
import numpy as np

import pandas as pd


# Reproductibilité
np.random.seed(42)


# ==========================================
# Création des dossiers
# ==========================================

Path("data/raw").mkdir(parents=True, exist_ok=True)


# ==========================================
# CLIENTS
# ==========================================

customers = pd.DataFrame({
    "customer_id": range(1, 101),

    "name": [
        f"Client_{i}"
        for i in range(1, 101)
    ],

    "age": np.random.randint(
        18,
        70,
        100
    ),

    "city": np.random.choice(
        [
            "Paris",
            "Lille",
            "Lyon",
            "Marseille",
            "Bordeaux"
        ],
        100
    )
})


# Quelques valeurs manquantes
customers.loc[5, "city"] = None
customers.loc[25, "city"] = None


# ==========================================
# PRODUITS
# ==========================================

products = pd.DataFrame({
    "product_id": range(1, 21),

    "product_name": [
        f"Produit_{i}"
        for i in range(1, 21)
    ],

    "category": np.random.choice(
        [
            "Electronics",
            "Clothing",
            "Home",
            "Sports"
        ],
        20
    ),

    "price": np.random.randint(
        10,
        500,
        20
    )
})


# ==========================================
# COMMANDES
# ==========================================

orders = pd.DataFrame({
    "order_id": range(1, 501),

    "customer_id": np.random.randint(
        1,
        101,
        500
    ),

    "product_id": np.random.randint(
        1,
        21,
        500
    ),

    "quantity": np.random.randint(
        1,
        6,
        500
    ),

    "order_date": pd.date_range(
        start="2025-01-01",
        periods=500,
        freq="D"
    )
})


# ==========================================
# PAIEMENTS
# ==========================================

payments = pd.DataFrame({
    "order_id": range(1, 501),

    "payment_method": np.random.choice(
        [
            "Card",
            "PayPal",
            "Bank Transfer"
        ],
        500
    ),

    "payment_status": np.random.choice(
        [
            "Paid",
            "Pending",
            "Failed"
        ],
        500,
        p=[0.85, 0.10, 0.05]
    )
})


# ==========================================
# Export CSV
# ==========================================

customers.to_csv(
    "data/raw/customers.csv",
    index=False
)

products.to_csv(
    "data/raw/products.csv",
    index=False
)

orders.to_csv(
    "data/raw/orders.csv",
    index=False
)

payments.to_csv(
    "data/raw/payments.csv",
    index=False
)


print("Les fichiers ont été créés avec succès.")