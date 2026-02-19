#!/bin/bash
# Simple Shoe Store Application

sudo dnf update -y
sudo dnf install -y nginx

# Create shoe store directory
sudo mkdir -p /var/www/shoestore

# Create simple HTML shoe store
sudo tee /var/www/shoestore/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SoleStyle - Premium Shoe Store</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; }
        header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 2rem; text-align: center; }
        .container { max-width: 1200px; margin: 0 auto; padding: 2rem; }
        .products { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 2rem; margin-top: 2rem; }
        .product { background: white; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow: hidden; transition: transform 0.3s; }
        .product:hover { transform: translateY(-5px); }
        .product-image { height: 200px; background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%); display: flex; align-items: center; justify-content: center; font-size: 4rem; }
        .product-info { padding: 1.5rem; }
        .product-title { font-size: 1.25rem; font-weight: bold; margin-bottom: 0.5rem; color: #333; }
        .product-price { color: #667eea; font-size: 1.5rem; font-weight: bold; margin-bottom: 0.5rem; }
        .product-desc { color: #666; margin-bottom: 1rem; }
        .btn { background: #667eea; color: white; border: none; padding: 0.75rem 1.5rem; border-radius: 5px; cursor: pointer; width: 100%; font-size: 1rem; }
        .btn:hover { background: #764ba2; }
        .cart { position: fixed; top: 20px; right: 20px; background: white; padding: 1rem; border-radius: 50%; box-shadow: 0 2px 10px rgba(0,0,0,0.2); cursor: pointer; }
        .cart-count { position: absolute; top: -5px; right: -5px; background: #f5576c; color: white; border-radius: 50%; width: 20px; height: 20px; display: flex; align-items: center; justify-content: center; font-size: 0.75rem; }
    </style>
</head>
<body>
    <header>
        <h1>👟 SoleStyle</h1>
        <p>Premium Footwear for Every Occasion</p>
    </header>
    
    <div class="cart" onclick="alert('Cart: ' + cart.length + ' items')">
        🛒
        <span class="cart-count" id="cartCount">0</span>
    </div>

    <div class="container">
        <h2 style="text-align: center; margin-bottom: 1rem;">Featured Collection</h2>
        
        <div class="products">
            <div class="product">
                <div class="product-image">👟</div>
                <div class="product-info">
                    <div class="product-title">Air Runner Pro</div>
                    <div class="product-price">$129.99</div>
                    <div class="product-desc">High-performance running shoes with advanced cushioning technology.</div>
                    <button class="btn" onclick="addToCart('Air Runner Pro')">Add to Cart</button>
                </div>
            </div>

            <div class="product">
                <div class="product-image" style="background: linear-gradient(45deg, #4facfe 0%, #00f2fe 100%);">👞</div>
                <div class="product-info">
                    <div class="product-title">Urban Walker</div>
                    <div class="product-price">$89.99</div>
                    <div class="product-desc">Stylish casual shoes perfect for city life and everyday comfort.</div>
                    <button class="btn" onclick="addToCart('Urban Walker')">Add to Cart</button>
                </div>
            </div>

            <div class="product">
                <div class="product-image" style="background: linear-gradient(45deg, #43e97b 0%, #38f9d7 100%);">🏃</div>
                <div class="product-info">
                    <div class="product-title">Speed Demon</div>
                    <div class="product-price">$159.99</div>
                    <div class="product-desc">Lightweight sprinting shoes designed for maximum speed.</div>
                    <button class="btn" onclick="addToCart('Speed Demon')">Add to Cart</button>
                </div>
            </div>

            <div class="product">
                <div class="product-image" style="background: linear-gradient(45deg, #fa709a 0%, #fee140 100%);">👠</div>
                <div class="product-info">
                    <div class="product-title">Elegant Step</div>
                    <div class="product-price">$79.99</div>
                    <div class="product-desc">Classic formal shoes for business and special occasions.</div>
                    <button class="btn" onclick="addToCart('Elegant Step')">Add to Cart</button>
                </div>
            </div>

            <div class="product">
                <div class="product-image" style="background: linear-gradient(45deg, #a8edea 0%, #fed6e3 100%);">🏔️</div>
                <div class="product-info">
                    <div class="product-title">Trail Blazer</div>
                    <div class="product-price">$149.99</div>
                    <div class="product-desc">Rugged hiking boots for outdoor adventures.</div>
                    <button class="btn" onclick="addToCart('Trail Blazer')">Add to Cart</button>
                </div>
            </div>

            <div class="product">
                <div class="product-image" style="background: linear-gradient(45deg, #ffecd2 0%, #fcb69f 100%);">🏀</div>
                <div class="product-info">
                    <div class="product-title">Court Master</div>
                    <div class="product-price">$119.99</div>
                    <div class="product-desc">Professional basketball shoes with superior ankle support.</div>
                    <button class="btn" onclick="addToCart('Court Master')">Add to Cart</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        let cart = [];
        function addToCart(product) {
            cart.push(product);
            document.getElementById('cartCount').textContent = cart.length;
            alert(product + ' added to cart!');
        }
    </script>
</body>
</html>
EOF

# Configure Nginx
sudo tee /etc/nginx/conf.d/shoestore.conf > /dev/null <<'EOF'
server {
    listen 80;
    server_name _;
    root /var/www/shoestore;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

# Remove default config and restart
sudo rm -f /etc/nginx/conf.d/default.conf
sudo systemctl restart nginx
sudo systemctl enable nginx

# Set permissions
sudo chown -R ec2-user:ec2-user /var/www/shoestore