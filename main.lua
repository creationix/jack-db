local fs = require('coro-fs').chroot('db')

require('weblit-app')

    .bind({
        host = "0.0.0.0",
        port = 8080
    })

    .use(require('weblit-logger'))
    .use(require('weblit-auto-headers'))

    .route({
        method = "GET",
        path = "/db/:key",
    }, function(req, res, go)
        local data = fs.readFile(req.params.key)
        if data then
            res.code = 200
            res.body = data
        end
    end)

    .route({
        method = "PUT",
        path = "/db/:key",
    }, function(req, res, go)
        fs.writeFile(req.params.key, req.body)
        res.code = 201
    end)

    .route({
        method = "DELETE",
        path = "/db/:key",
    }, function(req, res, go)
        fs.unlink(req.params.key)
        res.code = 204
    end)

    .start()
