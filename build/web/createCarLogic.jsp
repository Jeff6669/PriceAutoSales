<%-- 
    Document   : createCarLogic
    Created on : 18 feb. 2025, 19:31:23
    Author     : Samuel
--%>

<%@page import="app.model.pckg.Car"%>
<%@page import="app.helper.pckg.databaseHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    String selBrand = request.getParameter("selBrand");
    String selModel = request.getParameter("selModel");
    String txtColor = request.getParameter("txtColor");
    String txtEngine = request.getParameter("txtEngine");
    String selFuelType = request.getParameter("selFuelType");
    String strYear = request.getParameter("selYear");
    String strMileage = request.getParameter("txtMileage");

    // Validaciones antes de procesar los datos
    if (selBrand == null || selModel == null || txtColor == null || 
        txtEngine == null || selFuelType == null || strYear == null || 
        strMileage == null || selBrand.isEmpty() || selModel.isEmpty() || 
        txtColor.isEmpty() || txtEngine.isEmpty() || selFuelType.isEmpty() || 
        strYear.isEmpty() || strMileage.isEmpty()) {

        RequestDispatcher rd = request.getRequestDispatcher("errorHandler?message=Missing required fields");
        rd.forward(request, response);
        return;
    }

    int selYear, txtMileage;
    try {
        selYear = Integer.parseInt(strYear);
        txtMileage = Integer.parseInt(strMileage);

        if (selYear <= 1885 || selYear > 2050 || txtMileage < 0) { // Año del primer automóvil real: 1885
            RequestDispatcher rd = request.getRequestDispatcher("errorHandler?message=Invalid year or mileage");
            rd.forward(request, response);
            return;
        }
    } catch (NumberFormatException e) {
        RequestDispatcher rd = request.getRequestDispatcher("errorHandler?message=Year and mileage must be numbers");
        rd.forward(request, response);
        return;
    }

    databaseHelper database = new databaseHelper();


    
    try {
        if (database.saveCar(new Car(selBrand, selModel, selYear, txtColor, txtEngine, selFuelType, txtMileage, ""))) {
            RequestDispatcher rd = request.getRequestDispatcher("carsServlet");
            rd.forward(request, response);
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("errorHandler?message=Car could not be saved");
            rd.forward(request, response);
        }
    } catch (Exception e) {
        RequestDispatcher rd = request.getRequestDispatcher("errorHandler?message=Database error: " + e.getMessage());
        rd.forward(request, response);
    }
%>