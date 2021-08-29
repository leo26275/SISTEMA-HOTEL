<%-- 
    Document   : tablaconsumo
    Created on : 20/04/2019, 10:37:53 AM
    Author     : Sony
--%>

<%@page import="Adicionales.Totales"%>
<%@page import="java.util.List"%>
<%@page import="modelo.entidad.Consumo"%>
<%
    Totales tot=new Totales();
%>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Listado de Cosumos de Reservas no Pagadas</h3>
                </div>
                <hr>
                <!-- /.box-header -->
                <div class="box-body">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th style="display: none;">Reserva</th>
                                <th>Cliente</th>
                                <th>Producto</th>
                                <th>Cantidad</th>
                                <th>Precio</th>
                                <th>Total</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Consumo> lstconsumo = (List<Consumo>) request.getAttribute("listaconsumo");
                                for (Consumo con : lstconsumo) {
                            %>
                            <tr>
                                <td style="display: none;"><%= con.getReserva().getIdreserva()%></td>
                                <td><%= con.getReserva().getClientes().getNombres() + " " + con.getReserva().getClientes().getApellidos()%></td>
                                <td><%= con.getProducto().getNombre()%></td>
                                <td><%= con.getCantidad()%></td>
                                <td><%= con.getProducto().getPrecioventa()%></td>
                                <td><%= con.total()%></td>
                                <td>
                                    <a name="editar" href="ModificarConsumo.do?idconsumo=<%= con.getIdconsumo() %>" class="btn btn-success"><span class="fa fa-edit"></span></a>
                                    <a name="borrar" href="BorrarConsumo.do?idconsumo=<%= con.getIdconsumo() %>" class="btn btn-danger"><span class="fa fa-trash"></span></a>
                                </td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                    <h3 style="text-align: center;
                        padding-right: 50px;">Total Consumido por los Clientes: $ <%= tot.totalconsumido() %></h3>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->
</section>


<script src="resources/tablas/scrolltable.js" type="text/javascript"></script>
<script src="resources/tablas/datatables.net/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="resources/tablas/datatables.net-bs/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
