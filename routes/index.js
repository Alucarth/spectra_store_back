const auth = require('../app/middlewares/auth');

const mainController = require('../app/controllers').main;
const productoController = require('../app/controllers').producto;
const ventaController = require('../app/controllers').venta;
const usuarioController = require('../app/controllers').usuario;
const clienteController = require('../app/controllers').cliente;

module.exports = (app) => {

    app.get('/', (req, res) => {
        //res.send('Hello World!')
        res.json({ mensaje: 'API operativo' });
    });

    app.get('/api', (req, res) => res.status(200).send({
        mensaje: 'Otra ruta'
    }));
    
    app.get('/api/products/:id', mainController.getProductById);

    app.post('/api/pruebapost', mainController.pruebaPost);

    app.post('/api/productos', productoController.create);
    app.get('/api/productos', productoController.list);
    app.get('/api/productos/:id', productoController.getProductById);
    app.put('/api/productos/:id', productoController.update);
    app.delete('/api/productos/:id', productoController.delete);

    app.get('/api/ventas/cliente/:id', auth.verificaUsuario, productoController.ventasByClienteId);

    app.get('/api/cuentas', mainController.listCuentas);

    app.post('/api/ventas', ventaController.create);

    app.post('/api/usuarios', usuarioController.create);

    app.post('/api/auth/login', usuarioController.authenticate);
    
    //tarea
    app.get('/api/clientes', clienteController.list);
    app.post('/api/clientes', clienteController.create);
    app.get('/api/clientes/:id', clienteController.getClienteById);
    app.put('/api/clientes', clienteController.update);
    app.delete('/api/clientes/:id', clienteController.delete);

    app.post('/api/clientes/venta', clienteController.ventaCliente);
    app.delete('/api/clientes/venta/:id', clienteController.eliminarVenta);

    app.get('/api/clientes/venta/productos', clienteController.productosMasVendidos);
    

   
};