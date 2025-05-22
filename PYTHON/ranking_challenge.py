import pandas as pd

# loads your csv file into a DataFrame
print("loading")
df= pd.read_csv("../data/orders.csv")

#it creates sorted version of the dataframe
df_sorted=df.sort_values(by=['customer_id', 'total_amount'], ascending=[True, False])
# assign ranks in the order they appear- avoid ties
df_sorted['rank']=df_sorted.groupby('customer_id')['total_amount'].rank(method='dense',ascending=False).astype(int)

top_orders=df_sorted[df_sorted['rank']<=2]

print(top_orders)