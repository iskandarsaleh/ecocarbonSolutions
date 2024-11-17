#!/bin/bash

# Create project directory structure
echo "Setting up project directory..."
mkdir -p ecocarbon-landing/assets
cd ecocarbon-landing || exit

# Create HTML file
echo "Creating index.html..."
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoCarbon Solutions</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://cdn.jsdelivr.net/npm/keycloak-js@21.0.1/dist/keycloak.min.js"></script>
    <script src="script.js" defer></script>
</head>
<body>
    <header>
        <div class="container">
            <div class="logo">
                <img src="assets/logo.png" alt="EcoCarbon Solutions Logo">
            </div>
            <nav>
                <ul>
                    <li><a href="#about">About</a></li>
                    <li><a href="#features">Features</a></li>
                    <li><button id="signup-btn" class="btn">Sign Up</button></li>
                    <li><button id="login-btn" class="btn secondary">Login</button></li>
                    <li><button id="logout-btn" class="btn secondary" style="display: none;">Logout</button></li>
                </ul>
            </nav>
        </div>
    </header>
    <main>
        <section id="hero">
            <img src="assets/hero-banner.jpg" alt="Sustainability Revolution" class="hero-image">
            <h1>Welcome to EcoCarbon Solutions</h1>
            <p>Your Partner in Carbon Reduction and Sustainability</p>
            <button id="signup-btn-hero" class="cta-button">Get Started</button>
        </section>
        <section id="about">
            <h2>About Us</h2>
            <p>EcoCarbon Solutions empowers organizations to reduce carbon footprints with innovative technologies and actionable insights.</p>
            <img src="assets/about-us.jpg" alt="About EcoCarbon Solutions" class="feature-image">
        </section>
        <section id="features">
            <h2>Features</h2>
            <div class="features-grid">
                <div class="feature">
                    <img src="assets/feature1.jpg" alt="Real-time Carbon Tracking">
                    <h3>Real-time Carbon Tracking</h3>
                    <p>Track your carbon emissions in real-time with precision and accuracy.</p>
                </div>
                <div class="feature">
                    <img src="assets/feature2.jpg" alt="Data-driven Sustainability Reports">
                    <h3>Data-driven Sustainability Reports</h3>
                    <p>Gain actionable insights with detailed sustainability reports.</p>
                </div>
                <div class="feature">
                    <img src="assets/feature3.jpg" alt="Customizable Solutions">
                    <h3>Customizable Solutions for Enterprises</h3>
                    <p>Adapt solutions to meet your organization’s specific sustainability goals.</p>
                </div>
            </div>
        </section>
        <section id="contact">
            <h2>Contact Us</h2>
            <p>Email: support@ecocarbon.solutions</p>
            <p>Phone: +1-800-555-0199</p>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 EcoCarbon Solutions. All Rights Reserved.</p>
    </footer>
</body>
</html>
EOF

# Create CSS file
echo "Creating style.css..."
cat << 'EOF' > style.css
/* General Styles */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background: #f4f4f9;
    color: #333;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 15px;
}

/* Header */
header {
    background: #028a0f;
    color: #fff;
    padding: 10px 0;
    text-align: center;
}

header .logo img {
    width: 150px;
}

header nav ul {
    list-style: none;
    padding: 0;
    display: flex;
    justify-content: center;
    gap: 20px;
}

header nav ul li {
    display: inline;
}

header nav ul li a,
header nav ul li button {
    color: #fff;
    text-decoration: none;
    padding: 10px 15px;
}

header nav ul li button {
    background: none;
    border: 1px solid #fff;
    border-radius: 5px;
    cursor: pointer;
}

header nav ul li button.btn {
    background: #fff;
    color: #028a0f;
}

header nav ul li button.btn.secondary {
    background: transparent;
}

header nav ul li button:hover {
    background: #026d0b;
    color: #fff;
}

/* Hero Section */
#hero {
    text-align: center;
    position: relative;
    color: #fff;
    background: #e8f5e9;
}

.hero-image {
    width: 100%;
    max-height: 400px;
    object-fit: cover;
    display: block;
    margin: 0 auto;
}

#hero h1 {
    margin: 20px 0;
}

#hero .cta-button {
    background: #028a0f;
    color: #fff;
    text-decoration: none;
    padding: 10px 20px;
    border-radius: 5px;
    display: inline-block;
    margin-top: 20px;
}

/* Features Section */
.features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
    margin: 20px 0;
}

.feature img {
    width: 100%;
    border-radius: 8px;
}

.feature h3 {
    margin: 10px 0;
}
EOF

# Create JavaScript file
echo "Creating script.js..."
cat << 'EOF' > script.js
// Keycloak configuration
const keycloakConfig = {
    url: 'https://your-keycloak-domain/auth', // Replace with your Keycloak base URL
    realm: 'ecocarbon-realm', // Replace with your realm name
    clientId: 'ecocarbon-client', // Replace with your client ID
};

const keycloak = new Keycloak(keycloakConfig);

keycloak
    .init({
        onLoad: 'check-sso',
        silentCheckSsoRedirectUri: window.location.origin + '/silent-check-sso.html',
    })
    .then((authenticated) => {
        const signupBtn = document.getElementById('signup-btn');
        const loginBtn = document.getElementById('login-btn');
        const logoutBtn = document.getElementById('logout-btn');
        const signupBtnHero = document.getElementById('signup-btn-hero');

        if (authenticated) {
            loginBtn.style.display = 'none';
            signupBtn.style.display = 'none';
            signupBtnHero.style.display = 'none';
            logoutBtn.style.display = 'inline-block';
        } else {
            logoutBtn.style.display = 'none';
        }

        signupBtn?.addEventListener('click', () => window.location.href = keycloak.createRegisterUrl());
        signupBtnHero?.addEventListener('click', () => window.location.href = keycloak.createRegisterUrl());
        loginBtn?.addEventListener('click', () => keycloak.login());
        logoutBtn?.addEventListener('click', () => keycloak.logout());
    })
    .catch((error) => console.error('Keycloak Initialization Error:', error));
EOF

# Download placeholder images
echo "Downloading placeholder images..."
curl -o assets/logo.png "https://via.placeholder.com/150x50.png?text=EcoCarbon+Solutions"
curl -o assets/hero-banner.jpg "https://via.placeholder.com/1200x600.png?text=Join+the+Sustainability+Revolution"
curl -o assets/about-us.jpg "https://via.placeholder.com/400x300.png?text=About+Us"
curl -o assets/feature1.jpg "https://via.placeholder.com/400x300.png?text=Real-time+Carbon+Tracking"
curl -o assets/feature2.jpg "https://via.placeholder.com/400x300.png?text=Sustainability+Reports"
curl -o assets/feature3.jpg "https://via.placeholder.com/400x300.png?text=Customizable+Solutions"

echo "Setup complete! Navigate to the 'ecocarbon-landing' directory and open 'index.html' in your browser."

