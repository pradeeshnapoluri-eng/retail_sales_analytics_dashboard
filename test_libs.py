import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression

print("pandas:", pd.__version__)
print("numpy:", np.__version__)
print("sklearn: OK")

X = [[1], [2], [3]]
y = [100, 200, 300]
model = LinearRegression()
model.fit(X, y)
print("Model trained:", model.predict([[4]]))