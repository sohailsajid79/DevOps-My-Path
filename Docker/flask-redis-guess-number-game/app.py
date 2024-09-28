from flask import Flask, request, render_template, redirect, url_for
import redis
import os
import random

app = Flask(__name__)

redis_host = os.getenv('REDIS_HOST', 'redis')
redis_port = os.getenv('REDIS_PORT', 6379)
redis_client = redis.StrictRedis(host=redis_host, port=redis_port, decode_responses=True)

@app.route('/')
def welcome():
    # track visits =+
    visits = redis_client.incr('visit_count')
    return f"Welcome to the Guess the Number Game! Total visits: {visits}. Click <a href='/game'>here</a> to start."

@app.route('/game', methods=['GET', 'POST'])
def game():
    if request.method == 'POST':
        guess = int(request.form['guess'])
        number = int(redis_client.get('random_number'))

        if guess == number:
            redis_client.delete('random_number')
            return f"Congratulations! You guessed the number {number} correctly!"
        else:
            return f"Try again! {guess} is not the correct number."

    else:
        # generate and store random int in redis if not already set
        if not redis_client.exists('random_number'):
            redis_client.set('random_number', random.randint(1, 10))
        return '''
            <form method="POST">
                Guess a number between 1 and 10: 
                <input type="number" name="guess" min="1" max="10">
                <input type="submit" value="Submit">
            </form>
        '''

@app.route('/count')
def count():
    visits = redis_client.get('visit_count')
    return f"Total visits: {visits}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002)
