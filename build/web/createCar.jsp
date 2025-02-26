<%-- 
    Document   : createCar
    Created on : 18 feb. 2025, 19:13:22
    Author     : Samuel
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="app.helper.pckg.databaseHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="app.model.pckg.Car"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<% 
   // Conectar a la base de datos para recuperar datos dinámicos
   Connection conn = null;
   Statement stmt = null;
   ResultSet rsBrands = null;
   ResultSet rsModels = null;
   ResultSet rsFuelTypes = null;

   try {
       Class.forName("com.mysql.cj.jdbc.Driver");
       conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mi_base", "usuario", "contraseña");
       stmt = conn.createStatement();

       // Consultas para obtener datos de marcas, modelos y tipos de combustible
       String queryBrands = "SELECT * FROM Brands";
       String queryModels = "SELECT * FROM Models";
       String queryFuelTypes = "SELECT * FROM FuelType";

       rsBrands = stmt.executeQuery(queryBrands);
       rsModels = stmt.executeQuery(queryModels);
       rsFuelTypes = stmt.executeQuery(queryFuelTypes);
   } catch (Exception e) {
       out.println("Error al conectar a la base de datos: " + e.getMessage());
   } finally {
       try {
           if (rsBrands != null) rsBrands.close();
           if (rsModels != null) rsModels.close();
           if (rsFuelTypes != null) rsFuelTypes.close();
           if (stmt != null) stmt.close();
           if (conn != null) conn.close();
       } catch (Exception e) {
           e.printStackTrace();
       }
   }
%>

<!-- Formulario para ingresar datos del carro -->
<form action="createCarLogic.jsp">
    <!-- Selección de marca -->
    <div class="mb-3">
        <select name="selBrand" class="form-select" aria-label="Select your brand">
            <option selected>Select your brand</option>
            <% 
                while (rsBrands.next()) {
                    String brandName = rsBrands.getString("brand_name");
            %>
            <option value="<%= brandName %>"><%= brandName %></option>
            <% 
                }
            %>
        </select>
    </div>

    <!-- Selección de modelo -->
    <div class="mb-3">
        <select name="selModel" class="form-select" aria-label="Select your model">
            <option selected>Select your model</option>
            <% 
                while (rsModels.next()) {
                    String modelName = rsModels.getString("model_name");
            %>
            <option value="<%= modelName %>"><%= modelName %></option>
            <% 
                }
            %>
        </select>
    </div>

    <!-- Selección de tipo de combustible -->
    <div class="mb-3">
        <select name="selFuelType" class="form-select" aria-label="Select your fuel type">
            <option selected>Select your fuel type</option>
            <% 
                while (rsFuelTypes.next()) {
                    String fuelType = rsFuelTypes.getString("fuel_type");
            %>
            <option value="<%= fuelType %>"><%= fuelType %></option>
            <% 
                }
            %>
        </select>
    </div>

    <!-- Resto del formulario -->
    <div class="mb-3">
        <select name="selYear" class="form-select" aria-label="Select your manufacture year">
            <option selected>Select your manufacture year</option>
            <option value="2024">2024</option>
            <option value="2023">2023</option>
            <option value="2022">2022</option>
            <option value="2021">2021</option>
            <option value="2020">2020</option>
            <option value="2019">2019</option>
        </select>
    </div>

    <div class="mb-3">
        <label for="txtColor" class="form-label">Color</label>
        <input type="text" class="form-control" name="txtColor">
    </div>

    <div class="mb-3">
        <label for="txtEngine" class="form-label">CC Engine</label>
        <input type="number" class="form-control" name="txtEngine">
    </div>

    <div class="mb-3">
        <label for="txtMileage" class="form-label">Mileage</label>
        <input type="number" class="form-control" name="txtMileage">
    </div>

    <button type="submit" class="btn btn-primary">Save</button>
</form>
