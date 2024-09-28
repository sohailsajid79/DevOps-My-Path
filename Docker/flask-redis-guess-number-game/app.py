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
    return render_template('welcome.html', visits=visits)

@app.route('/game', methods=['GET', 'POST'])
def game():
    if request.method == 'POST':
        try:
            guess = int(request.form['guess'])
            number = int(redis_client.get('random_number'))
        except (ValueError, TypeError):
            message = "Invalid input. Please enter a number between 1 and 10."
            return render_template('game.html', message=message)

        if guess == number:
            redis_client.delete('random_number')
            message = f"Congratulations! You guessed the number {number} correctly!"
            return render_template('game.html', message=message)
        else:
            message = f"Try again! {guess} is not the correct number. The correct number is {number}"
            
            return render_template('game.html', message=message)

    else:
        # generate and store random number in redis if not already set
        if not redis_client.exists('random_number'):
            redis_client.set('random_number', random.randint(1, 10))
        return render_template('game.html')

@app.route('/count')
def count():
    visits = redis_client.get('visit_count')
    return render_template('count.html', visits=visits)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002)
