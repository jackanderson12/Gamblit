# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

from flask import Flask, request, jsonify
from firebase_admin import initialize_app, auth
from firebase_functions import https_fn
import requests

initialize_app()

# Create a Flask app instance
app = Flask(__name__)

api_key = 'e37ef2b2520c5f2a152db29a1e2267c3'
base_url = 'https://api.the-odds-api.com/v4'

def verify_token(req):
    #Verify the token in the request header
    header = req.headers.get('Authorization')
    if header:
        token = header.split("Bearer ")[1]
        try:
            decoded_token = auth.verify_id_token(token)
            return decoded_token
        except Exception as e:
            return jsonify({'error': 'str(e)'}), 401
    return None

@app.route('/sports', methods=['GET'])
def sports():
    # Verify Firebase Auth Token
    user = verify_token(request)
    if not user:
        return jsonify({'error': 'Unauthorized'}), 401
    
    # Logic for the '/sports' route
    league = request.args.get('league', 'americanfootball_nfl')
    markets = request.args.get('markets', 'h2h,totals,spreads')
    bookmakers = request.args.get('bookmakers', 'draftkings')

    url = f'{base_url}/sports/{league}/odds?markets={markets}&bookmakers={bookmakers}&apiKey={api_key}'
    response = requests.get(url)
    return response.json()

@app.route('/event', methods=['GET'])
def event():
    # Verify Firebase Auth Token
    user = verify_token(request)
    if not user:
        return jsonify({'error': 'Unauthorized'}), 401
    
    # Logic for the '/event' route
    league = request.args.get('league', 'americanfootball_nfl')
    event_id = request.args.get('event_id', '')
    markets = request.args.get('markets', 'h2h,totals,spreads')
    bookmakers = request.args.get('bookmakers', 'draftkings')

    url = f'{base_url}/sports/{league}/events/{event_id}/odds?markets={markets}&bookmakers={bookmakers}&apiKey={api_key}'
    response = requests.get(url)
    return response.json()

@app.route('/historical', methods=['GET'])
def historical():
    # Verify Firebase Auth Token
    user = verify_token(request)
    if not user:
        return jsonify({'error': 'Unauthorized'}), 401
    
    # Logic for the '/historical' route
    league = request.args.get('league', 'americanfootball_nfl')
    markets = request.args.get('markets', 'h2h,totals,spreads')
    date = request.args.get('date', '')
    bookmakers = request.args.get('bookmakers', 'draftkings')

    url = f'{base_url}/historical/sports/{league}/odds?markets={markets}&bookmakers={bookmakers}&date={date}&apiKey={api_key}'
    response = requests.get(url)
    return response.json()

# Define a Firebase Cloud Function to handle requests
@https_fn.on_request()
def main(req: https_fn.Request) -> https_fn.Response:
    # Dispatch request to Flask app
    return app(req)
