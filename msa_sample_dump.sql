-- Database 드랍 후 생성
DROP DATABASE IF EXISTS msa_sample;
CREATE DATABASE msa_sample;
USE msa_sample;

-- 드롭 순서: reviews, orders -> items -> products -> users

-- reviews 테이블 삭제
-- DROP TABLE IF EXISTS reviews;
-- orders 테이블 삭제
-- DROP TABLE IF EXISTS orders;
-- items 테이블 삭제
-- DROP TABLE IF EXISTS items;
-- products 테이블 삭제
-- DROP TABLE IF EXISTS products;
-- users 테이블 삭제
-- DROP TABLE IF EXISTS users;

-- 생성 순서: users, products -> items -> orders, reviews

-- users 테이블 생성
CREATE TABLE users (
    user_id INT(8) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- products 테이블 생성
CREATE TABLE products (
    product_id INT(8) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price INT NOT NULL,
    stock INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- items 테이블 생성
CREATE TABLE items (
    item_id INT(8) PRIMARY KEY AUTO_INCREMENT,
    product_id INT(8),
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);
-- orders 테이블 생성
CREATE TABLE orders (
    order_id INT(8) PRIMARY KEY AUTO_INCREMENT,
    user_id INT(8),
    item_id INT(8),
    total_price INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
-- reviews 테이블 생성
CREATE TABLE reviews (
    review_id INT(8) PRIMARY KEY AUTO_INCREMENT,
    user_id INT(8),
    product_id INT(8),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 더미데이터 입력

-- users 테이블 더미 데이터
INSERT INTO users (user_id, name, email, phone) VALUES
(1, 'Alice', 'alice@example.com', '123-456-7890'),
(2, 'Bob', 'bob@example.com', '123-456-7891'),
(3, 'Charlie', 'charlie@example.com', '123-456-7892'),
(4, 'David', 'david@example.com', '123-456-7893'),
(5, 'Eva', 'eva@example.com', '123-456-7894'),
(6, 'Frank', 'frank@example.com', '123-456-7895'),
(7, 'Grace', 'grace@example.com', '123-456-7896'),
(8, 'Hannah', 'hannah@example.com', '123-456-7897'),
(9, 'Ivy', 'ivy@example.com', '123-456-7898'),
(10, 'Jack', 'jack@example.com', '123-456-7899'),
(11, 'Kelly', 'kelly@example.com', '223-456-7890'),
(12, 'Leo', 'leo@example.com', '223-456-7891'),
(13, 'Mia', 'mia@example.com', '223-456-7892'),
(14, 'Nina', 'nina@example.com', '223-456-7893'),
(15, 'Oscar', 'oscar@example.com', '223-456-7894'),
(16, 'Paul', 'paul@example.com', '223-456-7895'),
(17, 'Quinn', 'quinn@example.com', '223-456-7896'),
(18, 'Rachel', 'rachel@example.com', '223-456-7897'),
(19, 'Sam', 'sam@example.com', '223-456-7898'),
(20, 'Tina', 'tina@example.com', '223-456-7899');

-- products 테이블 더미 데이터
INSERT INTO products (product_id, name, description, price, stock) VALUES
(1, 'Product A', 'Description for product A', 1000, 50),
(2, 'Product B', 'Description for product B', 2000, 30),
(3, 'Product C', 'Description for product C', 1500, 60),
(4, 'Product D', 'Description for product D', 1200, 20),
(5, 'Product E', 'Description for product E', 800, 70),
(6, 'Product F', 'Description for product F', 500, 40),
(7, 'Product G', 'Description for product G', 2200, 90),
(8, 'Product H', 'Description for product H', 3000, 15),
(9, 'Product I', 'Description for product I', 2500, 25),
(10, 'Product J', 'Description for product J', 1600, 55),
(11, 'Product K', 'Description for product K', 1700, 80),
(12, 'Product L', 'Description for product L', 1800, 35),
(13, 'Product M', 'Description for product M', 1900, 65),
(14, 'Product N', 'Description for product N', 2000, 45),
(15, 'Product O', 'Description for product O', 2100, 75),
(16, 'Product P', 'Description for product P', 2200, 85),
(17, 'Product Q', 'Description for product Q', 2300, 95),
(18, 'Product R', 'Description for product R', 2400, 10),
(19, 'Product S', 'Description for product S', 2500, 20),
(20, 'Product T', 'Description for product T', 2600, 30);

-- items 테이블 더미 데이터
INSERT INTO items (item_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3),
(4, 4, 2),
(5, 5, 4),
(6, 6, 1),
(7, 7, 5),
(8, 8, 2),
(9, 9, 3),
(10, 10, 4),
(11, 11, 2),
(12, 12, 1),
(13, 13, 5),
(14, 14, 2),
(15, 15, 4),
(16, 16, 1),
(17, 17, 2),
(18, 18, 3),
(19, 19, 1),
(20, 20, 4);

-- orders 테이블 더미 데이터
INSERT INTO orders (order_id, user_id, item_id, total_price) VALUES
(1, 1, 1, 2000),
(2, 2, 2, 2000),
(3, 3, 3, 4500),
(4, 4, 4, 2400),
(5, 5, 5, 3200),
(6, 6, 6, 500),
(7, 7, 7, 11000),
(8, 8, 8, 6000),
(9, 9, 9, 7500),
(10, 10, 10, 6400),
(11, 11, 11, 3400),
(12, 12, 12, 1800),
(13, 13, 13, 9500),
(14, 14, 14, 4000),
(15, 15, 15, 8000),
(16, 16, 16, 2200),
(17, 17, 17, 4600),
(18, 18, 18, 7200),
(19, 19, 19, 2500),
(20, 20, 20, 10400);

-- reviews 테이블 더미 데이터
INSERT INTO reviews (review_id, user_id, product_id, rating, comment) VALUES
(1, 1, 1, 5, 'Great product!'),
(2, 2, 2, 4, 'Good value.'),
(3, 3, 3, 3, 'Average quality.'),
(4, 4, 4, 2, 'Not what I expected.'),
(5, 5, 5, 5, 'Excellent!'),
(6, 6, 6, 4, 'Pretty good.'),
(7, 7, 7, 5, 'Highly recommend.'),
(8, 8, 8, 3, 'It’s okay.'),
(9, 9, 9, 4, 'Good but pricey.'),
(10, 10, 10, 5, 'Very satisfied.'),
(11, 11, 11, 2, 'Not worth the price.'),
(12, 12, 12, 5, 'Fantastic!'),
(13, 13, 13, 3, 'It’s decent.'),
(14, 14, 14, 4, 'Would buy again.'),
(15, 15, 15, 5, 'Highly recommend!'),
(16, 16, 16, 1, 'Terrible experience.'),
(17, 17, 17, 2, 'Not great.'),
(18, 18, 18, 4, 'I liked it.'),
(19, 19, 19, 3, 'It’s fine.'),
(20, 20, 20, 5, 'Love it!');
