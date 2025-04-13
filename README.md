# Arth.ai
A Flutter application that fetches and displays the latest news articles using the NewsAPI. The app features light and dark themes, search functionality, offline caching, and pagination.

<p align="center">
  <img src="https://github.com/user-attachments/assets/984543c2-0cc1-49f4-9da1-04e8a25ce120" alt="IMG_8632" height="400"/>
  <img src="https://github.com/user-attachments/assets/6c547a81-f914-4083-8c02-04756c89d990" alt="IMG_8633" height="400"/>
  <img src="https://github.com/user-attachments/assets/db5608a8-5b34-4af8-98a3-f012f53665ef" alt="IMG_8630" height="400"/>
  <img src="https://github.com/user-attachments/assets/5a9c1795-8dbf-4d5a-9158-f5037457ab2b" alt="IMG_8631" height="400"/>
</p>



---

## 🚀 How to Set Up and Run the Project Locally

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/your-username/arth_ai.git
   cd arth_ai

2. Install Dependencies:
   ```bash
   flutter pub get

3. Set up the .env file:
Create a .env file in the root directory and add:
   ```bash
   NEWS_API_KEY=57f8a53965bc425280ee862d28007014

4. Run the App:
   ```bash
   flutter run

---

🎨 Key Design Decisions Made
- Dark and Light Themes: Dynamically switchable themes to enhance user experience and accessibility.

- Contrasting Colors: Carefully selected to maintain readability across light and dark modes.

- Search History Visibility: Recent search keywords are shown instantly as chips to speed up repeated queries.

- Empty State UI: A clean placeholder UI is shown when the search list is empty, encouraging the user to perform a search.

- Offline Caching: Results of the latest 5 successful online search queries are cached locally and can be accessed without internet.

- Pagination: Supports infinite scroll with load-more functionality for large result sets.

---

⚙️ Challenges Faced and Solutions
- Network Detection in Release Mode:

  - Issue: ConnectivityService returned false in release mode.

  - Fix: Added both INTERNET and ACCESS_NETWORK_STATE permissions in AndroidManifest.xml and initialized internet check immediately on service start.

- Search Result Persistence:

  - Solution: Used Hive to store results locally per keyword to allow reuse of previously fetched content.
  - Challenge Faced: Initially, keywords were not stored with timestamps. This caused incorrect keywords to be deleted when enforcing the limit of 5 recent searches, as there was no way to identify which one was oldest.
  - Fix: Implemented timestamp-based tracking for each keyword entry, allowing precise deletion of the oldest keyword when a new one is added.

- Efficient UI Updates:

  - Handled with Obx and GetX to make only necessary parts reactive, improving performance and avoiding rebuilds.

---

🧩 Known Issues / Areas for Improvement
- No Clear Error UI:

  - Network or API errors are only shown via snackbars. A better error page or retry button could enhance UX.

- Search API Rate Limit:

  - NewsAPI’s free tier has a request limit. Handling for rate-limit errors could be improved.


