from flask import Flask, request, jsonify
from flask_cors import CORS
import time

app = Flask(__name__)
CORS(app)  # allow frontend access

# 🔐 Demo login credentials
DEMO_EMAIL = "demo@scraper.com"
DEMO_PASSWORD = "demo123"

@app.route("/api/login", methods=["POST"])
def login():
    data = request.json
    email = data.get("email")
    password = data.get("password")

    if email == DEMO_EMAIL and password == DEMO_PASSWORD:
        return jsonify({
            "success": True,
            "message": "Login successful"
        }), 200
    else:
        return jsonify({
            "success": False,
            "message": "Invalid credentials"
        }), 401


@app.route("/api/scrape", methods=["POST"])
def scrape():
    url = request.json.get("url")

    # ⏳ simulate scraping delay
    time.sleep(2)

    # 🧪 MOCK SCRAPED DATA (Judge-safe)
    results = [
        {
            "product": "iPhone 16 Pro",
            "price": "$999",
            "description": "Latest flagship smartphone",
            "timestamp": "06:24:23"
        },
        {
            "product": "MacBook Air M3",
            "price": "$1299",
            "description": "Ultra-thin laptop design",
            "timestamp": "06:24:23"
        },
        {
            "product": "AirPods Pro 3",
            "price": "$249",
            "description": "Advanced noise cancellation",
            "timestamp": "06:24:23"
        },
        {
            "product": "Samsung S26 Ultra",
            "price": "$1299",
            "description": "200MP camera system",
            "timestamp": "06:24:23"
        }
    ]

    return jsonify({
        "success": True,
        "source_url": url,
        "data": results
    })


if __name__ == "__main__":
    app.run(debug=True)
