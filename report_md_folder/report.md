
<p align="center">
    <img src="SWENG.png" alt="SWENG">
</p>

## <span style="color:deeppink;">Overview</span>

Sweng is an innovative mobile application poised to disrupt the fashion retail market by merging the intuitive swipe mechanics popularised by dating apps with a powerful shopping and recommendation platform. Designed with a "Tinder-style" user interface, Sweng offers a fresh take on online clothing shopping, allowing users to quickly swipe through an array of fashion items, swiping right to add them to their wishlist, and left to pass.

Upon signing up, users are prompted to select their style preferences, which Sweng's algorithm uses to curate a personalised fashion feed. This bespoke experience is further refined with each swipe, as the app learns from the user's choices, continually honing its recommendations. The wishlist serves not just as a collection of favoured items, but also as the foundation for a sophisticated recommendation algorithm that suggests new pieces and styles, tailored to the user's tastes.

Sweng's core objective is to streamline the online shopping experience, making it more engaging and personalised. The app's convenience is heightened by direct links to purchase items, simplifying the transition from discovery to purchase. This feature ensures that users are only a few taps away from owning their next favourite piece of clothing.

In the current e-commerce landscape, Sweng stands out with its unique combination of simplicity, personalization, and direct purchasing links. As users interact with the app, their swiping patterns yield valuable data, enabling Sweng to continuously refine its algorithms, and ensuring that the user's feed remains relevant and engaging. 

Moving forward, Sweng is positioned to become an essential tool for fashion-forward consumers and a valuable partner for retailers seeking to captivate and convert an engaged audience.Through  continuous algorithmic refinement, and an unwavering commitment to user experience, Sweng aims to redefine how consumers discover and purchase fashion online.

![SWENG](design_1.png)

## <span style="color:deeppink;">Concept Development</span>
The development of Sweng aimed to simplify and enhance the online shopping experience using the familiar mechanics of dating apps. In an era where consumer attention spans are short and the desire for instant gratification is high, the goal of Sweng is to combine the convenience of online shopping with the addictive, fun element of swiping through options.

### <span style="color:hotpink;">Ideation Phase</span>
The ideation phase revolved around the central question: How do we create an app that incorporates continuous recommendation and user-interactive swiping? The answer lay in the development of an application that utilised a swipe functionality to allow users to quickly navigate through clothing options. A 'right swipe' would indicate interest and save the item to a wishlist, while a 'left swipe' would dismiss it, thus offering a streamlined, binary decision-making process.

### <span style="color:hotpink;">User-Centric Design</span>
The design phase placed heavy emphasis on user engagement. Sweng’s interface was crafted to be minimalist yet functional, ensuring that the focus remained on the fashion items themselves. This design philosophy extended to the app’s signup process, which was made straightforward and inviting. New users would be greeted by a series of style preference choices, which immediately immerse them in the personalisation experience that Sweng offers. 

## <span style="color:deeppink;">Design Process</span>
The design process of Sweng, a sophisticated fashion shopping app, was centred around creating a seamless, user-friendly experience that offers a set of rich features. Here’s how the app was designed from the ground up

### <span style="color:hotpink;">Technical Architecture</span>
The Technical Architecture of our app is designed to separate concerns into distinct layers and use appropriate technologies for each, this allows for modularity, scalability and maintainability. The architecture is designed to facilitate efficient data flow, responsive user experience and communication between components.

**Presentation layer (Frontend)** - this layer is responsible for presenting the user interface (UI) to the app users, the Flutter frontend serves as the presentation layer, handling user interactions, displaying data and providing a seamless user experience, this layer interacts with the backend layer to request and receive data.

**Application layer (Backend)** - this layer contains the implementation logic of our app and processes the requests received from the frontend, the Python backend hosted on PythonAnywhere serves as the application layer, it handles tasks like web scraping, data processing, recommendation algorithm and serving API endpoints to communicate with the Frontend.

**Data layer (database)** - this layer manages the storage and retrieval of data used by the application. The database hosted by PythonAnywhere serves as the data layer, it stores the collected data obtained through web scraping and provides this data for processing and retrieval by the backend server.

These layers of the Technical Architecture work together to enable the functionality of SWENG.


![Technical architecture](SWENG_tech_arch.png)

### <span style="color:hotpink;">Recommendation Algorithm Development</span>
A pivotal aspect of Sweng's concept development was the creation of a sophisticated algorithm capable of learning and evolving with each user interaction. The app’s engine was designed to analyse swipes, wishlist additions, and purchase history to refine and personalise the product feed. This continuous learning process ensures that users remain engaged with the content that is most relevant to them, increasing the likelihood of purchase conversions.

