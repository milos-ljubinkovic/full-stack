'use strict';
process.env.AWS_NODEJS_CONNECTION_REUSE_ENABLED = true;
const serverlessExpress = require('@vendia/serverless-express')
const app = require('./app');

exports.handler = serverlessExpress({ app })