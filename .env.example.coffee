module.exports =
  ENVIRONMENT: 'local'

  SERVER:
    HOST: ''
    HTTP_PORT: 8080
    HTTPS_PORT: 8443

  DIR:
    ASSETS: __dirname + '/resources/assets/'
    DB: __dirname + '/db/'
    ROOT: __dirname + '/'
    SSL: __dirname + '/ssl/'
    STATIC: __dirname + '/public/'
    VIEWS: __dirname + '/resources/templates/'
