package com.zb_mission1.cotroller;

import com.zb_mission1.dao.HistoryDao;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/history")
public class DeleteHistoryController extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id")); // 클라이언트에서 넘어온 삭제할 항목의 ID를 추출
        HistoryDao historyDao = new HistoryDao();
        historyDao.deleteHistory(id); // HistoryDao의 deleteHistory() 메서드를 호출하여 해당 항목을 삭제

        String message = "위치 히스토리 정보가 삭제되었습니다.";
        request.setAttribute("message", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("history.jsp");
        dispatcher.forward(request, response);
    }
}
