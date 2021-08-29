/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function ()
{
    $('#estado').change(function ()
    {
        if ($(this).val() == "Dui") {
            var dato = $(this).val();
            $("#pass").show();
            $("#pass1").hide();
            $("#pass2").hide();
            $("#data").hide();

        } else if ($(this).val() == "Nit") {
            $("#pass").hide();
            $("#pass1").show();
            $("#pass2").hide();
            $("#data").hide();
        } else if ($(this).val() == "Pasaporte") {
            $("#pass").hide();
            $("#pass1").hide();
            $("#pass2").show();
            $("#data").hide();
        } else if ($(this).val() == "selected") {
            $("#pass").hide();
            $("#pass1").hide();
            $("#pass2").hide();
            $("#data").show();
        }


    });
});
