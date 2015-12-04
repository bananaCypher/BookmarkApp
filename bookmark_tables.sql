CREATE TABLE bookmarks (
  id SERIAL4 primary key,
  name VARCHAR(255) not null,
  url VARCHAR(255) not null,
  genre VARCHAR(255)
);