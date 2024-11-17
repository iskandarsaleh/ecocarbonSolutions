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