The heart of Sweng lies in its custom-built recommendation algorithm. Designed to mimic the intuitive and engaging experience of dating apps, Sweng's algorithm uses machine learning to analyse user interactions—swipes, likes, wishlist additions—and tailor the shopping experience to individual tastes. 
When building the recommendation algorithm we researched various machine learning libraries in Python that could be used for building recommendation systems. Also researched the different types of recommendation systems like content-based,collaborative-filtering and hybrid systems. The main functionality of our recommendation algorithm was to be given information about the items that a user likes and then recommend something similar, this was done using a Python library called scikit-learn, which used things like term frequency and cosine similarity of terms used to describe an item to find other items that were similar to it, it then returned the recommended item in JSON format.



    from sklearn.feature_extraction.text import TfidfVectorizer #TF-> term frequency used for calculating similarities in texts
    from sklearn.metrics.pairwise import linear_kernel

    #preprocess data
    asos_df = pd.read_csv('data.csv')
    tfidf = TfidfVectorizer(stop_words='english')#remove english stop words eg. and, in, but etc.
    #build vector space model, for each product in the asos dataframe
    tfidf_matrix = tfidf.fit_transform(asos_df['name'])
    #cosine similarity, reference each product with another for pairwise similarity checking
    cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix) #linear kernel is a mathematical function used to measure the similarity between two things
    indices = pd.Series(asos_df.index, index = asos_df['name']).drop_duplicates() #used to get product name and index pair groupings
    #use indices in recommendation alg. function to find recommendations based on product details

By continuously learning from user behaviour, the algorithm refines its suggestions, making each user's feed more personalized over time.

### <span style="color:hotpink;">Server and Backend</span>
The backend of Sweng is hosted on PythonAnywhere, a cloud service platform that allows for easy Python web app hosting. This choice was made for its simplicity and effectiveness in deploying Python applications quickly. The server-side logic is implemented in Python, taking advantage of its rich ecosystem, including libraries for machine learning, data processing, and API development.
The logic behind the app is hosted on the server(backend) and it serves API endpoints for the frontend to interact with.

    https://sweng1.pythonanywhere.com/
    https://sweng1.pythonanywhere.com/recommend/[product data]
    https://sweng1.pythonanywhere.com/random

### <span style="color:hotpink;">Data Collection</span>
In the process of developing our app, data collection played a pivotal role in providing relevant content for the execution of our fashion-related app. 
When collecting fashion-related data for the app we chose to use Python due to its various libraries for web scraping, such as Beautiful Soup, scrapy, selenium and requests. Initially,we  tried using BeautifulSoup and Selenium to extract the data but unfortunately, we were met with blockers that prevented access to the data that was needed. Eventually,we used the requests-html library which allowed us to simulate HTTP requests, and parse the content to extract what was needed.


    response = requests.get('https://www.asos.com/api/product/search/v2/categories/27108', headers=headers, params=params)
    result_json = response.json() #json object containing webscraped data
    
We decided it was best to utilize web scraping to extract fashion-related data from an e-commerce website(ASOS). The data extraction process was executed on our server, the data was then processed and stored in a database on the server. Upon extraction the data was filtered and processed to ensure it was suitable for integration with our app which was built using Flutter, this integration ensured that our app could dynamically access and display up-to-date fashion content. 

### <span style="color:hotpink;">Database Management with MySQL</span>
Sweng’s data storage solution utilizes MySQL, a robust and reliable relational database management system. MySQL stores user profiles, product information, wishlist data, and interaction logs. This choice supports complex queries and scales well with the growing amount of data, crucial for the app’s learning algorithms and for providing a fast, responsive user experience. 

The database utilized in the system is supported by the database_helper.dart file. This file is comprised of classes and related functions that provide a consistent and robust structure for SQL fetch and insert statements. Each table in the database is initialized and has its columns defined in the initDatabase() function. This method is called in the main.dart file, and other relevant dart files, to facilitate insertion and fetching according to the needs of the application i.e. in terms of signups/preferences. In initDatabase() each table is created using a standard ‘CREATE’ statement, with relevant keys being connected using FOREIGN KEY where necessary e.g. between the wishlist and users tables. 

With Flutter, migrations through database versions must be performed each time a new table is introduced. In the case of our application, no migrations were needed for the ‘users’ as it was the first table to populate the DB but upgrades were necessary for ‘wishlist’ and ‘preferences’. Upgrade functions use an ‘ALTER’ statement and check for the current version number to perform the migration. 

There are INSERT methods for each table along with User and Preference classes that are used as objects when adding to the DB. In turn, there are get methods for users, preferences and the wishlist that query the database based on IDs and usernames. 
There is added security through the use of prepared SQL statements. They are structured using ‘?’ fields rather than inserting straight from the parameter of the function to the database. This avoids the risk of a ‘DROP TABLE’ statement from disrupting the tables in the DB. 

