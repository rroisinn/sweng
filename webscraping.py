#Peace Samuel, 121376141
import requests
import pandas as pd

def webscraping():
    """WEBSCRAPING"""
    #information to collect from webscraping ASOS
    name = []
    brand = []
    price = []
    image_url = []
    product_url = []
    #to webscrape multiple pages in asos
    #144 is 2 pages, 72 items per page
    for i in range(0, 144, 72):
        #use this to bypass any webscraping blocks
        headers = {
            'authority': 'www.asos.com',
            'accept': 'application/json, text/plain, */*',
            'accept-language': 'en-US,en;q=0.9',
            'asos-c-name': '^@asosteam/asos-web-product-listing-page',
            'asos-c-plat': 'web',
            'asos-c-ver': '1.2.0-32a5ccb6e261-10699',
            'asos-cid': '03e78ef9-b888-452b-b901-8289dbe8c8e3',
            'cookie': 'asosAffiliate=affiliateId=17295; browseCountry=IE; s_ecid=MCMID^%^7C46135360209535090952290368007459452106; browseCurrency=EUR; browseLanguage=en-GB; browseSizeSchema=UK; storeCode=ROW; currency=19; featuresId=35dbb65c-bf64-4970-b1c8-fae9a96b39d7; asos-anon12=406b6d7b5b7b4d0e80f2ad4c04a74863; _cs_c=0; _ga=GA1.1.231515634.1706192410; FPID=FPID2.2.z^%^2F53GMaX0q0l^%^2BYZGMM3m^%^2BP3P26oPgctZLvs291^%^2FDb1Y^%^3D.1706192410; OptanonAlertBoxClosed=2024-01-25T14:20:43.807Z; _gcl_au=1.1.798064542.1706192444; bt_stdstatus=NOTSTUDENT; FPAU=1.1.798064542.1706192444; stc-welcome-message=cappedPageCount=2; floor=1000; asos=PreferredSite=&currencyid=19&currencylabel=EUR&customerguid=406b6d7b5b7b4d0e80f2ad4c04a74863&topcatid=1000; geocountry=IE; siteChromeVersion=au=12&com=12&de=12&dk=12&es=12&fr=12&it=12&nl=12&pl=12&roe=12&row=12&ru=12&se=12&us=12; keyStoreDataversion=h7g0xmn-38; ak_bmsc=A6848FF166B36CE11A9C0C22BAF7DF0E~000000000000000000000000000000~YAAQDWJkX6u6pkGNAQAAzNfhRRZg0gElfq77bXcuazKOu02o1oMJnGsza3VMD3kNyJ0geIuvvz8Q+eylwDbe/Jtvy67XXP9JvGTama7wc0kAjPouq4hSPtOVdGtzHmL7713StJbsHJSmT5FGbJ+d7SzuXB7JJ9WjuJzA/3dtoGAjsM3chN2UX1akLRSKDEDuV3wUuWwkE0eK+5MEwpo280Hlq0oFVFJExwpxCrQZyx6QSpiaCoI4gUBQNYRjTMVmhakJ4FNWVTG3U3nCKe9AfPat8j8LKI0puvC9K3Obr+1GIj4GB/n53aAOC261VuBFVQiuM8YJcflI9alHTcc8CfGVc/SR0q2S+J7JfkIjzNHp7BEUPHQzVBf9yg/3uVbn9bn9iA==; asos-b-sdv629=h7g0xmn-38; asos-ts121=0cfb0189718a4e74a686874f25b06549; _abck=ED744908BE0DE75AB9117BD705017E1E~0~YAAQDWJkX1a7pkGNAQAAtdvhRQtyUUqw0Sf9y6myObeJ8WbVt5bbiNhR5YJVf7ztiCKXvL78B9E6k4zk8M/gAarzREESWfp6BZZWxY0gX6aaf82FqE/tKbvgy7IM36th9HSOJNSLxd0BREJwwVirRuSY0QEJQ7ZVUMCOMJIdk0EMXkULqOZFjwp4UBVUlOsRuCZn5i/Kv4iI5/bhhnPSgFuOv9ILRQqZ5MvX6tqanHLAv9dBeCraNZWXrEK/1xwOxyN/QeMs+Ud5kZ8DkKUDaKhdkMMng929RmEy16zN9VHan9M5vp4dQhGmpp0YtRnHtzrLP/6DptH81ot6xeuyVI5MPDRlOalBt1uAQ0TDwrBjPauGfO1RRuZ7VtkX+5t0cRquiOBmi7Ae0a1OJEIf0kBvZ6CcWw==~-1~-1~1706196037; bm_sz=1B6495A422D7427157B1CB7DC636F494~YAAQDWJkX1i7pkGNAQAAtdvhRRb7WroZQEuFl3xYHTFk4ynIJPF5y9LkglbN3ihGEzuTQbcWrFN04FbNMnH4KmdLksLpCIksqON/98EccvNcmOzlFk/v3gDntnvT8pNNRoj/84zu8CUchEAOAmSEDDZDXVM/fgicYAxMMcCCIY1rxalBR059w+7fU0QQfm0wo9ohapNEmSWqgnjzGlD0UxU+QQaJw/U5GUtmOBYJz/vkaqBihRXOltzvneKOgUsa1+0R7YrrSvd0ogDtvAzoaAWpJv3ZEIN4zi2KOhlZrDsVCf1FXlhcNgn748gqQ0X+mkhCJT4SIwHV4gOzXIikv4iZt5w/uNAFVaGaoc3nhM3+cw==~3420230~3291459; bm_sv=4CD1EE27999439A42CE9FF0B49E93E2B~YAAQDWJkX3u7pkGNAQAAZtzhRRb4QkpdBY3WkhuqtrMyt7ldzogDYcd42e9n2xrypnvOREegFsgERrbluUQ3ypB0l06tyXDZWXFqbdVsb41PzT6ZOTiIgPtYtYipAV7P5iHmsupMxshNOjtuwV1XHTo/ofR5dP8oc3OvqaOQH1Y8CfgqofSyPI/4gLdwFcFhxw0qnrpj3MiVIwVYo/CgAQbNUG/NngLZ9uC7EjJe+6hgca/zW7op7IOOeUNzgg==~1; asos-perx=406b6d7b5b7b4d0e80f2ad4c04a74863^|^|0cfb0189718a4e74a686874f25b06549; AMCVS_C0137F6A52DEAFCC0A490D4C^%^40AdobeOrg=1; AMCV_C0137F6A52DEAFCC0A490D4C^%^40AdobeOrg=-1303530583^%^7CMCMID^%^7C46135360209535090952290368007459452106^%^7CMCAAMLH-1706879244^%^7C6^%^7CMCAAMB-1706879244^%^7CRKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y^%^7CMCCIDH^%^7C0^%^7CMCOPTOUT-1706281644s^%^7CNONE^%^7CMCAID^%^7CNONE^%^7CMCSYNCSOP^%^7C411-19755^%^7CvVersion^%^7C3.3.0; _s_fpv=true; s_cc=true; _cs_mk_aa=0.5476124426034852_1706274444844; bt_utmSource=organic_search; FPLC=u8ThP0GUHZv1Hmzm85xGFzA0aDyPVBYAbV^%^2Fexi^%^2FcRhNaJpEewzftqauGJTjp2D3tUFCSnpCVp^%^2Bd9XensATarMM^%^2FVcDIdZXI53DKmH^%^2Bsd^%^2Bh5aZosysNQIPfz7S^%^2Fqf3w^%^3D^%^3D; OptanonConsent=isGpcEnabled=0&datestamp=Fri+Jan+26+2024+13^%^3A17^%^3A49+GMT^%^2B0000+(Greenwich+Mean+Time)&version=202310.2.0&browserGpcFlag=0&isIABGlobal=false&hosts=&consentId=8c1c289e-e484-46a3-ae71-23fdeb77b65b&interactionCount=1&landingPath=NotLandingPage&groups=C0001^%^3A1^%^2CC0003^%^3A1^%^2CC0004^%^3A1&geolocation=IE^%^3BL&AwaitingReconsent=false; s_pers=^%^20s_vnum^%^3D1706745600505^%^2526vn^%^253D2^%^7C1706745600505^%^3B^%^20gpv_p6^%^3D^%^2520^%^7C1706276244448^%^3B^%^20eVar225^%^3D4^%^7C1706276862661^%^3B^%^20visitCount^%^3D2^%^7C1706276862668^%^3B^%^20gpv_e231^%^3Db3920f9a-39e5-4d12-8052-be42ca984662^%^7C1706276869945^%^3B^%^20s_invisit^%^3Dtrue^%^7C1706276869948^%^3B^%^20s_nr^%^3D1706275069950-Repeat^%^7C1737811069950^%^3B^%^20gpv_e47^%^3Dno^%^2520value^%^7C1706276869952^%^3B^%^20gpv_p10^%^3Ddesktop^%^2520row^%^257Ccategory^%^2520page^%^257C27108^%^2520page^%^25202^%^2520refined^%^7C1706276869955^%^3B; _cs_id=d278910c-d9fd-a9c2-8b48-45fb1cf20010.1706192409.3.1706275071.1706274445.1628755191.1740356409150; _cs_s=4.0.0.1706276871379; FPGSID=1.1706274447.1706275073.G-H5HS29D9X2.vTbdIB-_rR_PXjXp8uEb6g; plp_columsCount=twoColumns; _ga_1JR0QCFRSY=GS1.1.1706274445.2.1.1706275188.0.0.0; RT=^\\^z=1&dm=asos.com&si=af1aed5c-5221-4eda-9a02-f80c40f78de8&ss=lrunqvyv&sl=6&tt=jd6&bcn=^%^2F^%^2F02179910.akstat.io^%^2F&ld=ecc0&nu=bd6g28l&cl=h9cn^\\^; s_sq=asoscomprod^%^3D^%^2526c.^%^2526a.^%^2526activitymap.^%^2526page^%^253Ddesktop^%^252520row^%^25257Ccategory^%^252520page^%^25257C27108^%^252520page^%^2525202^%^252520refined^%^2526link^%^253DLOAD^%^252520MORE^%^2526region^%^253Dplp^%^2526pageIDType^%^253D1^%^2526.activitymap^%^2526.a^%^2526.c',
            'referer': 'https://www.asos.com/women/new-in/cat/?cid=27108&ctaref=15offnewcustomer^%^7Cglobalbanner^%^7Cww&page=3',
            'sec-ch-ua': '^\\^Not_A',
            'sec-ch-ua-mobile': '?0',
            'sec-ch-ua-platform': '^\\^Windows^\\^',
            'sec-fetch-dest': 'empty',
            'sec-fetch-mode': 'cors',
            'sec-fetch-site': 'same-origin',
            'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        }

        #offset determines which page, '0'-71=page1, '72'-144=page2 etc.
        params = (
            ('offset', str(i)),
            ('store', 'ROW'),
            ('lang', 'en-GB'),
            ('currency', 'EUR'),
            ('rowlength', '2'),
            ('channel', 'mobile-web'),
            ('country', 'IE'),
            ('keyStoreDataversion', 'h7g0xmn-38'),
            ('limit', '72'),
        )

        response = requests.get('https://www.asos.com/api/product/search/v2/categories/27108', headers=headers, params=params)
        result_json = response.json() #json object
        result_items = result_json['products'] #result items, all products in the new-in section first page
        #extract data and add it to lists based on different types of info
        for result in result_items:
            #extract product names
            name.append(result['name'])
            #extract brand names
            brand.append(result['brandName'])
            #extract prices
            price.append(result['price']['current']['text'])
            #extract image urls, adapt so we can access the images online
            image_url.append("https://" + result['imageUrl'])
            #extract product urls, adapt so we can access the product via link
            product_url.append("https://asos.com/"+result['url'])
        #create pandas dataframe: key, value pairs
        asos_df_ = pd.DataFrame({'Name': name, 'Brand': brand, 'Price': price, 'Image_URL': image_url, 'Product_URL': product_url})
        return asos_df_
    
    asos_data = webscraping()
    asos_data.to_csv('data.csv') #put the data in a file
