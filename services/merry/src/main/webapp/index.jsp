<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Merry - DevOps CI/CD Platform</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #333;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header */
        header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 20px 0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .logo {
            font-size: 2rem;
            font-weight: bold;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .nav-links {
            display: flex;
            gap: 30px;
            list-style: none;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 8px 16px;
            border-radius: 5px;
        }

        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        /* Hero Section */
        .hero {
            text-align: center;
            padding: 80px 20px;
            color: white;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 20px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.3);
            animation: fadeInDown 1s ease;
        }

        .hero p {
            font-size: 1.3rem;
            margin-bottom: 40px;
            opacity: 0.9;
            animation: fadeInUp 1s ease 0.2s both;
        }

        .cta-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
            animation: fadeInUp 1s ease 0.4s both;
        }

        .btn {
            padding: 15px 35px;
            font-size: 1.1rem;
            font-weight: 600;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-primary {
            background: white;
            color: #667eea;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
        }

        .btn-secondary {
            background: transparent;
            color: white;
            border: 2px solid white;
        }

        .btn-secondary:hover {
            background: white;
            color: #667eea;
            transform: translateY(-3px);
        }

        /* Features Section */
        .features {
            background: white;
            padding: 80px 20px;
            margin-top: -50px;
            border-radius: 20px 20px 0 0;
        }

        .features h2 {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 60px;
            color: #333;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 30px;
            border-radius: 15px;
            text-align: center;
            color: white;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .feature-icon {
            font-size: 3rem;
            margin-bottom: 20px;
        }

        .feature-card h3 {
            font-size: 1.5rem;
            margin-bottom: 15px;
        }

        .feature-card p {
            font-size: 1rem;
            opacity: 0.9;
            line-height: 1.6;
        }

        /* API Endpoints Section */
        .api-section {
            padding: 80px 20px;
            background: #f8f9fa;
        }

        .api-section h2 {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 50px;
            color: #333;
        }

        .endpoints {
            max-width: 900px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .endpoint {
            background: white;
            padding: 25px;
            border-radius: 10px;
            border-left: 5px solid #667eea;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .endpoint:hover {
            transform: translateX(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        }

        .endpoint-method {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 5px;
            font-weight: bold;
            font-size: 0.9rem;
            margin-right: 15px;
        }

        .method-get {
            background: #28a745;
            color: white;
        }

        .method-post {
            background: #007bff;
            color: white;
        }

        .method-delete {
            background: #dc3545;
            color: white;
        }

        .endpoint-path {
            font-family: 'Courier New', monospace;
            font-size: 1.1rem;
            color: #333;
        }

        .endpoint-desc {
            margin-top: 10px;
            color: #666;
            font-size: 0.95rem;
        }

        /* Stats Section */
        .stats {
            padding: 60px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .stat-item {
            padding: 20px;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* Footer */
        footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 30px 20px;
        }

        footer p {
            margin: 5px 0;
        }

        .footer-links {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: #667eea;
        }

        /* Animations */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .hero p {
                font-size: 1.1rem;
            }

            .nav-links {
                gap: 15px;
            }

            .features h2,
            .api-section h2 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <nav>
            <div class="logo">🎄 Merry</div>
            <ul class="nav-links">
                <li><a href="#features">Features</a></li>
                <li><a href="#api">API</a></li>
                <li><a href="#stats">Stats</a></li>
                <li><a href="/health">Health</a></li>
            </ul>
        </nav>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <h1>DevOps CI/CD Platform</h1>
            <p>Deploy Java Applications with Jenkins & Harness Migration Pipeline</p>
            <div class="cta-buttons">
                <a href="/hello" class="btn btn-primary">Get Started</a>
                <a href="#api" class="btn btn-secondary">View API Docs</a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="features">
        <div class="container">
            <h2>Platform Features</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">🚀</div>
                    <h3>Continuous Deployment</h3>
                    <p>Automated deployment pipeline with Jenkins and Harness integration for seamless releases.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔒</div>
                    <h3>Security Scanning</h3>
                    <p>Integrated OWASP and Snyk security checks to ensure your code is vulnerability-free.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📦</div>
                    <h3>Artifact Management</h3>
                    <p>Store and manage your WAR files with JFrog Artifactory integration.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🐳</div>
                    <h3>Container Ready</h3>
                    <p>Full Docker and Kubernetes support for modern cloud-native deployments.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Monitoring</h3>
                    <p>Real-time health checks and performance monitoring for all services.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">⚡</div>
                    <h3>Fast Builds</h3>
                    <p>Optimized build process with Maven for quick compilation and testing.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- API Endpoints Section -->
    <section class="api-section" id="api">
        <div class="container">
            <h2>Available API Endpoints</h2>
            <div class="endpoints">
                <div class="endpoint">
                    <span class="endpoint-method method-get">GET</span>
                    <span class="endpoint-path">/hello</span>
                    <p class="endpoint-desc">Welcome endpoint with greeting message</p>
                </div>
                <div class="endpoint">
                    <span class="endpoint-method method-get">GET</span>
                    <span class="endpoint-path">/health</span>
                    <p class="endpoint-desc">Health check endpoint for monitoring service status</p>
                </div>
                <div class="endpoint">
                    <span class="endpoint-method method-get">GET</span>
                    <span class="endpoint-path">/api/users?id={userId}</span>
                    <p class="endpoint-desc">Retrieve user information by ID</p>
                </div>
                <div class="endpoint">
                    <span class="endpoint-method method-post">POST</span>
                    <span class="endpoint-path">/api/users</span>
                    <p class="endpoint-desc">Create a new user in the system</p>
                </div>
                <div class="endpoint">
                    <span class="endpoint-method method-get">GET</span>
                    <span class="endpoint-path">/api/products?category={category}</span>
                    <p class="endpoint-desc">List products, optionally filtered by category</p>
                </div>
                <div class="endpoint">
                    <span class="endpoint-method method-delete">DELETE</span>
                    <span class="endpoint-path">/api/products?id={productId}</span>
                    <p class="endpoint-desc">Remove a product from the catalog</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats" id="stats">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">20+</div>
                    <div class="stat-label">Teams Migrated</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">99.9%</div>
                    <div class="stat-label">Uptime</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">100+</div>
                    <div class="stat-label">Deployments/Day</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">6</div>
                    <div class="stat-label">API Endpoints</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <p>&copy; 2025 Merry DevOps Platform. Built with ❤️ for CI/CD Excellence</p>
            <p>Powered by Jenkins, Harness, Docker & Kubernetes</p>
            <div class="footer-links">
                <a href="https://github.com">GitHub</a>
                <a href="/health">Health Status</a>
                <a href="#api">API Documentation</a>
                <a href="https://docs.harness.io">Harness Docs</a>
            </div>
        </div>
    </footer>

    <script>
        // Smooth scroll for navigation links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Add animation on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -100px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        document.querySelectorAll('.feature-card, .endpoint').forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(30px)';
            el.style.transition = 'all 0.6s ease';
            observer.observe(el);
        });
    </script>
</body>
</html>