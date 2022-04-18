function fn() {
    var env = karate.env; // get java system property 'karate.env'
    karate.log('karate.env system property was:', env);
    if (!env) {
        env = 'testenv'; // a custom 'intelligent' default
    }
    env = env.toLowerCase().trim();
    var config = {
        profile: env,
        host: 'http://localhost:8080',
        //rootPath: '/graphql/subscription-api',
        rootPath: '',
        baseUrl: ' ',
        appId: 'my.app.id',
        applicationId: 'TestApp',
        defaultLab: 'rm-default-lab'
    };
    var profileToHost = {
        'prd':'https://sef-sub-api.delta.com',
             'cachedvl': 'https://anc-anr-cache-mngr.apps.dr1a1.paasdev.delta.com',
             'testenv':'https://vochr-api.apps.dr1a1.paasdev.delta.com',
            'resenv':'https://reqres.in/api/'
    };
  
    var host = karate.properties['karate.host'];
    if (!host) {
        config.host = profileToHost[env];
    }
    else {
        config.host = host.trim();
    }
    // Build the URL from host and path
    config.baseUrl = config.host + config.rootPath;
    // don't waste time waiting for a connection or if servers don't respond within 5 seconds
//   karate.configure('connectTimeout', 5000);
//    karate.configure('readTimeout', 5000);
    karate.configure('ssl', true);
    // ----- Global configuration elements -----
    karate.configure('headers', { appId: config.applicationId, 'Content-Type': 'application/json' })
    karate.configure('report', { showLog: true, showAllSteps: false, logPrettyRequest: true, logPrettyResponse: true })

    karate.log('----- Test configuration -----')
    karate.log('        profile:', config.profile);
    karate.log('           host:', config.host);
    karate.log('           path:', config.rootPath);
    karate.log('        baseUrl:', config.baseUrl);
    return config;
}
