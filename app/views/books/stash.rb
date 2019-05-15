<nav id="sorting">
  <%= link_to "Highest Rated", books_path(sort: :rating, order: :desc) %>
  <%= link_to "Lowest Rated", books_path(sort: :rating, order: :asc) %>
  <%= link_to "Highest Page Count", books_path(sort: :pages, order: :desc) %>
  <%= link_to "Lowest Page Count", books_path(sort: :pages, order: :asc) %>
  <%= link_to "Most Reviewed", books_path(sort: :reviews, order: :desc) %>
  <%= link_to "Least Reviewed", books_path(sort: :reviews, order: :asc) %>
  <%= link_to "Add a Book", new_book_path %>
</nav>

<section id="book-statistics">
  <ul id="highest-rated">
    <% @highest_rated.each do |book| %>
      <li><%= link_to book.title, book_path(book) %></li>
      <li>Average Rating: <%= book.avg_rating %></li>
    <% end %>
  </ul>

  <ul id="worst-rated">
    <% @lowest_rated.each do |book| %>
      <li><%= link_to book.title, book_path(book) %></li>
      <li>Average Rating: <%= book.avg_rating %></li>
    <% end %>
  </ul>

  <ul id="most-reviews">
    <% @top_users.each do |user| %>
      <li><%= link_to user.name, user_path(user) %></li>
      <li>Total Reviews: <%= user.reviews.count %></li>
    <% end %>
  </ul>




  <div class="card-deck">
    <div class="card">
      <img src="..." class="card-img-top" alt="...">
      <div class="card-body">
        <h5 class="card-title">Card title</h5>
        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
        <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
      </div>
    </div>
    <div class="card">
      <img src="..." class="card-img-top" alt="...">
      <div class="card-body">
        <h5 class="card-title">Card title</h5>
        <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>
        <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
      </div>
    </div>
    <div class="card">
      <img src="..." class="card-img-top" alt="...">
      <div class="card-body">
        <h5 class="card-title">Card title</h5>
        <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</p>
        <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
      </div>
    </div>
  </div>









  <div>
    <% if @no_reviews != nil %>
      <h2>Books Not Reviewed</h2>
      <% @no_reviews.each do |book| %>

       <ul id="not-reviewed-<%= book.id %>">
         <li><%= link_to book.title, book_path(book) %></li>
         <li><%= book.pages %></li>
         <li><%= book.year %></li>
         <img class="img-thumbnail" src="<%= book.cover_image %>">
          <% book.authors.each do |author| %>
            <p>Authored By: <%= link_to author.name, author_path(author) %></p>
          <% end %>
        </ul>
          <% end %>
      <% end %>
  </div>

  <div>
       <ul id="not-reviewed-<%= book.id %>">
         <li><%= link_to book.title, book_path(book) %></li>
         <li><%= book.pages %></li>
         <li><%= book.year %></li>
         <img class="img-thumbnail" src="<%= book.cover_image %>">
          <% book.authors.each do |author| %>
            <p>Authored By: <%= link_to author.name, author_path(author) %></p>
          <% end %>
        </ul>
          <% end %>
      <% end %>
  </div>

  <%= form_for @book do |f| %>
    <%= f.label :title %>
    <%= f.text_field :title %>

    <%= f.label :pages %>
    <%= f.text_field :pages %>

    <%= f.label :year %>
    <%= f.number_field :year %>

    <%= f.label :cover_image %>
    <%= f.text_field :cover_image, value: "https://ibf.org/site_assets/img/placeholder-book-cover-default.png" %>

    <%= f.label :authors %>
    <%= f.text_field :authors %>

    <%= f.submit %>
  <% end %>


  <%= form_for [@book, @review] do |f| %>

    <%= f.label :title %>
    <%= f.text_field :title %>

    <%= f.label :user %>
    <%= f.text_field :user %>

    <%= f.label :rating %>
    <%= f.number_field :rating %>

    <%= f.label :description %>
    <%= f.text_area :description %>

    <%= f.submit %>
  <% end %>


  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <h1 class="navbar-brand">Books Index</h1>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item">
          <%= link_to "Add a Book", new_book_path, {class: "nav-link"} %>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Sorting
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown" id="sorting">
            <%= link_to "Highest Rated", books_path(sort: :rating, order: :desc), {class: "dropdown-item"} %>
            <%= link_to "Lowest Rated", books_path(sort: :rating, order: :asc), {class: "dropdown-item"} %>
            <%= link_to "Highest Page Count", books_path(sort: :pages, order: :desc), {class: "dropdown-item"} %>
            <%= link_to "Lowest Page Count", books_path(sort: :pages, order: :asc), {class: "dropdown-item"} %>
            <%= link_to "Most Reviewed", books_path(sort: :reviews, order: :desc), {class: "dropdown-item"} %>
            <%= link_to "Least Reviewed", books_path(sort: :reviews, order: :asc), {class: "dropdown-item"} %>
          </div>
        </li>
        <li class="nav-item dropdown" id="book-statistics">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Highest Rated
          </a>
          <div class="dropdown-menu" id="highest-rated" aria-labelledby="navbarDropdown">
            <% @highest_rated.each do |book| %>
            <%= link_to book.title, book_path(book), { class: "dropdown-item" } %>
            <p class="dropdown-item">Average Rating: <%= book.avg_rating %></p>
            <% end %>
          </div>
        </li>
        <li class="nav-item dropdown" id="book-statistics">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Lowest Rated
          </a>
          <div class="dropdown-menu" id="worst-rated" aria-labelledby="navbarDropdown">
            <% @lowest_rated.each do |book| %>
            <%= link_to book.title, book_path(book), { class: "dropdown-item" } %>
            <p class="dropdown-item">Average Rating: <%= book.avg_rating %></p>
            <% end %>
          </div>
        </li>
        <li class="nav-item dropdown" id="book-statistics">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Most Reviews
          </a>
          <div class="dropdown-menu" id="most-reviews" aria-labelledby="navbarDropdown">
            <% @top_users.each do |user| %>
            <%= link_to user.name, user_path(user), { class: "dropdown-item" } %>
            <p class="dropdown-item">Total Reviews: <%= user.reviews.count %></p>
            <% end %>
          </div>
        </li>
      </ul>
    </div>
  </nav>


  <section id="show-links">
    <%= link_to "Newest Reviews", user_path(@user, sort: :desc) %>
    <%= link_to "Oldest Reviews", user_path(@user, sort: :asc) %>
  </section>




      <% if @sort_reviews == nil %>
      <% @user.reviews.each do |review| %>

      <ul id="review-<%= review.id %>">
        <li><%= link_to review.book.title, book_path(review.book) %></li>


        <%= link_to "Delete Review", book_review_path(review.id, review.user_id), method: :delete %>
      </ul>
    </div>





            <li><%= link_to review.book.title, book_path(review.book) %></li>
            <li><img class="review_img" src="<%= review.book.cover_image %>"></li>
            <p><%= review.title %></p>
            <li><%= review.rating %></li>
            <li><%= review.description %></li>
            <p>Review created at: <%= review.created_at %></p>
            <%= link_to "Delete Review", book_review_path(review.id, review.user_id), method: :delete %>
          </ul>
        <% end %>
        <% end %>

        <section id="review-link">
          <%= link_to "Add a Review", new_book_review_path(@book) %>
          <%= link_to "Delete Book", book_path(@book), method: :delete %>
        </section>


        <section>
          <ul>
            <% @book.authors.each do |author| %>
              <li><%= link_to author.name, author_path(author) %></li>
            <% end %>


            <ul>
              <% @book.top_3_reviews.each do |review| %>
                <li><%= review.title %></li>
                <li><%= review.rating  %></li>
                <li>No User</li>
              <% else %>
                <li><%= link_to review.user.name, user_path(review.user) %></li>
              <% end %>
              <% end %>
            </ul>
          </section>




              <% if review.user == nil %>
                <li>No User</li>
              <% else %>
                <li><%= link_to review.user.name, user_path(review.user) %></li>
              <% end %>
                <li><%= review.rating %></li>
                <li><%= review.description %></li>
              <% end %>



              <section id="bottom_3_reviews">
                <h4>Lowest Ratings</h4>
                <ul>
                  <% @book.bottom_3_reviews.each do |review| %>
                    <li><%= review.title %></li>
                    <li><%= review.rating %></li>
                  <% if review.user == nil %>
                    <li>No User</li>
                  <% else %>
                    <li><%= link_to review.user.name, user_path(review.user) %></li>
                  <% end %>
                  <% end %>
                </ul>
              </section>


                  <% if book.reviews.count == 0 %>
                  <li>No reviews found</li>
                  <% else %>
                  <p><%= link_to book.top_review.first.user.name, user_path(book.top_review.first.user) %></p>
                  <p><%= book.top_review.first.title %></p>
                  <p><%= book.top_review.first.rating %></p>
                  <% end %>
                </ul>
                <% end %>
              </div>
