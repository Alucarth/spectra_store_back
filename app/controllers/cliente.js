const Cliente = require('../models').Cliente;
const VentaDetalle = require('../models').VentaDetalle;
const Venta = require('../models').Venta;
const Producto = require('../models').Producto;
const sequelize = Cliente.sequelize;
const { QueryTypes } = require('sequelize');

module.exports = {
    create(req, res) {
        var prod = {
            nombre: req.body.nombre,
            telefono: req.body.telefono,
            email: req.body.email,
        };
        return Cliente.create(prod)
            .then((data) => res.status(201).send(data))
            .catch((error) => {
                console.log('error', error);
                res.status(500).send(error)
            });
    },

    list(req, res) {
        return Cliente.findAll()
            .then((data) => res.status(200).send(data))
            .catch((error) => {
                console.log('error', error);
                res.status(500).send(error)
            });
    },

    getClienteById(req, res) {
        return Cliente.findByPk(req.params.id)
            .then((data) => {
                if (!data) {
                    return res.status(404).send({
                        mensaje: 'Producto no encontrado'
                    })
                }
                return res.status(200).send(data)
            })
            .catch((error) => {
                console.log('error', error);
                res.status(500).send(error)
            });
    },

    update(req, res) {
            console.log(req.params.id)
            

            // console.log(Cliente.findOne({ where:{email: req.body.email}}))
        return Cliente.findOne({ where:{id: req.params.id}})
            .then(cliente => {
                console.log(cliente)
                if (!cliente) {
                    return res.status(404).send({
                        mensaje: 'Cliente no encontrado'
                    })
                }
                return cliente.update({
                    nombre: req.body.nombre || cliente.nombre,
                    telefono: req.body.telefono || cliente.telefono,
                    email: req.body.email || cliente.email,
                })
                    .then(() => res.status(200).send(cliente))
                    .catch((error) => {
                        console.log('error', error);
                        res.status(500).send(error)
                    });
            })
            .catch((error) => {
                console.log('error', error);
                res.status(500).send(error)
            });
    },

    delete(req, res) {

        return Cliente.findByPk(req.params.id)
            .then(cliente => {
                if (!cliente) {
                    return res.status(404).send({
                        mensaje: 'Cliente no encontrado'
                    })
                }
                return cliente.destroy()
                    .then(() => res.status(204).send())
                    .catch((error) => {
                        console.log('error', error);
                        res.status(500).send(error)
                    });
            })
            .catch((error) => {
                console.log('error', error);
                res.status(500).send(error)
            });
    },

    async ventaCliente(req,res)
    {
        let client = await Cliente.findOne({ where:{email: req.body.cliente.email}})
        if(!client) //if client doesn't exists
        {
            //create a new client 
            client = await Cliente.create(req.body.cliente)
        }

       
        let venta_payload = {
            cliente_id: client.id,
            total: req.body.total,
            fecha: new Date()
        }
        
        //create new Venta with venta_payload
        let venta = await Venta.create(venta_payload)

        req.body.productos.forEach( async (product) => {
            
            let producto = await Producto.findByPk(product.id)

            if(producto && product.cantidad > 0 )
            {
                let detalle_venta_payload = {
                    producto_id : product.id,
                    venta_id: venta.id,
                    precio: parseFloat(product.cantidad * producto.precio) 
                }

                let new_cantidad =  parseInt(producto.cantidad - product.cantidad)

                if(new_cantidad < 0)
                {
                    console.log(`No se tiene en stock la cantidad ${product.cantidad} del producto ${producto.nombre} `)
                    
                }else{

                    await VentaDetalle.create(detalle_venta_payload)
                    
                   
                    
                    await producto.update({cantidad: new_cantidad})
                }

            }

                
        });

        //finishly send venta 
        return res.status(200).send(venta)
    },

    async eliminarVenta(req,res){

        let message = " no se pudo encontrar  "+ req.params.id
  
        let venta = await Venta.findByPk(req.params.id)
  
        if(venta)
        {
            let venta_detalle = await VentaDetalle.findAll({where:{venta_id: venta.id }})
            venta_detalle.forEach( async (detalle) => {
                //delete venta_detalle
                await detalle.destroy()
            });

            await venta.destroy()

            message = "se elimino la venta " + req.params.id
        }
        return res.status(200).send(message)
    },

    async productosMasVendidos(req,res)
    {
        const productos = await sequelize.query('select sum(v.precio) as venta , p.nombre  from venta_detalle as v join producto as p  on p.id = v.producto_id group by p.nombre order by  venta desc limit 10 ;')
       console.log(productos)
        if(productos)
        {
            return res.status(200).send({producto_mas_vendidos: productos[0]})
        }
        return res.status(500).send({error:'ups error'})
    },

};