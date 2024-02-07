# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

from flask import Flask, request, jsonify
from firebase_admin import initialize_app, auth, firestore, db
import google.cloud.firestore
from firebase_functions import https_fn, firestore_fn
import requests

initialize_app()

# Create a Flask app instance
app = Flask(__name__)

api_key = 'e37ef2b2520c5f2a152db29a1e2267c3'
base_url = 'https://api.the-odds-api.com/v4'

def verify_token(req):
    # Verify the token in the request header
    auth_header = req.headers.get('Authorization')
    
    if not auth_header:
        return jsonify({'error': 'No Authorization header provided'}), 401

    # Extract the token from the header
    try:
        id_token = auth_header.split("Bearer ")[1]
    except IndexError:
        return jsonify({'error': 'Bearer token not found in Authorization header'}), 401

    # Verify the extracted token
    try:
        decoded_token = auth.verify_id_token(id_token)
        uid = decoded_token['uid']
        return uid
    except Exception as e:
        return jsonify({'error': 'error with verify_id_token'}), 401


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

    url = f'{base_url}/sports/{league}/odds?markets={markets}&bookmakers={bookmakers}&oddsFormat=american&apiKey={api_key}'

    response = requests.get(url)
    if response.status_code == 200:
        return jsonify(response.json())
    else:
        return jsonify({'error': 'Error with API request'}), 500

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
    regions = request.args.get('regions', 'us')

    url = f'{base_url}/sports/{league}/events/{event_id}/odds?regions={regions}&markets={markets}&oddsFormat=american&apiKey={api_key}'
    
    response = requests.get(url)
    if response.status_code == 200:
        return jsonify(response.json())
    else:
        return jsonify({'error': 'Error with API request'}), 500

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

    url = f'{base_url}/historical/sports/{league}/odds?markets={markets}&bookmakers={bookmakers}&date={date}&oddsFormat=american&apiKey={api_key}'
    
    response = requests.get(url)
    if response.status_code == 200:
        return jsonify(response.json())
    else:
        return jsonify({'error': 'Error with API request'}), 500

# Define a Firebase Cloud Function to handle requests
@https_fn.on_request()
def main(req: https_fn.Request) -> https_fn.Response:
    with app.request_context(req.environ):
        return app.full_dispatch_request()
