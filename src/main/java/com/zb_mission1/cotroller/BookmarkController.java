package com.zb_mission1.cotroller;

import com.zb_mission1.dao.BookmarkDao;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/bookmark")
public class BookmarkController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("modify".equals(action)) {
            modifyBookmark(request, response);
        } else if ("delete".equals(action)) {
            deleteBookmark(request, response);
        } else if ("create".equals(action)) {
            createBookmark(request, response);
        } else if ("wifiadd".equals(action)) {
            wifiAdd(request, response);
        } else if ("joindelete".equals(action)) {
            joinDelete(request, response);
        }
    }

    private void joinDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int joinId = Integer.parseInt(request.getParameter("id"));

        BookmarkDao bookmarkDao = new BookmarkDao();
        bookmarkDao.joinDelete(joinId);

        String message = "북마크 정보가 삭제되었습니다.";
        request.setAttribute("message", message);

        RequestDispatcher dispatcher = request.getRequestDispatcher("bookmarkview.jsp");
        dispatcher.forward(request, response);
    }

    private void wifiAdd(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String groupName = request.getParameter("bookmarkGroup");
        String wifiNo = request.getParameter("mgr_no");

        BookmarkDao bookmarkDao = new BookmarkDao();
        bookmarkDao.wifiToBookmark(groupName, wifiNo);

        String message = "북마크 정보가 추가되었습니다.";
        request.setAttribute("message", message);

        RequestDispatcher dispatcher = request.getRequestDispatcher("bookmarkview.jsp");
        dispatcher.forward(request, response);
    }

    protected void createBookmark(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String num = request.getParameter("num");

        BookmarkDao bookmarkDao = new BookmarkDao();
        bookmarkDao.saveBookmarkGroup(name, num);

        String message = "북마크 그룹 정보가 추가되었습니다.";
        request.setAttribute("message", message);

        RequestDispatcher dispatcher = request.getRequestDispatcher("bookmarkgroup.jsp");
        dispatcher.forward(request, response);
    }

    protected void modifyBookmark(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String num = request.getParameter("num");

        // 즐겨찾기 수정 처리

        BookmarkDao bookmarkDao = new BookmarkDao();
        bookmarkDao.modifyBookmark(name, num, id);

        String message = "북마크 그룹 정보가 수정되었습니다.";
        request.setAttribute("message", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("bookmarkgroup.jsp");
        dispatcher.forward(request, response);
    }

    protected void deleteBookmark(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        // 즐겨찾기 삭제 처리
        BookmarkDao bookmarkDao = new BookmarkDao();
        bookmarkDao.deleteBookmarkGroup(id);

        String message = "북마크 그룹 정보가 삭제되었습니다.";
        request.setAttribute("message", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("bookmarkgroup.jsp");
        dispatcher.forward(request, response);
    }
}
