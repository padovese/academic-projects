#Colunas não necessárias foram limpadas manualmente 
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
%matplotlib inline
dataframe = pd.read_csv("../NYPD_Complaint_Data_Historic.csv")
population = pd.read_csv("../Population_by_Borough_NYC.csv")

#Criação de função para limpeza de outliers
dataframe2 = dataframe.copy()
def limpa_dado(x):
    if x[2] > '2050':
        x = None
    elif x[2] < '2010':
        x = None
    else:
        aa= '/'.join(x)
        return (aa)

#deleta datas nulas, cria lista, concatena campos de data e hora e seta index
dataframe2 = dataframe2.join(dataframe2['LAW_CODE'].str.get_dummies()) 
dataframe2.dropna(subset=['CMPLNT_FR_DT'], inplace=True)
dataframe2['CMPLNT_FR_DT'] = dataframe2['CMPLNT_FR_DT'].str.split("/")
dataframe2['CMPLNT_FR_DT'] = dataframe2['CMPLNT_FR_DT'].apply(lambda x: limpa_dado(x))
dataframe2['Date_OCCRD'] = dataframe2['CMPLNT_FR_DT'] +' '+dataframe2['CMPLNT_FR_TM']
dataframe2['Date_OCCRD'] = pd.to_datetime(dataframe2['Date_OCCRD'])
dataframe2.set_index('Date_OCCRD', inplace=True)

#Queries reutilazadas da etapa anterior foram reaproveitadas para geração de gráficos de ano e mes
Graficos...

#Regressão Linear em 
features = dataframe['X_COORD_CD', 'Y_COORD_CD', 'Latitude', 'Longitude', 'Lat_Lon']
target = dataframe[['qtde']]

from sklearn import linear_model
from sklearn.model_selection import ShuffleSplit
from sklearn.model_selection import cross_val_score

reg = linear_model.LinearRegression()
cv = ShuffleSplit(n_splits=4, test_size=0.3, random_state=0)
cross_val_score(reg, features, target, cv=cv)
#array([ 0.04551513,  0.07027908,  0.07190979, -0.22396064])

reg = linear_model.Ridge (alpha = .5)
cv = ShuffleSplit(n_splits=4, test_size=0.3, random_state=0)
cross_val_score(reg, features, target, cv=cv)
#array([ 0.04551785,  0.0702728 ,  0.07190189, -0.22380459])

#Cluesterização
from sklearn.cluster import KMeans
import numpy as np
import pickle

try:
    kmeans = pickle.load(open("source_kmeans.pickle", "dataframe2"))
except:
    kmeans = KMeans(n_clusters=20, random_state=0).fit(dataframe[['pickup_longitude','pickup_latitude']])
    pickle.dump(kmeans, open('source_kmeans.pickle', 'dataframe2'))

try:
    destkmeans = pickle.load(open("dest_kmeans.pickle", "dataframe2"))
except:
    destkmeans = KMeans(n_clusters=20, random_state=0).fit(dataframe[['longitude','latitude']])
    pickle.dump(destkmeans, open('dest_kmeans.pickle', 'wb'))


#Plota mapa preditivo
import matplotlib.pyplot as plt
fig, ax = plt.subplots(ncols=1, nrows=1,figsize=(12,10))
plt.ylim(destkmeans['longitude'])
plt.xlim(destkmeans['latitude'])
ax.scatter(dataframe2['longitude'],dataframe2['latitude'], s=0.0002, alpha=1)