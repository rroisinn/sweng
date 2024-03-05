from sklearn.feature_extraction.text import TfidfVectorizer #TF-> term frequency used for calculating similarities in texts
from sklearn.metrics.pairwise import linear_kernel
import pandas as pd

"""RECOMMENDATION ALGORITHM USING DATA FROM WEBSCRAPING"""
#build a text, content based recommendation algorithm using word similarities in the name of products
#using libraries/functions, remove unimportant text, find cosine similarities, make recommendations
#remove english stop words eg. and, in, but etc.

asos_df = pd.read_csv('data.csv')

tfidf = TfidfVectorizer(stop_words='english')#remove unimportant words

asos_df['name'] = asos_df['name'].fillna("") #fill any empty strings so it does not affect the recommendations

#build vector space model, for each product data
tfidf_matrix = tfidf.fit_transform(asos_df['name'])
#cosine similarity, reference each product with another, pairwise similarity checking
cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)
indices = pd.Series(asos_df.index, index = asos_df['name']).drop_duplicates() #used to get product name and indec pair groupings

def get_recommendation(name, cosin_sim = cosine_sim):
    """
    Recommendation Algorithm that takes in a product name/ description of product and uses a cosine similarities matrix to find recommendations/ similar items

    """
    index = indices[name]
    #get pairwise similarity scores for all products against the given product
    sim_score = enumerate(cosin_sim[index]) #returns product index and similarity score based on given product name/index
    #sort for the products with highest similarities
    sim_score = sorted(sim_score, key=lambda x: x[1], reverse=True) #sort based on the similarity scores not based on indexes!, reverse to find the highest similarities
    sim_score = sim_score[1:2] #ignore the first recommendation (it just recommends itself), then list top ten recommendations
    sim_index = [i[0] for i in sim_score ] #list of index of top ten recommendations
    print(sim_index) #MAYBE ONLY RETURN INDEX LIST AND USE THAT LATER TO DISPLAY RECOMMENDED ITEMS??
    for product in sim_index[::-1]:
        print(asos_df['name'][product],'\n', asos_df['brand'][product], '\n', asos_df['price'][product],'\n', asos_df['image'][product], '\n',asos_df['link'][product]) #locate the names using indexes
    