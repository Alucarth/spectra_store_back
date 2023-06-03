module.exports = (sequelize, DataTypes) => {
    const VentaDetalle = sequelize.define('VentaDetalle', {
        producto_id: DataTypes.INTEGER,
        venta_id: DataTypes.INTEGER,
        precio: DataTypes.DOUBLE,
    }, {
        timestamps: false, //CreateAt, UpdateAt
        tableName: 'venta_detalle'
    }
    );
    return VentaDetalle;
};