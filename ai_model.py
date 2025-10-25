def train_model():
import joblib
from sklearn.tree import DecisionTreeClassifier
import numpy as np
import sys
import ast

MODEL = 'ai_model.pkl'

def train_and_save():
    X = np.array([[1, 0, 5], [0, 1, 10], [1, 1, 15], [0, 0, 20]])
    y = np.array([0, 1, 1, 0])
    model = DecisionTreeClassifier(max_depth=3)
    model.fit(X, y)
    joblib.dump(model, MODEL)
    return model

try:
    model = joblib.load(MODEL)
except Exception:
    model = train_and_save()

if __name__ == '__main__':
    if len(sys.argv) > 1:
        try:
            arr = ast.literal_eval(sys.argv[1])
            if len(arr) > 3:
                arr = arr[-3:]
            pred = model.predict([arr])[0]
            print(int(pred))
        except Exception:
            print(-1)
    else:
        # default quick test
        print(int(model.predict([[1,0,10]])[0]))
