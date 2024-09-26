from flask import Flask, request, render_template_string, redirect, url_for
import os
import redis
import random

app = Flask(__name__)

redis_host = os.getenv('REDIS_HOST', 'localhost')
redis_port = os.getenv('REDIS_PORT', 6379)
redis_password = os.getenv('REDIS_PASSWORD', None)

r = redis.StrictRedis(host=redis_host, port=redis_port, password=redis_password, decode_responses=True)

if not r.get('random_number'):
    r.set('random_number', random.randint(1, 10))

if not r.get('visit_count'):
    r.set('visit_count', 0)

@app.route('/')
def index():
    # =+ visit count
    r.incr('visit_count')
    return render_template_string('''
        <h1>Welcome to Guess the Number Game!</h1>
        <p>Total Visits: {{ visit_count }}</p>
        <p><a href="{{ url_for('game') }}">Start the Game</a></p>
    ''', visit_count=r.get('visit_count'))

@app.route('/game', methods=['GET', 'POST'])
def game():
    random_number = int(r.get('random_number'))
    message = ""
    if request.method == 'POST':
        guess = int(request.form.get('guess'))
        if guess == random_number:
            message = "Congratulations! You've guessed the right number!"
            # reset random number
            r.set('random_number', random.randint(1, 10))
        else:
            message = "Try again!"
    return render_template_string('''
        <h1>Guess the Number!</h1>
        <p>{{ message }}</p>
        <form method="POST">
            <label>Enter a number between 1 and 10:</label>
            <input type="number" name="guess" min="1" max="10">
            <input type="submit" value="Submit Guess">
        </form>
        <p><a href="{{ url_for('index') }}">Back to Home</a></p>
    ''', message=message)

@app.route('/count')
def count():
    return f"Total Visits: {r.get('visit_count')}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
