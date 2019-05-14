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