### <span style="text-decoration: underline; color:hotpink;">Level 0 Data Flow Diagram</span>
![Data Flow Level 0](SWENG_level0_data_flow.png)

### <span style="text-decoration: underline; color:hotpink;">Level 1 Data Flow Diagram</span>
![Data Flow Level 1](SWENG_level1_data_flow.png)

### <span style="color:hotpink;">Front End Development with Flutter</span>
The frontend of Sweng was developed using Flutter, Google's UI toolkit for crafting natively compiled applications for mobile, web, and desktop from a single codebase. It allows Sweng to offer a smooth, aesthetically pleasing user experience across iOS and Android platforms.

Flutter supports development in Dart, a client-optimised language for fast apps on any platform. Dart’s features—such as hot reload, a rich standard library, and strong UI-oriented features—make it an ideal choice for Sweng’s development.


#### <span style="color:lightpink;">Key Features</span>
1. **Interactive Card Swiping**: Users can swipe left, right or down to indicate their preference for candidate items.
2. **Dynamic Data Loading**: Candidate items are fetched dynamically from a remote API, on our server, ensuring fresh content for users.
3. **User Engagement**: Users can interact with candidate items by tapping on them to view details or add them to their wishlist.
4. **Local Database**: User preferences and wishlist items are stored locally, providing seamless access across sessions.

![Sequence Diagram 2](SWENG_sequence_2.png)

#### <span style="color:lightpink;">Application Flow</span>
The Flutter application offers a seamless user experience with the following flow:

1. **Authentication**: Users are directed to the login page upon launching the app. If they have no account they can navigate to the sign up page. This allows them to create a new account and then add their preferences. 
2. **Navigation**: After authentication, users navigate to the example page where they can interact with candidate items.
3. **Data Fetching**: Candidate data is fetched dynamically from a remote API, on our server, using HTTP requests.
4. **User Interaction**: Users can swipe through candidate items, view details, and add items to their wishlist.
5. **Persistence**: User preferences and wishlist items are stored locally in a database for future sessions.

![Finite State Machine](SWENG_finite_state.png)

We will go into how we implemented these in more detail:

##### <span style="text-decoration: underline;color:pink;">1. Authentication: Implementing Login and Signup Functionality</span>

 There are three pages used for Authentication, login.dart, signup.dart and preference.dart. 

 **Login Page:**

 The login page is the entry point for users to access the application. It provides a simple yet essential interface where users can authenticate using their email and password. Upon launching the app, users are directed to the login page. If they don't have an existing account, they are given the option to navigate to the signup page to create a new account.

    class _LoginPageState extends State<LoginPage> {
     final TextEditingController emailController = TextEditingController();
     final TextEditingController passwordController = TextEditingController();
     final DatabaseHelper databaseHelper = DatabaseHelper();
    
    
     String errorMessage = '';

It works by initializing  TextEditingController objects for handling email and password input fields. It also initializes a DatabaseHelper object for interacting with the database. errorMessage is a variable used to store and display error messages related to authentication. 

    MaterialButton(
     onPressed: () async {
       // Get user input
       String email = emailController.text;
       String password = passwordController.text;
       // Validate user credentials
       User? user = await databaseHelper.getUser(email);
       if (user != null && user.password == password) {
         // Navigate to home page if authentication is successful
    	Navigator.pushNamed(
                       context,
                       Example.routeName,
                       arguments: user,
                     );
    
    
       } else {
         // Authentication failed
         setState(() {
           errorMessage = 'Incorrect username or password';
         });
       }
     },

This button is responsible for handling the main login process and authentication. It retrieves the email and password entered by the user using the controller. It validates the user's credentials by querying the database using the databaseHelper. If the credentials are correct, it navigates to the home page. If the credentials are incorrect, it updates the errorMessage variable to display an error message.

**Signup Page:**

The signup page is implemented in the same way as the login page, however it has extra functionality for validating users and adding new users to the database. 

    MaterialButton(
                     minWidth: double.infinity,
                     height: 60,
                     onPressed: () async {// Get user input
                         String email = emailController.text;
                         String password = passwordController.text;
                         String confirmPassword = confirmPasswordController.text;
    
    
                         // Validate email format
                         Pattern pattern= r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                         RegExp regex = new RegExp(pattern.toString());
                         if (!regex.hasMatch(email)) {
                           // Handle invalid email format
                           setState(() {
                             errorMessage = 'Please enter a valid email';
                           });
                           return;
                         }
                         // Validate input
                         if (password != confirmPassword) {
                           // Handle password mismatch
                           // Authentication failed
                           setState(() {
                           errorMessage = 'passwords do not match';
                       });
                           return;
                         }
                         // Validate password format
                         Pattern pattern2 =
                             r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()-+]{8,}$';
                         RegExp regex2 = new RegExp(pattern2.toString());
                         if (!regex2.hasMatch(password)) {
                           // Handle invalid password format
                           setState(() {
                             errorMessage = 'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one special character and one number';
                           });
                           return;
                         }
                         // Check if the user already exists
                         User? existingUser = await databaseHelper.getUser(email);
                         if (existingUser != null) {
                           // Handle existing user
                           setState(() {
                           errorMessage = 'user already exists';
                       });
                           return;
                         }
                         // Create a new user
                         User newUser = User(username: email, password: password);
                         // Insert the user into the database
                         await databaseHelper.insertUser(newUser);
                        // navigate to the preference page
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => const BubblePage(), settings: RouteSettings(
                                       arguments: newUser.username,
                             ),
                           ),
                         );
                       },

