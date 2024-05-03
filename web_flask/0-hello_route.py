<<<<<<< HEAD
from flask import Flask

app = Flask(__name__)

@app.route('/', strict_slashes=False)
def hello_hbnb():
    return "Hello HBNB!"

if __name__ == '__main__':
=======
#!/usr/bin/python3
"""Start a flask web app
"""

from flask import Flask
app = Flask(__name__)


@app.route('/')
def hello_flask():
    """Return string when route queried
    """
    return 'Hello HBNB!'

if __name__ == '__main__':
    app.url_map.strict_slashes = False
>>>>>>> 008bdfb401543f4c9d13bfd34f9d0802b72ee27c
    app.run(host='0.0.0.0', port=5000)
