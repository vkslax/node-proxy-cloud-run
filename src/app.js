const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const { routes } = require('./routes.json');
const app = express();

app.get('/', (req, res) => {
    res.send('Proxy is running');
});


for (route of routes) {
    console.log('serving', route.route);
    app.use(route.route,
        createProxyMiddleware({
            target: route.address,
            changeOrigin: true,
            pathRewrite: (path, req) => {
                //slice has to be changed depending of base url path and what you want to rewrite
                const returnedPath = path.split('/').slice(4).join('/');
                console.log('path', path, returnedPath);
                return returnedPath;
            }
        })
    );
}
const port = process.env.PORT || 9000;
app.listen(port, () => {
    console.log('Proxy listening on port', port);
});