This button is responsible for handling the sign-up process. It retrieves the email, password, and confirm password entered by the user. It validates the email format, password format, and checks if the passwords match. It validates the format using regex and if there is incorrect format it displays an error message to the user. It also checks if the user already exists in the database. If all validations pass, it creates a new user and inserts it into the database. It then navigates to the preference page if sign-up is successful.

**Preference Page:**

Upon signup, users are prompted to select their fashion preferences, which the app uses to curate the initial product feed.


    class _BubblePageState extends State<BubblePage> {
     final Set<String> _selectedIndices = {};
     String errorMessage = '';
     late String user;
     int max = 4;
     List<String> styles = [
       'Dress',
       'Skirt',
       'Jeans',
       'Jacket',
       'Bikini',
       'Maxi Dress',
       'Crop Top',
       'Jumper',
       'Trouser',
       'Blazer'
     ];

The state class `_BubblePageState` manages the state for the `BubblePage` widget. It initializes variables to track the selected clothing styles, error messages, the current user, and the maximum number of styles the user can select. `styles` is a list of available clothing styles to choose from.



                       (index) => GestureDetector(
                         onTap: () {
                           setState(() {
                             if (_selectedIndices.contains(styles[index])) {
                               _selectedIndices.remove(styles[index]);
                               max += 1;
                             } else {
                               if (max > 0) {
                                 _selectedIndices.add((styles[index]));
                                 max -= 1;
                               } else {
                                 debugPrint("Too many");

This build method generates a list of selectable clothing styles as containers. Each container is wrapped in a `GestureDetector` to detect taps. Tapping on a style toggles its selection status. The style's container changes color based on whether it's selected or not. This allows the user to visually select their preferences.

    ElevatedButton(
                 onPressed: () async {
                   // Handle button press
                   List<String> myList = _selectedIndices.toList();
                   if (myList.length != 4) {
                     // If list size is not equal to 4, set error message
                     setState(() {
                       errorMessage = "Please pick 4 styles";
                     });
                     return;
                   } else {
                     final DatabaseHelper databaseHelper = DatabaseHelper();
                     Preference pref = Preference(
                       username: user,
                       preference1: myList[0],
                       preference2: myList[1],
                       preference3: myList[2],
                       preference4: myList[3],
                     );
                     await databaseHelper.insertPref(pref);
                     User? user1 = await databaseHelper.getUser(user);
                     Navigator.pushNamed(
                       context,
                       Example.routeName,
                       arguments: user1,
                     );
                   }
                 },
      // other UI elements

This button is used to proceed to the next step after selecting the clothing styles. It is disabled if the user hasn't selected exactly 4 styles. Once enabled, it adds the preferences to the preference table, using the database helper,  which is then linked to the user table on ID. This makes sure the user and their preferences are linked. It then navigates to the main page

##### <span style="text-decoration: underline;color:pink;">2. Navigation: Navigating the UI</span>

The main page of our application includes the Cards being displayed to the user and the ability to interact with these cards. This is all done using the card swiping package for flutter. There are two pages used for this, the example page which builds the entire main page and the example_card which builds the individual candidate cards and the details page.

**Example Page:**

    class _ExamplePageState extends State<Example> {
     final CardSwiperController controller = CardSwiperController();
     int currentIndex = 0;
    
    
     late Future<List<ExampleCandidateModel>> futureCandidates;
     late List<ExampleCandidateModel> candidates; // Define candidates here
      @override
     void initState() {
       super.initState();
       futureCandidates = fetchData();
       candidates = [];
      
     }
       @override
     void dispose() {
       controller.dispose();
       super.dispose();
     }

`_ExamplePageState` is the state class for the Example widget. It manages the state of the widget. The main card swiper functionality is implemented using the __flutter card swiper package__.  It initializes a CardSwiperController named controller for controlling the card swiper. It initializes currentIndex to keep track of the index of the currently displayed card. In initState, it initializes futureCandidates by calling the fetchData function and initializes candidates as an empty list. It overrides the dispose method to dispose of the controller when the state is disposed of.

**`build` Method**

    @override
     Widget build(BuildContext context) {
       final User? user1 = ModalRoute.of(context)?.settings.arguments as User?;
      
       return Scaffold(
    	// returns UI elements for the main example page
             
         body: SafeArea(
          
           child: FutureBuilder<List<ExampleCandidateModel>>(
             future: futureCandidates,
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting ) {
                 return const Center(child: CircularProgressIndicator());
               } else if (snapshot.hasError) {
                 return Center(child: Text('Error: ${snapshot.error}'));
               } else {
                 candidates = snapshot.data ?? [];
                 return _buildCardSwiper(candidates);
                
             }
           },
         ),
       ),
     );
    }

This method builds the UI for the page. It returns a `Scaffold` widget, which provides the overall structure for the page, including the app bar and body. In the app bar, it displays the logo, share button, wishlist button, and account button to navigate to other pages. To combat the problem of the UI trying to build its tree before it has fetched all the data for our list,  we use a FutureBuilder widget.  The `FutureBuilder` widget, asynchronously builds a widget tree based on the latest snapshot of interaction with a `Future`. If the future is still loading, it shows a circular progress indicator. If there's an error, it displays an error message. Otherwise, it builds the card swiper widget using `_buildCardSwiper` method.

**`_buildCardSwiper` Method**

    Widget _buildCardSwiper(List<ExampleCandidateModel> candidates) {
       return Column(
         children: [
           Flexible(
             child: CardSwiper(
               controller: controller,
               cardsCount: candidates.length,
               onSwipe: _onSwipe,
               onUndo: _onUndo,
               numberOfCardsDisplayed: 3,
               backCardOffset: const Offset(40, 40),
               padding: const EdgeInsets.all(15.0),
               cardBuilder: (
                 context,
                 index,
                 horizontalThresholdPercentage,
                 verticalThresholdPercentage,
               ) =>
                   ExampleCard(candidates[index]),

This method constructs the card swiper widget. It returns a `Column` widget containing the card swiper and action buttons. The card swiper is implemented using a `CardSwiper` widget, from the __card swiper package__, which is fed with data from the `candidates` list. Below the card swiper, it displays action buttons for swiping left, swiping right, and undoing the swipe action.

**Example_card:**

This page Implements the UI for displaying the individual candidate cards. It uses the candidate model to display different information about an item to the user such as, name, brand, price. It also contains a button allowing the user to open the item in the original store. 

    class ExampleCandidateModel {
     final String name;
     final String image;
     final String link;
     final String price;
     final String brand;
    
    
     ExampleCandidateModel({
       required this.name,
       required this.image,
       required this.link,
       required this.price,
       required this.brand,
     });

This class represents a model for candidate items. It has five properties: name, image, link, price, and brand, all of which are required. The constructor ExampleCandidateModel initializes these properties when an object of this class is created. This allows us to store information about each item in an object that can then be stored in a list. These objects are then built into individual cards in the example_candidatemodel.dart page.

    @override
     Widget build(BuildContext context) {
      return Container(
     clipBehavior: Clip.hardEdge,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(10),
       color: Colors.white,
       boxShadow: [
         BoxShadow(
           color: Colors.grey.withOpacity(0.2),
           spreadRadius: 3,
           blurRadius: 7,
           offset: const Offset(0, 3),
         ),
       ],
     ),
     child: Stack(
       fit: StackFit.expand,
       children: [
         Image.network(
           candidate.image,
           fit: BoxFit.cover,
         ),
     // Other UI elements like text and buttons are positioned on top of the image
     ],
              ), 
           ); 
        }

This widget builds the UI for the individual cards. It consists of a container with rounded corners, containing an image and other UI elements positioned on top of the image using a `Stack`. It displays the details from the candidate model such as the image, name, etc, on the card.

**`DetailsPage` Widget:**

    class DetailsPage extends StatelessWidget {
     final ExampleCandidateModel candidate;
     final CardSwiperController? controller;
     // final CardSwiperController controller = CardSwiperController();
    
    
     const DetailsPage({Key? key, required this.candidate, this.controller}) : super(key: key);
      @override
     Widget build(BuildContext context) {
       return Scaffold(
        
         body: CustomScrollView(
           slivers: [
             SliverAppBar(
               expandedHeight: 400.0,
               flexibleSpace: FlexibleSpaceBar(
                 background: Image.network(
                   candidate.image,
                   fit: BoxFit.cover,
    		// Other UI elements like text and buttons are displayed 
    		]
    	)
    }

This method builds the UI for the details page. This is navigated to when a card is __swiped to the top__. 
It uses a `CustomScrollView` with `SliverAppBar` to create a collapsible app bar with a background image. Additional UI elements like text and buttons are displayed using `SliverFillRemaining`.

In summary, `ExampleCard` is a widget for displaying a card representing a candidate item, while `DetailsPage` is a widget for displaying detailed information about a candidate item. Both widgets use the provided `ExampleCandidateModel` object to populate their UI with relevant data.


##### <span style="text-decoration: underline;color:pink;">3. Data fetching: Dynamically Fetching Candidate Data</span>

The `fetchData` method is a crucial part of the application's functionality, responsible for dynamically fetching candidate data from a remote API hosted on our server. This method retrieves information about candidate items, such as their name, image, link, price, and brand, and prepares them for display within the application.

    Future<List<ExampleCandidateModel>> fetchData() async {
     try {
       // Fetch JSON data from the URL
       final response = await http.get(Uri.parse('https://sweng1.pythonanywhere.com'));
       if (response.statusCode == 200) {
         // Parse the JSON data
         final List<dynamic> jsonData = jsonDecode(response.body);
    
    
         // Create a list of ExampleCandidateModel instances
         final List<ExampleCandidateModel> parsedCandidates = jsonData.map((item) {
           return ExampleCandidateModel(
             name: item['name'],
             image: item['image'],
             link: item['link'],
             price: item['price'],
             brand: item['brand'],
           );
         }).toList();
        
         // Retrieve user preferences
         Preference? pref = await getUserPreferences();
        
         // Filter candidates based on user preferences
         final filteredCandidates = parsedCandidates.where((candidate) =>
             candidate.name.toLowerCase().contains(pref!.preference1.toLowerCase()) ||
             candidate.name.toLowerCase().contains(pref.preference2.toLowerCase()) ||
             candidate.name.toLowerCase().contains(pref.preference3.toLowerCase()) ||
             candidate.name.toLowerCase().contains(pref.preference4.toLowerCase())
         ).toList();
    
    
         // Insert filtered candidates to the start of the list
         candidates.insertAll(0, filteredCandidates);
    
    
         // Check if the list size is at least 10
         if (candidates.length < 5) {
           // Fill the remaining slots with additional candidates fetched from the API
           final remainingCandidates = parsedCandidates.where((candidate) => !filteredCandidates.contains(candidate)).toList();
           candidates.addAll(remainingCandidates.take(10 - candidates.length));
         }
    
    
         return candidates;
       } else {
         throw Exception('Failed to load data: ${response.statusCode}');
       }
     } catch (e) {
       print('Error fetching data: $e');
       // Handle the error gracefully, e.g., show a friendly error message to the user
       return []; // Return an empty list if an error occurs
     }
    }

The **fetchData** method is responsible for fetching data from an API endpoint. It returns a Future<List<ExampleCandidateModel>> representing a list of candidate models that will be used in the card swiper by the controller. 

It performs an HTTP GET request to fetch JSON data from the specified URL. To do this it uses the __http flutter package__ which fetches the json data from our server(backend). It parses the JSON data and creates ExampleCandidateModel instances from it. 

Additionally, the method retrieves user preferences using the `getUserPreferences` function, which fetches the preferences from the database based on the current user's username. It then filters the candidate list based on these preferences, ensuring that the displayed items are relevant to the user's interests.This makes sure that the user will never run out of candidates and that the first items they are shown are related to their preferences. 

**Recommendations and Random Items:**

Two additional methods, `fetchAndAddRecommendation` and `fetchAndAddRandom`, are used to fetch recommendations and random items from the API, respectively.

**`fetchAndAddRecommendation` method:**

    String recommendationUrl = 'https://sweng1.pythonanywhere.com/recommend/${candidate.name}';

This method fetches a recommendation for a given candidate item. It constructs the URL for the recommendation API endpoint based on the candidate's name, therefore returning a recommendation based on that candidate. This is the basis of our recommendation function. Each time a card is swiped right a recommendation based on that card is added. 

**`fetchAndAddRandom` method:**

    String randomUrl = 'https://sweng1.pythonanywhere.com/random';

This method is used when a card is swiped left, it fetches random items from an API endpoint.. It sends a GET request to the random items URL on our server and waits for the response. This Url returns a list of random JSON candidates from our server. It parses the JSON data to create `ExampleCandidateModel` instances representing the random items. It checks if each random item is not already in the list of candidates, and if not, it adds the item to the list and updates the UI using `setState`.

These methods collectively ensure a dynamic and engaging user experience by continuously providing fresh candidate data based on user interactions and preferences.

##### <span style="text-decoration: underline;color:pink;">4. User Interaction: Interacting with Candidate Items</span>

![Use-case diagram](SWENG_use_case.png)

User interaction is a critical aspect of the application, allowing users to engage with candidate items by swiping through them, viewing details, and adding items to their wishlist. Let's delve into the various components and methods involved in facilitating this interaction.

**`_onSwipe` method**

    if (direction == CardSwiperDirection.top) {
       // Navigate to the details page when swiped to the top
       _navigateToDetailsPage(candidates[previousIndex!]);
       return false;
     } else if (direction == CardSwiperDirection.left) {
       fetchAndAddRandom();
       controller.swipeLeft(); // Handle left swipe
       if (currentIndex != null) {
         this.currentIndex = currentIndex;
       }
     } else if (direction == CardSwiperDirection.right) {
       fetchAndAddRecommendation(candidates[previousIndex!]);
       addToWishlist(candidates[previousIndex!], user1);
       controller.swipeRight(); // Handle right swipe
       if (currentIndex != null) {
         this.currentIndex = currentIndex;
       }
     }

To implement the main swiping functionality and incorporate the recommendation algorithm we use the onSwipe method. 

This method is invoked when a card in the swiper widget is swiped. It takes the previous index of the card, the current index (which could be null), and the direction of the swipe. Based on the direction of the swipe, it performs different actions:
  - If swiped to the top, it navigates to the details page of the selected item.
  - If swiped to the left, it fetches and adds a **random recommendation**, using the __fetchAndAddRandom__ method, and adds to the list of cards, then handles the swipe left action.
  - If swiped to the right, it fetches a **recommendation**, using the __fetchAndAddRecommendation__ method, and adds the swiped item to the user's wishlist,using the __addToWishlist__ method, then handles the swipe right action.
- It updates the `currentIndex` variable and returns true to indicate that the swipe action was handled.

**`_onUndo` method**

    bool _onUndo(
       int? previousIndex,
       int currentIndex,
       CardSwiperDirection direction,
     ) {
       debugPrint(
         'The card $currentIndex was undid from the ${direction.name}',
       );
       if (currentIndex != null) {
         this.currentIndex = currentIndex;
       }
       return true;
     }

We also implemented an undo function, allowing the user to see a card they have previously swiped away. This method is invoked when the user decides to undo a swipe action.

**`addToWishlist` method**

    void addToWishlist(ExampleCandidateModel candidate, User? user) async {
     // Obtain the user ID from the database or any other source
     if (user != null) {
       final DatabaseHelper databaseHelper = DatabaseHelper();
       // Check if the item is already in the wishlist
       final existingItems = await databaseHelper.getWishlistItems(user.id);
       for (var item in existingItems) {
          if (item == candidate) {
             debugPrint('Item already exists in the wishlist!');
             return;
           }
      
      
       }
       // If the item is not in the wishlist, add it
       databaseHelper.insertWishlistItem(user.id, candidate);
       debugPrint('Item added to wishlist!');
    
    
       }
     }

This method allows a user to add a candidate item to the user's wishlist.This is invoked when a card is swiped right.  It takes the candidate item and the user as parameters, this makes sure the item is being added to that user's wishlist. It accesses the database using the DatabaseHelper. It first checks if the item already exists in the user's wishlist, this combats our earlier issue of the same item being added twice. To do this we had to override the “==’ in the candidate model class.

**== Operator Override:**

    @override
     bool operator ==(Object other) {
       if (identical(this, other)) return true;
    
    
       return other is ExampleCandidateModel &&
           other.name == name &&
           other.image == image &&
           other.link == link &&
           other.price == price &&
           other.brand == brand;
     }

This overrides the == operator to compare two ExampleCandidateModel objects for equality. It checks if the other object is of type ExampleCandidateModel and if all properties of both objects are equal. Making sure no duplicates are added. 

**`_shareContent` Method**

    void _shareContent() {
     // Get the candidate at the specified index
     ExampleCandidateModel candidate = candidates[currentIndex];
      debugPrint('currentIndex: $currentIndex');
     // Generate a unique URL for the card
     String cardUrl = candidate.link;
      // Share the URL
     Share.share('Check out this item I found on SWENG!: \n$cardUrl');
    }

Recognizing the importance of social influence in fashion, Sweng includes a feature to share favorite items. This not only enhances the user experience by integrating social aspects into the app but also serves as organic marketing, drawing new users to Sweng.

The _shareContent method is responsible for sharing the current card's content. This is implemented using the __share flutter package__. It gets the current card's link from the candidate at the currentIndex. It uses the Share.share method to share the item's link. This method displays a share popup on the users device which allows them to share on their desired platform. 

##### <span style="text-decoration: underline;color:pink;">5. Persistence: Storing User Preferences and Wishlist Items</span>

In any application, it's crucial to persist user data across sessions to provide a seamless experience.We store both user preferences and wishlist items locally. This data can be viewed by the user in two pages, the wishlist screen and the account page. Both of these pages are accessed by the top app bar on our application. 

**account_page.dart:**

The AccountPage widget is responsible for displaying user account details and preferences. Let's look at how user preferences are loaded and displayed:

    void loadAccountDetails() async {
       email = widget.user?.username;
       debugPrint('User email: $email');
    
    
       final DatabaseHelper databaseHelper = DatabaseHelper();
       Preference? preference = await databaseHelper.getPref(widget.user!.username);
       if (preference != null) {
         setState(() {
           pref1 = preference.preference1;
           pref2 = preference.preference2;
           pref3 = preference.preference3;
           pref4 = preference.preference4;
         });
         debugPrint('Preferences: $pref1, $pref2, $pref3, $pref4');
       } else {
         debugPrint('Preferences not found.');
       }
     }

In the _AccountPageState class, user preferences are loaded asynchronously in the loadAccountDetails method. The DatabaseHelper class is used to retrieve preferences from the local database based on the user's username. If preferences are found, they are set in the state variables, which are then displayed in the UI.

If the user wants to edit their preferences they can click the edit preferences button which navigates them to the preferences screen where they can update their preferences.

**wishlist_screen.dart:**

This page is used to show the user what items they have saved in their wishlist.  An item is added to their wishlist when they swipe right.

    class _WishlistScreenState extends State<WishlistScreen> {
     late List<ExampleCandidateModel> wishlistItems = [];
    
    
     @override
     void initState() {
       super.initState();
       loadWishlistItems();
     }
    
    
     void loadWishlistItems() async {
       final userId = widget.user?.id;
       debugPrint('User id: $userId');
    
    
       if (userId != null) {
         wishlistItems = await DatabaseHelper().getWishlistItems(userId);
         setState(() {});
       }
     }

This is the state class _WishlistScreenState for the WishlistScreen. It initializes wishlistItems as an empty list. The initState method is overridden to load wishlist items when the screen is initialized. The loadWishlistItems method asynchronously loads wishlist items from the database based on the user's ID.
The UI is updated using setState after loading the items.

    @override
    Widget build(BuildContext context) {
     final user1 = widget.user;
     return Scaffold(
       appBar: AppBar(
         // App bar configuration
       ),
       body: Center(
         child: wishlistItems.isEmpty
             ? const Text('Your wishlist is currently empty.')
             : ListView.builder(
                 // List view for displaying wishlist items
               ),
       ),
     );
    }

The build method returns a Scaffold widget with an app bar and a body. If the wishlist is empty, it displays a message indicating that the wishlist is empty. Otherwise, it displays a ListView.builder to render the wishlist items. 

### <span style="color:hotpink;">Design Styles and UX</span>
The UI design of Sweng adheres to Material Design principles, ensuring a modern, clean, and user-friendly interface. The app's layout is intuitive, with a focus on showcasing products through high-quality images and minimal text, creating an engaging browsing experience.

![design1](design_1.png)
![design2](design_2.png)
![design3](design_3.png)
![design4](design_4.png)
 

## <span style="color:deeppink;">Lessons Learned</span>

Throughout this software project, we've gained valuable insights and lessons that have contributed to our growth as developers and as a team:

1. **Flutter and Dart**: As it was our first time developing an app we learned lots during the process. We delved into Flutter and Dart, Google's powerful toolkit for building cross-platform applications. Through hands-on experience, we learned how to effectively employ Flutter to create a visually appealing and responsive frontend for our application. From our problems and solutions, we learned the advantages and disadvantages of developing using flutter. 

2. **Backend Development**: Backend development taught us the importance of building robust and scalable server-side components to handle data processing, storage, and retrieval efficiently. We gained proficiency in designing and implementing APIs to facilitate communication between the frontend and backend. 

4. **Effective Communication**: Clear and effective communication was crucial to our project's success. We made sure that team members were aligned on project goals, tasks, and timelines. Regular meetings and updates helped us stay on track and address any issues promptly.

6. **Workload Delegation**: Delegating tasks effectively allowed us to distribute workload evenly and capitalise on individual strengths. By assigning tasks based on skill sets and availability, we optimised productivity and ensured timely completion of project milestones.

Overall, our journey through this software project has equipped us with a comprehensive set of skills and experiences, preparing us for future endeavours in software development.

