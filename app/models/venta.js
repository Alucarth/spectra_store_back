module.exports = (sequelize, DataTypes) => {
    const Venta = sequelize.define('Venta', {
        cliente_id: DataTypes.INTEGER,
        total: DataTypes.DOUBLE,
        fecha: DataTypes.DATE
    }, {
        timestamps: false, //CreateAt, UpdateAt
        tableName: 'venta'
    }
    );
    Venta.associate = (models)=>{
        Venta.belongsTo(models.Cliente, {foreignKey: 'cliente_id', as: 'cliente' } )
    };
    return Venta;
};