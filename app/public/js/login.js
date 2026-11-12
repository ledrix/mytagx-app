
const loginForm = document.getElementById('loginForm');
const loginButton = document.getElementById('loginButton');
const loginMessage = document.getElementById('loginMessage');

loginForm.addEventListener('submit', async (event) => {
    event.preventDefault();

    loginMessage.className = 'login-message';
    loginMessage.textContent = '';

    loginButton.disabled = true;
    loginButton.textContent = 'Autenticando...';

    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;

    try {
        const response = await fetch('/api/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'same-origin',
            body: JSON.stringify({ email, password })
        });

        const data = await response.json();

        if (!response.ok) {
            throw new Error(data.message || 'Não foi possível realizar o login.');
        }

        loginMessage.textContent = 'Login realizado com sucesso!';
        loginMessage.className = 'login-message success';

        window.location.href = '/dashboard';

    } catch (error) {
        loginMessage.textContent = error.message;
        loginMessage.className = 'login-message error';

        loginButton.disabled = false;
        loginButton.textContent = 'Entrar no painel';
    }
});
