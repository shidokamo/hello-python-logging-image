import time
import random
import os
from datetime import datetime
from pycountry import countries
import logging
from logging.config import dictConfig

dictConfig({
    'version': 1,
    'formatters': {
        'simple': {
            'format': '[%(asctime)s] %(levelname)s : %(message)s',
        },
    },
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
            'level': 'WARNING',
            'formatter': 'simple',
        },
        'file-rotate': {
            'class': 'logging.handlers.TimedRotatingFileHandler',
            'level': 'DEBUG',
            'formatter': 'simple',
            'filename': 'txt.log',
            'interval': 5,
            'when': 'S',
            'backupCount': 5,
            'encoding': 'utf-8',
        },
    },
    'root': {
        'level': 'DEBUG',
        'handlers': ['console', 'file-rotate'],
    },
})

logging.info("------------------------------------------------------------------")
logging.info(f" logging : interval = {os.environ.get('LOG_INTERVAL')} sec")
logging.info("------------------------------------------------------------------")
i = 0
while True:
    country = random.sample(list(countries), 1).pop()
    try:
        logging.info(f"[{i:8}] Hello {country.official_name}!")
    except Exception as e:
        # Sometimes there is no official name
        logging.warn(f"{country.name}'s official name is same as common name")
        logging.info(f"[{i:8}] Hello {country.name}!")
    if os.environ.get('LOG_INTERVAL'):
        time.sleep(float(os.environ['LOG_INTERVAL']))
    i += 1
