package com.zb_mission1.cotroller;

import com.zb_mission1.dao.WifiDao;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/openApi")
public class WifiController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        WifiDao wifiDao = new WifiDao();
        wifiDao.deleteDb();
        int totalList = wifiDao.insertDB();

        request.setAttribute("totalList", totalList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/openApi.jsp");
        dispatcher.forward(request, response);
    }
}
