/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {

    /*Al presionar el boton limpiar se quitan lo input pintados*/
    $("#limpiar").on("click", function () {
        $('.form-group').removeClass('has-success has-error');
        $('.glyphicon ').remove();
        $('.help-block').text("");
    });
    /*validacion del formulario categorias*/
    $('#form-categoria').bootstrapValidator({

        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields: {

            nombre: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese el nombre de la Categoria'
                    }, stringLength: {
                        min: 6,
                        max: 30,
                        message: 'Maximo debe contener 50 caracteres y minimo 6'
                    },
                    regexp: {
                        regexp: /^[A-Za-z\s\ñ\Ñ]*$/,
                        message: 'Ingrese solo letras'
                    }
                }
            }
        }
    });


    /*validacion del formulario productos*/
    $('#form-producto').bootstrapValidator({
        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields: {
            nombre: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese el nombre del producto'
                    }, stringLength: {
                        min: 3,
                        max: 30,
                        message: 'Maximo debe contener 50 caracteres y minimo 3'
                    },
                    regexp: {
                        regexp: /^[A-Za-z\s\ñ\Ñ]*$/,
                        message: 'Caracter invalido'
                    }
                }
            },
            idcategoria: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione una categoria'
                    }
                }
            },
            descripcion: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese una descripción del producto'
                    }, stringLength: {
                        min: 10,
                        max: 300,
                        message: 'Maximo debe contener 300 caracteres y minimo 10'
                    },
                    regexp: {
                        regexp: /^[A-Za-z\s\ñ\Ñ]*$/,
                        message: 'Caracter invalido'
                    }
                }
            },
            precioventa: {
                validators: {
                    notEmpty: {
                        message: 'El precio de venta del producto es requerido'
                    }, stringLength: {
                        min: 1,
                        max: 5,
                        message: 'El precio de venta ingresado es invalido'
                    },
                    regexp: {
                        regexp: /^[0-9\.]*$/,
                        message: 'Ingrese solo numeros'

                    }
                }
            }
        }
    });

    /*validacion del formulario consumo*/
    $('#form-consumo').bootstrapValidator({
        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields: {
            nombrecliente: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese el nombre del Cliente'
                    },
                    regexp: {
                        regexp: /^[A-Za-z\s\ñ\Ñ]*$/,
                        message: 'Caracter invalido'
                    }
                }
            },
            cantidad: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese la cantidad del producto requerido'
                    }, stringLength: {
                        min: 1,
                        message: 'La cantidad minima debe ser 1'
                    },
                    regexp: {
                        regexp: /^[0-9\.]*$/,
                        message: 'Ingrese solo numeros'

                    }
                }
            },
            idproducto: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione una categoria'
                    }
                }
            }
        }

    });


    /*validacion del formulario pagos*/
    $('#form-pago').bootstrapValidator({
        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields: {
            tipocomprobante: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione un tipo de comprobante'
                    }
                }
            },
            numcomprobante: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese el numero del comprobante'
                    }, stringLength: {
                        min: 3,
                        max: 25,
                        message: 'Maximo debe contener 25 caracteres y minimo 3'
                    },
                    regexp: {
                        regexp: /^[A-Z0-9a-z\s\ñ\Ñ]*$/,
                        message: 'Caracter invalido'
                    }
                }
            },

            impuesto: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese el valor del impuesto a cobrar'
                    }, stringLength: {
                        min: 1,
                        message: 'La cantidad minima debe ser datos ingresados debe 4'
                    },
                    regexp: {
                        regexp: /^[0-9\.]*$/,
                        message: 'Ingrese solo numeros'

                    }
                }
            },
            fechaemisionreserva: {
                validators: {
                    notEmpty: {
                        message: 'La fecha de emision del pago es requerida'
                    }
                }
            },
            fechapagoreserva: {
                validators: {
                    notEmpty: {
                        message: 'La fecha de pago de la reserva es requerida'
                    }
                }
            }
        }

    });

    /*validacion de formulario clientes*/
    $('#form-cliente').bootstrapValidator({
        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields: {
            nombre: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese los nombres del Cliente'
                    }, stringLength: {
                        min: 5,
                        max: 100,
                        message: 'El nombre debe contener 100 caracteres y minimo 5'
                    },
                    regexp: {
                        regexp: /^[A-Za-z\s\ñ\Ñ]*$/,
                        message: 'Ingrese solo letras'
                    }
                }
            },
            apellido: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese los apellidos del Cliente'
                    }, stringLength: {
                        min: 5,
                        max: 100,
                        message: 'El nombre debe contener 100 caracteres y minimo 5'
                    },
                    regexp: {
                        regexp: /^[A-Za-z\s\ñ\Ñ]*$/,
                        message: 'Ingrese solo letras'
                    }
                }
            },

            tipodocumento: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione un tipo de documento'
                    }
                }
            },

            direccion: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese la direccion del cliente'
                    }, stringLength: {
                        min: 10,
                        max: 300,
                        message: 'Maximo debe contener 300 caracteres y minimo 10'
                    },
                    regexp: {
                        regexp: /^[A-Za-z\s\ñ\Ñ\.\,\#\;]*$/,
                        message: 'Caracter invalido'
                    }
                }
            },
            telefono: {
                validators: {
                    notEmpty: {
                        message: 'El teléfono del cliente es requerido'
                    },
                    stringLength: {
                        min: 9,
                        message: 'El número ingresado es invalido'
                    }

                }
            },
            numdocumento: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese el número de documento'
                    }, stringLength: {
                        min: 9,
                        max: 30,
                        message: 'El numero de documento debe contener entre 30 caracteres y 9'
                    },
                    regexp: {
                        regexp: /^[A-Z0-9a-z\s\ñ\Ñ\-]*$/,
                        message: 'Caracter invalido'
                    }
                }
            }
        }
    });

    /*validacion del formulario cargos*/
    $('#form-cargos').bootstrapValidator({
        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields: {
            nombre: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese el nombre del cargo'
                    }, stringLength: {
                        min: 5,
                        max: 40,
                        message: 'El nombre del cargo debe contener 40 caracteres y minimo 5'
                    },
                    regexp: {
                        regexp: /^[A-Za-z\s\ñ\Ñ]*$/,
                        message: 'Ingrese solo letras'
                    }
                }
            },
            salario: {
                validators: {
                    notEmpty: {
                        message: 'El salario del cargo es requerido'
                    }, stringLength: {
                        min: 2,
                        max: 10,
                        message: 'El salario ingresado es invalido'
                    },
                    regexp: {
                        regexp: /^[0-9\.]*$/,
                        message: 'Ingrese solo numeros'

                    }
                }
            }
        }

    });


    /*validacion del fomulario de usuarios*/
    $('#form-us').bootstrapValidator({
        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields: {
            usuario: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese el nombre del usuario'
                    }, stringLength: {
                        min: 4,
                        max: 100,
                        message: 'El usuario del empleado debe contener 100 caracteres y minimo 4'
                    },
                    regexp: {
                        regexp: /^[A-Z0-9a-z\s\ñ\Ñ]*$/,
                        message: 'Caracteres invalidos'
                    }
                }
            },
            idempleado: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione un empleado'
                    }
                }
            }
        }

    });



    /*validacion de formulario emleados*/
    $('#form-empleado').bootstrapValidator({
        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields: {
            nombre: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese los nombres del Empleado'
                    }, stringLength: {
                        min: 5,
                        max: 100,
                        message: 'El nombre debe contener 100 caracteres y minimo 5'
                    },
                    regexp: {
                        regexp: /^[A-Za-z\s\ñ\Ñ]*$/,
                        message: 'Ingrese solo letras'
                    }
                }
            },
            apellido: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese los apellidos del Empleado'
                    }, stringLength: {
                        min: 5,
                        max: 100,
                        message: 'El nombre debe contener 100 caracteres y minimo 5'
                    },
                    regexp: {
                        regexp: /^[A-Za-z\s\ñ\Ñ]*$/,
                        message: 'Ingrese solo letras'
                    }
                }
            },

            tipodocumento: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione un tipo de documento'
                    }
                }
            },

            direccion: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese la direccion del empleado'
                    }, stringLength: {
                        min: 10,
                        max: 300,
                        message: 'Maximo debe contener 300 caracteres y minimo 10'
                    },
                    regexp: {
                        regexp: /^[A-Z0-9a-z\s\ñ\Ñ\.\,\#\;]*$/,
                        message: 'Caracter invalido'
                    }
                }
            },
            telefono: {
                validators: {
                    notEmpty: {
                        message: 'El teléfono del empleado es requerido'
                    },
                    stringLength: {
                        min: 9,
                        message: 'El número ingresado es invalido'
                    }

                }
            },
            numdocumento: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese el número de documento'
                    }, stringLength: {
                        min: 9,
                        max: 30,
                        message: 'El numero de documento debe contener entre 30 caracteres y 9'
                    },
                    regexp: {
                        regexp: /^[A-Z0-9a-z\s\ñ\Ñ\-]*$/,
                        message: 'Caracter invalido'
                    }
                }
            },

            idcargo: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione un cargo para el empleado'
                    }
                }
            },
            email: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese un correo electronico'
                    },
                    emailAddress: {
                        message: 'El e-mail ingresado es invalido'
                    }
                }
            }
        }
    });

    /*validacion del formulario de habitaciones*/

    $('#form-habitacion').bootstrapValidator({
        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields: {
            numero: {
                validators: {
                    notEmpty: {
                        message: 'El número de la habitación es requerido'
                    },
                    regexp: {
                        regexp: /^[0-9]*$/,
                        message: 'Ingrese solo numeros positivos'

                    }
                }
            },
            piso: {
                validators: {
                    notEmpty: {
                        message: 'El piso de la habitación es requerido'
                    },
                    regexp: {
                        regexp: /^[0-9]*$/,
                        message: 'Ingrese solo numeros positivos'

                    }
                }
            },
            caracteristica: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese las caracteristicas de la habitación'
                    }, stringLength: {
                        min: 10,
                        max: 300,
                        message: 'Maximo debe contener 300 caracteres y minimo 10'
                    },
                    regexp: {
                        regexp: /^[A-Z0-9a-z\s\ñ\Ñ\.\,\#\;]*$/,
                        message: 'Caracter invalido'
                    }
                }
            },
            descripcion: {
                validators: {
                    notEmpty: {
                        message: 'Ingrese la descripción de la habitación'
                    }, stringLength: {
                        min: 10,
                        max: 300,
                        message: 'Maximo debe contener 300 caracteres y minimo 10'
                    },
                    regexp: {
                        regexp: /^[A-Z0-9a-z\s\ñ\Ñ\.\,\#\;]*$/,
                        message: 'Caracter invalido'
                    }
                }
            },
            tipohabitacion: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione un tipo de habitación'
                    }
                }
            },
            estado: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione un tipo de habitación'
                    }
                }
            },
            preciodiaro: {
                validators: {
                    notEmpty: {
                        message: 'El precio diario de la habitación es requerido'
                    }, stringLength: {
                        min: 1,
                        max: 10,
                        message: 'El precio de la habitación es invalido'
                    },
                    regexp: {
                        regexp: /^[0-9\.]*$/,
                        message: 'Ingrese solo numeros positivos'

                    }
                }
            }
        }
    });

    /*Valadicion del formulario reservas*/
    $('#form-reserva').bootstrapValidator({

        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields:{
            idhabitacion: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione una habitacion a reservar'
                    }
                }
            },
            idcliente: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione un cliente que solicita reservar'
                    }
                }
            },
            tiporeserva: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione el tipo de la reserva'
                    }
                }
            },
            fechareserva: {
                validators: {
                    notEmpty: {
                        message: 'La fecha de reserva es requerida'
                    }
                }
            },
            fechaingreso: {
                validators: {
                    notEmpty: {
                        message: 'La fecha de ingreso del cliente al hotel es requerida'
                    }
                }
            },
            fechasalida: {
                validators: {
                    notEmpty: {
                        message: 'La fecha de retirada del cliente del hotel es requerida'
                    }
                }
            }
            
        }
    });

/*validacion del formulario cancelar una reserva*/
    $('#form-cancelar').bootstrapValidator({

        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields: {

            estado: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione un cliente al que le cancelara su reserva'
                    }
                }
            }
        }
    });

/*validacion del formulario cancelar una reserva*/
    $('#form-habilitar').bootstrapValidator({

        message: 'Este valor no es valido',
        feedbackIcons: {

            valid: 'glyphicon glyphicon-ok',

            invalid: 'glyphicon glyphicon-remove',

            validating: 'glyphicon glyphicon-refresh'

        },
        fields: {

            estado: {
                validators: {
                    notEmpty: {
                        message: 'Seleccione una habitación, cuyo mantenimiento haya finalizado, para ponerla disponible'
                    }
                }
            }
        }
    });

    /*fin validaciones*/
});

