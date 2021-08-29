<%@page import="modelo.entidad.Categoria"%>
<%@page import="java.util.List"%>
<table id="example1" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th style="display: none;">id Categoria</th>
                                                <th>Categoria</th>
                                                <th>Acciones</th>
                                                <th>Mensaje</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Categoria> lstCategoria = (List<Categoria>) request.getAttribute("listaDeCategorias");

                                                for (Categoria c : lstCategoria) {
                                            %>
                                            <tr>
                                                <td style="display: none;"><%= c.getIdcategoria()%></td><!--ocultamos el id de la columna a eliminar-->
                                                <td><%= c.getNombre()%></td>
                                                <td>
                                                    <a href="#" class="btn btn-success btnEditar"><span class="fa fa-edit"></span></a>
                                                    <a href="#" class="btn btn-danger btnBorrar"><span class="fa fa-trash"></span></a>
                                                </td>
                                                <td>
                                                    <span class="badge badge-pill badge-warning">Eliminable</span>
                                                </td>
                                            </tr>
                                            <%}%>
                                        </tbody>
                                    </table>