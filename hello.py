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
        'tsv': {
            'format': 'time:%(asctime)s\tlevel:%(levelname)s\t%(message)s',
        },
    },
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
            'level': 'DEBUG',
            'formatter': 'simple',
        },
        'file-rotate': {
            'class': 'logging.handlers.TimedRotatingFileHandler',
            'level': 'DEBUG',
            'formatter': 'tsv',
            'filename': 'txt.log',
            'interval': 5,
            'when': 'S',
            'backupCount': 5,
            'encoding': 'utf-8',
        },
    },
    'loggers': {
        'file': {
            'handlers': ['file-rotate'],
        },
        'console': {
            'handlers': ['console'],
        },
    },
    'root': {
        'level': 'DEBUG',
        'handlers': ['console'],
    },
})

console = logging.getLogger('console')
fwrite  = logging.getLogger('file')

console.info("------------------------------------------------------------------")
console.info(" logging : interval = {} sec".format(os.environ.get('LOG_INTERVAL')))
console.info("------------------------------------------------------------------")
i = 0
while True:
    country = random.sample(list(countries), 1).pop()
    try:
        fwrite.info("count:{:8}\tcountry-official-name:{}!".format(i, country.official_name))
    except Exception as e:
        # Sometimes there is no official name
        logging.warn("{}'s official name is same as common name".format(country.name))
        logging.info("[{:8}] Hello {}!".format(i, country.name))
    if os.environ.get('LOG_INTERVAL'):
        time.sleep(float(os.environ['LOG_INTERVAL']))
    i += 1
