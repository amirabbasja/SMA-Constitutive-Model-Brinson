import pandas as pd

data = pd.read_excel("./Data1.xlsx")
df = pd.DataFrame(columns = ["X", "Y"])
data.set_axis(["X", "Y"],axis=1,inplace=True)
data["Size"] = (data["X"]**2+data["Y"]**2)**.5
df = df.append(data.iloc[data.idxmin()], ignore_index=False)
print(df)




