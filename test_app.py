from flask import Flask, jsonify
import pandas as pd

app = Flask(__name__)

asos_df = pd.read_csv('data.csv')
@app.route('/')
def index():
    """DISPLAY IN THE WEBPAGE THE FIRST ITEM THAT IS IN THE DATA FILE"""
    name_ = asos_df['Name'][0]
    brand_ = asos_df['Brand'][0]
    price_ = asos_df['Price'][0]
    image =  asos_df['Image_URL'][0]
    product_link = asos_df['Product_URL'][0]
    first_product = {
        'name': name_,
        'brand': brand_,
        'price': price_,
        'image': image,
        'link': product_link,
    }
    return jsonify(first_product)


if __name__ == '__main__':
    app.run(debug=True)