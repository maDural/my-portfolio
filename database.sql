-- Create database
CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

-- ============================================
-- 1. CONTACT MESSAGES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS contact_messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    status ENUM('unread', 'read', 'replied') DEFAULT 'unread',
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP NULL,
    replied_at TIMESTAMP NULL,
    INDEX idx_status (status),
    INDEX idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 2. PERSONAL INFO TABLE (About Me)
-- ============================================
CREATE TABLE IF NOT EXISTS personal_info (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    birth_place VARCHAR(200),
    nationality VARCHAR(50),
    location VARCHAR(100),
    languages VARCHAR(100),
    career_goal VARCHAR(100),
    hobbies VARCHAR(200),
    bio TEXT,
    profile_image VARCHAR(255),
    about_image VARCHAR(255),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 3. EDUCATION TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS education (
    id INT PRIMARY KEY AUTO_INCREMENT,
    school_name VARCHAR(150) NOT NULL,
    school_type ENUM('primary', 'secondary', 'university') DEFAULT 'university',
    degree VARCHAR(100),
    field_of_study VARCHAR(100),
    start_year YEAR NOT NULL,
    end_year YEAR,
    is_current BOOLEAN DEFAULT FALSE,
    description TEXT,
    image_path VARCHAR(255),
    location VARCHAR(100),
    grade VARCHAR(20),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_years (start_year, end_year),
    INDEX idx_order (display_order),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 4. SKILLS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS skills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    category ENUM('programming', 'other') DEFAULT 'programming',
    proficiency INT CHECK (proficiency BETWEEN 0 AND 100),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_order (display_order),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 5. FOOTBALL CLUB INFO TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS football_club (
    id INT PRIMARY KEY AUTO_INCREMENT,
    club_name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    strong_foot VARCHAR(20) NOT NULL,
    favorite_number INT,
    style TEXT,
    logo_path VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 6. FOOTBALL STATISTICS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS football_stats (
    id INT PRIMARY KEY AUTO_INCREMENT,
    stat_key VARCHAR(50) NOT NULL UNIQUE,
    stat_value VARCHAR(50) NOT NULL,
    label VARCHAR(50) NOT NULL,
    icon VARCHAR(50),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_order (display_order),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 7. FOOTBALL IMAGES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS football_images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    image_path VARCHAR(255) NOT NULL,
    title VARCHAR(100),
    alt_text VARCHAR(100),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_order (display_order),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 8. FOOTBALL VIDEO TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS football_videos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    video_path VARCHAR(255) NOT NULL,
    title VARCHAR(100),
    description TEXT,
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_order (display_order),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 9. PROJECTS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    icon VARCHAR(50) NOT NULL,
    technologies TEXT,
    github_url VARCHAR(255),
    live_url VARCHAR(255),
    image_path VARCHAR(255),
    display_order INT DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_order (display_order),
    INDEX idx_active (is_active),
    INDEX idx_featured (is_featured)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 10. GALLERY CATEGORIES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS gallery_categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    icon VARCHAR(10) NOT NULL,
    cover_image VARCHAR(255),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_order (display_order),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 11. GALLERY IMAGES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS gallery_images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT NOT NULL,
    image_path VARCHAR(255) NOT NULL,
    title VARCHAR(100),
    description TEXT,
    display_order INT DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES gallery_categories(id) ON DELETE CASCADE,
    INDEX idx_category (category_id),
    INDEX idx_order (display_order),
    INDEX idx_active (is_active),
    INDEX idx_featured (is_featured)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 12. SOCIAL LINKS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS social_links (
    id INT PRIMARY KEY AUTO_INCREMENT,
    platform VARCHAR(50) NOT NULL UNIQUE,
    url VARCHAR(255) NOT NULL,
    icon_class VARCHAR(50),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_order (display_order),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 13. USERS / ADMIN TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    role ENUM('admin', 'editor', 'viewer') DEFAULT 'viewer',
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 14. SITE SETTINGS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS site_settings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    setting_key VARCHAR(50) NOT NULL UNIQUE,
    setting_value TEXT,
    setting_group VARCHAR(50) DEFAULT 'general',
    description VARCHAR(255),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_key (setting_key),
    INDEX idx_group (setting_group)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

-- Insert Personal Info
INSERT INTO personal_info (full_name, birth_date, birth_place, nationality, location, languages, career_goal, hobbies, bio, profile_image, about_image) VALUES
('Mthetheleli Ndlovu', '2005-09-12', 'Church of Scotland Hospital, Tugela Ferry, KwaZulu-Natal', 'South African', 'Tugela Ferry, KZN', 'English, Zulu', 'IoT Engineer', 'Football, Coding', 'I was born on 12 September 2005 at Church of Scotland Hospital, located in Tugela Ferry, KwaZulu-Natal, where I also grew up. From a young age I developed a passion for technology, sports and continuous learning. I am currently studying Information Technology, specializing in Internet of Things (IoT) at Durban University of Technology. My goal is to become a professional software developer and IoT engineer while continuing to grow in football.', 'images/g.jpeg', 'images/s.jpeg');

-- Insert Education
INSERT INTO education (school_name, school_type, start_year, end_year, is_current, description, image_path, location, display_order) VALUES
('Sinqumeni Primary School', 'primary', 2012, 2018, 0, 'Primary Education', 'images/21.jpg', 'Tugela Ferry, KZN', 1),
('Mabaso Secondary School', 'secondary', 2019, 2023, 0, 'Secondary Education', 'images/m.jpg', 'Tugela Ferry, KZN', 2),
('Durban University of Technology', 'university', 2024, NULL, 1, 'Information Technology (IoT)', 'images/o.jpg', 'Durban, KZN', 3);

-- Insert Skills - Programming
INSERT INTO skills (name, category, proficiency, display_order) VALUES
('HTML', 'programming', 95, 1),
('CSS', 'programming', 90, 2),
('JavaScript', 'programming', 85, 3),
('Python', 'programming', 90, 4),
('C#', 'programming', 85, 5),
('SQL', 'programming', 85, 6),
('C++', 'programming', 80, 7),
('Kotlin', 'programming', 80, 8);

-- Insert Skills - Other
INSERT INTO skills (name, category, display_order) VALUES
('Networking', 'other', 1),
('Database Design', 'other', 2),
('Web Development', 'other', 3),
('Problem Solving', 'other', 4),
('IoT Development', 'other', 5),
('MS Office', 'other', 6),
('Teamwork', 'other', 7),
('Leadership', 'other', 8);

-- Insert Football Club Info
INSERT INTO football_club (club_name, position, strong_foot, favorite_number, style) VALUES
('Umsinga United Development', 'Winger · Attacking Midfielder', 'Right', 7, 'Fast · Creative · Dribbling · Passing');

-- Insert Football Stats
INSERT INTO football_stats (stat_key, stat_value, label, display_order) VALUES
('matches', '24', 'Matches', 1),
('goals', '11', 'Goals', 2),
('assists', '8', 'Assists', 3),
('mom', '5', 'MOM', 4),
('speed', '92%', 'Speed', 5),
('passing', '88%', 'Passing', 6);

-- Insert Football Images
INSERT INTO football_images (image_path, title, display_order) VALUES
('images/u.jpg', 'Mthetheleli on the football field', 1),
('images/i.jpg', 'Mthetheleli action shot', 2);

-- Insert Football Video
INSERT INTO football_videos (video_path, title, display_order) VALUES
('videos/Dural1.mp4', 'Football Highlights', 1);

-- Insert Projects
INSERT INTO projects (title, description, icon, technologies, display_order, is_featured) VALUES
('IoT Supply Chain Tracker', 'GPS · ESP32 · Temperature/Humidity · Live Dashboard', 'fa-microchip', 'ESP32, GPS, Sensors, Web Dashboard', 1, 1),
('Pet Grooming Website', 'Online Booking · Admin · Reviews', 'fa-paw', 'PHP, MySQL, JavaScript, CSS', 2, 1),
('E-commerce Website', 'PHP · MySQL · Cart · Payment', 'fa-shopping-cart', 'PHP, MySQL, JavaScript, Stripe API', 3, 1);

-- Insert Gallery Categories
INSERT INTO gallery_categories (name, icon, cover_image, display_order) VALUES
('Football', '⚽', 'images/IMG-20240813-WA0024.jpg', 1),
('Friends', '👥', 'images/1.jpg', 2),
('Family', '👨‍👩‍👧‍👦', 'images/11.jpg', 3),
('Only Me', '👤', 'images/0.jpg', 4),
('Memories', '🏫', 'images/28.jpg', 5);

-- Insert Gallery Images - Football
INSERT INTO gallery_images (category_id, image_path, title, display_order) VALUES
(1, 'images/1737798048031.jpg', 'Action Shot', 1),
(1, 'images/FB_IMG_1770039467889.jpg', 'Training', 2),
(1, 'images/IMG-20240104-WA0053.jpg', 'Match Day', 3),
(1, 'images/u.jpg', 'On the Field', 4),
(1, 'images/IMG-20240813-WA0012.jpg', 'Team Photo', 5),
(1, 'images/IMG-20240813-WA0022.jpg', 'Celebration', 6),
(1, 'images/Screenshot_20231117-230623.jpg', 'Game Moment', 7),
(1, 'images/IMG-20240813-WA0024.jpg', 'Match Day Action', 8),
(1, 'images/i.jpg', 'Action Shot', 9),
(1, 'images/Screenshot_20231117-230638.jpg', 'Victory', 10);

-- Insert Gallery Images - Friends
INSERT INTO gallery_images (category_id, image_path, title, display_order) VALUES
(2, 'images/2.jpg', 'Best Friends', 1),
(2, 'images/3.jpg', 'Group Photo', 2),
(2, 'images/4.jpg', 'Hangout', 3),
(2, 'images/5.jpg', 'Fun Times', 4),
(2, 'images/17.jpg', 'Memories', 5),
(2, 'images/18.jpg', 'Together', 6),
(2, 'images/29.jpg', 'Squad', 7),
(2, 'images/22.jpg', 'Friendship', 8);

-- Insert Gallery Images - Family
INSERT INTO gallery_images (category_id, image_path, title, display_order) VALUES
(3, 'images/9.jpg', 'Together', 1),
(3, 'images/12.jpg', 'Moments', 2),
(3, 'images/13.jpg', 'Home', 3),
(3, 'images/14.jpg', 'Family', 4),
(3, 'images/23.jpg', 'Memories', 5),
(3, 'images/24.jpg', 'Happiness', 6),
(3, 'images/31.jpg', 'Love', 7);

-- Insert Gallery Images - Only Me
INSERT INTO gallery_images (category_id, image_path, title, display_order) VALUES
(4, 'images/k.jpeg', 'Self', 1),
(4, 'images/w.jpg', 'Portrait', 2),
(4, 'images/r.jpg', 'Solo', 3),
(4, 'images/p.jpg', 'Casual', 4),
(4, 'images/0.jpg', 'Selfie', 5),
(4, 'images/f.jpeg', 'Focus', 6),
(4, 'images/e.jpg', 'Chill', 7),
(4, 'images/d.jpeg', 'Reflection', 8),
(4, 'images/t.jpg', 'Moment', 9);

-- Insert Gallery Images - Memories
INSERT INTO gallery_images (category_id, image_path, title, display_order) VALUES
(5, 'images/16.jpg', 'Classmates', 1),
(5, 'images/20.jpg', 'Memories', 2),
(5, 'images/21.jpg', 'Moments', 3),
(5, 'images/26.jpg', 'Friends', 4),
(5, 'images/27.jpg', 'Fun', 5),
(5, 'images/17.jpg', 'Together', 6),
(5, 'images/19.jpg', 'Unforgettable', 7);

-- Insert Social Links
INSERT INTO social_links (platform, url, icon_class, display_order) VALUES
('Phone', 'tel:+27722021793', 'fa-phone', 1),
('Email', 'mailto:mthethelelin77@gmail.com', 'fa-envelope', 2),
('Location', 'Tugela Ferry, KZN', 'fa-map-pin', 3),
('GitHub', 'https://github.com/maDural', 'fa-github', 4),
('LinkedIn', 'https://www.linkedin.com/in/mthetheleli-ndlovu-47bb24384/', 'fa-linkedin', 5),
('Facebook', 'https://web.facebook.com/ma.dura.3110', 'fa-facebook', 6),
('Instagram', 'https://www.instagram.com/ma_dura7/', 'fa-instagram', 7);

-- Insert Admin User (password: admin123)
INSERT INTO users (username, email, password_hash, full_name, role) VALUES
('admin', 'admin@portfolio.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', 'admin');

-- Insert Site Settings
INSERT INTO site_settings (setting_key, setting_value, setting_group, description) VALUES
('site_name', 'Mthetheleli Ndlovu Portfolio', 'general', 'Site name'),
('site_title', 'Mthetheleli Ndlovu | Portfolio', 'general', 'Site title'),
('site_description', 'Mthetheleli Ndlovu - Information Technology Student, IoT Developer and Football Player', 'general', 'Site description'),
('contact_email', 'mthethelelin77@gmail.com', 'contact', 'Contact email address'),
('contact_phone', '+27 72 2021 793', 'contact', 'Contact phone number'),
('contact_location', 'Tugela Ferry, KZN', 'contact', 'Location'),
('github_url', 'https://github.com/maDural', 'social', 'GitHub URL'),
('linkedin_url', 'https://www.linkedin.com/in/mthetheleli-ndlovu-47bb24384/', 'social', 'LinkedIn URL'),
('facebook_url', 'https://web.facebook.com/ma.dura.3110', 'social', 'Facebook URL'),
('instagram_url', 'https://www.instagram.com/ma_dura7/', 'social', 'Instagram URL'),
('about_birth_date', '12 September 2005', 'about', 'Birth date display'),
('about_nationality', 'South African', 'about', 'Nationality'),
('about_location', 'Tugela Ferry, KZN', 'about', 'Location'),
('about_languages', 'English, Zulu', 'about', 'Languages spoken'),
('about_career_goal', 'IoT Engineer', 'about', 'Career goal'),
('about_hobbies', 'Football, Coding', 'about', 'Hobbies');

-- ============================================
-- VIEWS FOR EASY DATA ACCESS
-- ============================================

-- View: Gallery with image count
CREATE OR REPLACE VIEW gallery_overview AS
SELECT 
    c.id AS category_id,
    c.name AS category_name,
    c.icon,
    c.cover_image,
    c.display_order,
    COUNT(i.id) AS image_count
FROM gallery_categories c
LEFT JOIN gallery_images i ON c.id = i.category_id AND i.is_active = 1
WHERE c.is_active = 1
GROUP BY c.id, c.name, c.icon, c.cover_image, c.display_order
ORDER BY c.display_order;

-- View: Full gallery with images
CREATE OR REPLACE VIEW gallery_full AS
SELECT 
    c.id AS category_id,
    c.name AS category_name,
    c.icon,
    c.cover_image,
    i.id AS image_id,
    i.image_path,
    i.title AS image_title,
    i.display_order AS image_order
FROM gallery_categories c
JOIN gallery_images i ON c.id = i.category_id
WHERE c.is_active = 1 AND i.is_active = 1
ORDER BY c.display_order, i.display_order;

-- View: Education overview
CREATE OR REPLACE VIEW education_overview AS
SELECT *
FROM education
WHERE is_active = 1
ORDER BY start_year DESC;

-- View: Skills by category
CREATE OR REPLACE VIEW skills_by_category AS
SELECT 
    category,
    GROUP_CONCAT(name ORDER BY display_order SEPARATOR ', ') AS skill_names,
    COUNT(*) AS skill_count
FROM skills
WHERE is_active = 1
GROUP BY category;

-- View: Football stats with labels
CREATE OR REPLACE VIEW football_stats_view AS
SELECT stat_key, stat_value, label
FROM football_stats
WHERE is_active = 1
ORDER BY display_order;

-- ============================================
-- STORED PROCEDURES
-- ============================================

-- Procedure: Add contact message
DELIMITER //
CREATE PROCEDURE add_contact_message(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_subject VARCHAR(200),
    IN p_message TEXT,
    IN p_ip VARCHAR(45),
    IN p_user_agent TEXT
)
BEGIN
    INSERT INTO contact_messages (name, email, subject, message, ip_address, user_agent)
    VALUES (p_name, p_email, p_subject, p_message, p_ip, p_user_agent);
    
    SELECT LAST_INSERT_ID() AS message_id;
END //
DELIMITER ;

-- Procedure: Get gallery by category
DELIMITER //
CREATE PROCEDURE get_gallery_by_category(
    IN p_category_name VARCHAR(50)
)
BEGIN
    SELECT 
        c.name AS category_name,
        c.icon,
        c.cover_image,
        i.image_path,
        i.title AS image_title,
        i.description AS image_description
    FROM gallery_categories c
    JOIN gallery_images i ON c.id = i.category_id
    WHERE c.name = p_category_name AND c.is_active = 1 AND i.is_active = 1
    ORDER BY i.display_order;
END //
DELIMITER ;

-- Procedure: Get all gallery categories with image counts
DELIMITER //
CREATE PROCEDURE get_gallery_categories()
BEGIN
    SELECT * FROM gallery_overview;
END //
DELIMITER ;

-- Procedure: Mark message as read
DELIMITER //
CREATE PROCEDURE mark_message_read(
    IN p_message_id INT
)
BEGIN
    UPDATE contact_messages 
    SET status = 'read', read_at = CURRENT_TIMESTAMP
    WHERE id = p_message_id;
END //
DELIMITER ;

-- Procedure: Mark message as replied
DELIMITER //
CREATE PROCEDURE mark_message_replied(
    IN p_message_id INT
)
BEGIN
    UPDATE contact_messages 
    SET status = 'replied', replied_at = CURRENT_TIMESTAMP
    WHERE id = p_message_id;
END //
DELIMITER ;

-- Procedure: Get unread message count
DELIMITER //
CREATE PROCEDURE get_unread_count()
BEGIN
    SELECT COUNT(*) AS unread_count 
    FROM contact_messages 
    WHERE status = 'unread';
END //
DELIMITER ;

-- ============================================
-- TRIGGERS
-- ============================================

-- Trigger: Update timestamp on gallery image update
DELIMITER //
CREATE TRIGGER update_gallery_image_timestamp
BEFORE UPDATE ON gallery_images
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END //
DELIMITER ;

-- Trigger: Update timestamp on project update
DELIMITER //
CREATE TRIGGER update_project_timestamp
BEFORE UPDATE ON projects
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END //
DELIMITER ;

-- Trigger: Update timestamp on education update
DELIMITER //
CREATE TRIGGER update_education_timestamp
BEFORE UPDATE ON education
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END //
DELIMITER ;

-- Trigger: Auto-update is_current for education
DELIMITER //
CREATE TRIGGER update_education_current
BEFORE INSERT ON education
FOR EACH ROW
BEGIN
    IF NEW.end_year IS NULL THEN
        SET NEW.is_current = 1;
    ELSE
        SET NEW.is_current = 0;
    END IF;
END //
DELIMITER ;

-- ============================================
-- ADDITIONAL QUERIES FOR COMMON OPERATIONS
-- ============================================

-- Get all data for the homepage
-- SELECT * FROM personal_info;
-- SELECT * FROM education_overview;
-- SELECT * FROM skills_by_category;
-- SELECT * FROM football_stats_view;
-- SELECT * FROM football_club;
-- SELECT * FROM projects WHERE is_active = 1 ORDER BY display_order;
-- SELECT * FROM gallery_overview;
-- SELECT * FROM social_links WHERE is_active = 1 ORDER BY display_order;

-- Get all contact messages with search
-- SELECT * FROM contact_messages 
-- WHERE name LIKE '%search%' OR email LIKE '%search%' OR subject LIKE '%search%'
-- ORDER BY created_at DESC;

-- Get recent contact messages
-- SELECT * FROM contact_messages ORDER BY created_at DESC LIMIT 10;

-- Get gallery images for a specific category
-- SELECT * FROM gallery_images WHERE category_id = 1 AND is_active = 1 ORDER BY display_order;