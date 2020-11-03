const keys = require('./keys')

const redis = require('redis')

const redisClient = redis.createClient({
    host: keys.redisHost,
    port: keys.redisPort,
    retry_strategy: () => 1000
});

const redisSubscriber = redisClient.duplicate();

function fib(index) {
    if (index < 2) {
        return 1;
    }

    return fib(index - 1) + fib(index - 2);
}

redisSubscriber.on('message', (ch, msg) => {
    redisClient.hset('values', msg, fib(parseInt(msg)));
});

redisSubscriber.subscribe('insert');